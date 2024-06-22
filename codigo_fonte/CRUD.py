import tkinter as tk
from tkinter import messagebox, filedialog
import psycopg2
from datetime import datetime

# Função para conectar ao banco de dados PostgreSQL
def connect_db():
    return psycopg2.connect(
        dbname="ged",
        user="postgres",
        password="123",
        host="localhost",
        port="5432"
    )

# Variável global para armazenar o caminho do arquivo
file_path = None

# Função para selecionar um arquivo
def select_file():
    global file_path
    file_path = filedialog.askopenfilename()
    if file_path:
        lbl_file_path.config(text=f"Arquivo selecionado: {file_path.split('/')[-1]}")

# Função para obter o próximo ID de documento disponível
def get_next_document_id():
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT MAX(documento_id) FROM Documento")
        max_id = cursor.fetchone()[0]
        next_id = max_id + 1 if max_id else 1
    except Exception as e:
        messagebox.showerror("Erro", str(e))
        next_id = None
    finally:
        cursor.close()
        conn.close()
    return next_id

# Função para preencher o próximo ID de documento no campo de entrada
def fill_next_document_id():
    next_id = get_next_document_id()
    if next_id:
        entry_documento_id.delete(0, tk.END)
        entry_documento_id.insert(tk.END, next_id)

# Função para adicionar um documento
def add_documento():
    global file_path
    try:
        conn = connect_db()
        cursor = conn.cursor()
        
        if file_path:
            with open(file_path, 'rb') as file:
                file_data = file.read()
            cursor.execute(
                "INSERT INTO Documento (arquivo_nome, titulo, conteudo, usuario_id, tipo_id, arquivo) VALUES (%s, %s, %s, %s, %s, %s)",
                (file_path.split('/')[-1], entry_titulo.get(), entry_conteudo.get("1.0", tk.END), entry_usuario_id.get(), entry_tipo_id.get(), file_data)
            )
        else:
            cursor.execute(
                "INSERT INTO Documento (titulo, conteudo, usuario_id, tipo_id) VALUES (%s, %s, %s, %s)",
                (entry_titulo.get(), entry_conteudo.get("1.0", tk.END), entry_usuario_id.get(), entry_tipo_id.get())
            )
        conn.commit()
        messagebox.showinfo("Sucesso", "Documento adicionado com sucesso!")
        file_path = None
        lbl_file_path.config(text="")
        fill_next_document_id()
    except Exception as e:
        messagebox.showerror("Erro", str(e))
    finally:
        cursor.close()
        conn.close()

# Função para ler documentos
def read_documento():
    try:
        conn = connect_db()
        cursor = conn.cursor()
        cursor.execute("SELECT documento_id, arquivo_nome, titulo, conteudo, data_criacao, usuario_id, tipo_id FROM Documento")
        records = cursor.fetchall()
        listbox.delete(0, tk.END)
        for record in records:
            listbox.insert(tk.END, record)
    except Exception as e:
        messagebox.showerror("Erro", str(e))
    finally:
        cursor.close()
        conn.close()

# Função para preencher os campos de entrada quando um item da lista for clicado
def on_select(event):
    try:
        selected_index = listbox.curselection()
        if selected_index:
            selected = listbox.get(selected_index)
            entry_documento_id.delete(0, tk.END)
            entry_documento_id.insert(tk.END, selected[0])
            lbl_file_path.config(text=f"Arquivo selecionado: {selected[1]}")
            entry_titulo.delete(0, tk.END)
            entry_titulo.insert(tk.END, selected[2])
            entry_conteudo.delete("1.0", tk.END)
            entry_conteudo.insert(tk.END, selected[3])
            entry_usuario_id.delete(0, tk.END)
            entry_usuario_id.insert(tk.END, selected[5])
            entry_tipo_id.delete(0, tk.END)
            entry_tipo_id.insert(tk.END, selected[6])
    except Exception as e:
        messagebox.showerror("Erro", str(e))

# Função para atualizar um documento
def update_documento():
    global file_path
    try:
        conn = connect_db()
        cursor = conn.cursor()
        
        if file_path:
            with open(file_path, 'rb') as file:
                file_data = file.read()
            cursor.execute(
                "UPDATE Documento SET arquivo_nome = %s, titulo = %s, conteudo = %s, usuario_id = %s, tipo_id = %s, arquivo = %s WHERE documento_id = %s",
                (file_path.split('/')[-1], entry_titulo.get(), entry_conteudo.get("1.0", tk.END), entry_usuario_id.get(), entry_tipo_id.get(), file_data, entry_documento_id.get())
            )
        else:
            cursor.execute(
                "UPDATE Documento SET titulo = %s, conteudo = %s, usuario_id = %s, tipo_id = %s WHERE documento_id = %s",
                (entry_titulo.get(), entry_conteudo.get("1.0", tk.END), entry_usuario_id.get(), entry_tipo_id.get(), entry_documento_id.get())
            )
        conn.commit()
        messagebox.showinfo("Sucesso", "Documento atualizado com sucesso!")
        file_path = None
        lbl_file_path.config(text="")
    except Exception as e:
        messagebox.showerror("Erro", str(e))
    finally:
        cursor.close()
        conn.close()

# Função para deletar um documento
def delete_documento():
    try:
        conn = connect_db()
        cursor = conn.cursor()
        documento_id = entry_documento_id.get()
        
        # Remover as referências nas outras tabelas
        cursor.execute("DELETE FROM DocumentoCategoria WHERE documento_id = %s", (documento_id,))
        cursor.execute("DELETE FROM Permissao WHERE documento_id = %s", (documento_id,))
        cursor.execute("DELETE FROM LogAcesso WHERE documento_id = %s", (documento_id,))
        
        # Agora deletar o documento
        cursor.execute("DELETE FROM Documento WHERE documento_id = %s", (documento_id,))
        conn.commit()
        messagebox.showinfo("Sucesso", "Documento deletado com sucesso!")
        fill_next_document_id()
    except Exception as e:
        messagebox.showerror("Erro", str(e))
    finally:
        cursor.close()
        conn.close()

# Interface gráfica
root = tk.Tk()
root.title("CRUD Documentos")

tk.Label(root, text="Documento ID").grid(row=0, column=0)
entry_documento_id = tk.Entry(root)
entry_documento_id.grid(row=0, column=1)

tk.Label(root, text="Título").grid(row=1, column=0)
entry_titulo = tk.Entry(root)
entry_titulo.grid(row=1, column=1)

tk.Label(root, text="Conteúdo").grid(row=2, column=0)
entry_conteudo = tk.Text(root, height=5, width=30)
entry_conteudo.grid(row=2, column=1)

tk.Label(root, text="Usuário ID").grid(row=3, column=0)
entry_usuario_id = tk.Entry(root)
entry_usuario_id.grid(row=3, column=1)

tk.Label(root, text="Tipo ID").grid(row=4, column=0)
entry_tipo_id = tk.Entry(root)
entry_tipo_id.grid(row=4, column=1)

tk.Button(root, text="Selecionar Arquivo", command=select_file).grid(row=5, column=0)
lbl_file_path = tk.Label(root, text="")
lbl_file_path.grid(row=5, column=1, columnspan=3)

tk.Button(root, text="Adicionar", command=add_documento).grid(row=6, column=0)
tk.Button(root, text="Documentos", command=read_documento).grid(row=6, column=1)
tk.Button(root, text="Editar", command=update_documento).grid(row=6, column=2)
tk.Button(root, text="Deletar", command=delete_documento).grid(row=6, column=3)

listbox = tk.Listbox(root, height=10, width=80)
listbox.grid(row=7, column=0, columnspan=4)
listbox.bind('<<ListboxSelect>>', on_select)

fill_next_document_id() 

root.mainloop()