--View para Listar Documentos com Informações Completas
CREATE OR REPLACE VIEW vw_documentos_completos AS
SELECT d.documento_id, d.arquivo_nome, d.titulo, d.conteudo, d.data_criacao, u.nome AS nome_usuario, td.descricao AS tipo_documento, dc.categoria_id, c.nome AS nome_categoria
FROM Documento d
JOIN Usuario u ON d.usuario_id = u.usuario_id
JOIN TipoDocumento td ON d.tipo_id = td.tipo_id
LEFT JOIN DocumentoCategoria dc ON d.documento_id = dc.documento_id
LEFT JOIN Categoria c ON dc.categoria_id = c.categoria_id;


SELECT * FROM vw_documentos_completos;
------------------------------------------------------------------------------------------------
--View para Listar Documentos com Permissões Associadas
CREATE OR REPLACE VIEW vw_documentos_com_permissao AS
SELECT d.documento_id, d.titulo, d.conteudo, u.nome AS nome_usuario, p.nivel
FROM Documento d
JOIN Usuario u ON d.usuario_id = u.usuario_id
JOIN Permissao p ON d.documento_id = p.documento_id;


SELECT * FROM vw_documentos_com_permissao;
------------------------------------------------------------------------------------------------
--View para Listar Acessos Recentes aos Documentos
CREATE OR REPLACE VIEW vw_acessos_recentes AS
SELECT l.log_id, l.documento_id, d.titulo AS titulo_documento, u.nome AS nome_usuario, l.data_acesso
FROM LogAcesso l
JOIN Documento d ON l.documento_id = d.documento_id
JOIN Usuario u ON l.usuario_id = u.usuario_id
ORDER BY l.data_acesso DESC;


SELECT * FROM vw_acessos_recentes;