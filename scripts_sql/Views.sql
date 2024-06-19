CREATE OR REPLACE VIEW vw_logs_acesso_detalhados AS
SELECT 
    la.log_id,
    u.nome AS usuario_nome,
    d.nome AS documento_nome,
    d.titulo,
    la.data_acesso
FROM 
    LogAcesso la
JOIN 
    Usuario u ON la.usuario_id = u.usuario_id
JOIN 
    Documento d ON la.documento_id = d.documento_id;

------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_documentos_categorias AS
SELECT 
    d.documento_id,
    d.nome AS documento_nome,
    d.titulo,
    d.data_criacao,
    c.nome AS categoria_nome
FROM 
    Documento d
JOIN 
    DocumentoCategoria dc ON d.documento_id = dc.documento_id
JOIN 
    Categoria c ON dc.categoria_id = c.categoria_id;

------------------------------------------------------------------------------------------------

CREATE OR REPLACE VIEW vw_documentos_criadores AS
SELECT 
    d.documento_id,
    d.nome AS documento_nome,
    d.titulo,
    d.conteudo,
    d.data_criacao,
    u.usuario_id,
    u.nome AS usuario_nome,
    u.email AS usuario_email
FROM 
    Documento d
JOIN 
    Usuario u ON d.usuario_id = u.usuario_id;
