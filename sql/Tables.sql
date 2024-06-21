-- Criação da tabela Usuário
CREATE TABLE Usuario (
    usuario_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(100) NOT NULL
);

-- Criação da tabela TipoDocumento
CREATE TABLE TipoDocumento (
    tipo_id SERIAL PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL
);

-- Criação da tabela Categoria
CREATE TABLE Categoria (
    categoria_id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- Criação da tabela Documento
CREATE TABLE Documento (
    documento_id SERIAL PRIMARY KEY,
    arquivo_nome VARCHAR(255),
    titulo VARCHAR(200) NOT NULL,
    conteudo TEXT NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_id INTEGER NOT NULL,
    tipo_id INTEGER NOT NULL,
    arquivo BYTEA,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (tipo_id) REFERENCES TipoDocumento(tipo_id)
);

-- Criação da tabela DocumentoCategoria (tabela de associação)
CREATE TABLE DocumentoCategoria (
    documento_id INTEGER NOT NULL,
    categoria_id INTEGER NOT NULL,
    PRIMARY KEY (documento_id, categoria_id),
    FOREIGN KEY (documento_id) REFERENCES Documento(documento_id) ON DELETE CASCADE,
    FOREIGN KEY (categoria_id) REFERENCES Categoria(categoria_id)
);


-- Criação da tabela Permissão
CREATE TABLE Permissao (
    permissao_id SERIAL PRIMARY KEY,
    documento_id INTEGER NOT NULL,
    usuario_id INTEGER NOT NULL,
    nivel VARCHAR(50) NOT NULL,
    FOREIGN KEY (documento_id) REFERENCES Documento(documento_id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id)
);

-- Criação da tabela LogAcesso
CREATE TABLE LogAcesso (
    log_id SERIAL PRIMARY KEY,
    documento_id INTEGER NOT NULL,
    usuario_id INTEGER NOT NULL,
    data_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (documento_id) REFERENCES Documento(documento_id) ON DELETE CASCADE,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id)
);