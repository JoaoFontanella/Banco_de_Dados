--Quais são os documentos criados pelo usuário com o nome "Bruno Pereira"?
SELECT d.documento_id, d.titulo, u.nome AS nome_usuario
FROM Documento d
JOIN Usuario u ON d.usuario_id = u.usuario_id
WHERE u.nome = 'Bruno Pereira';

---------------------------------------------
--Quais são os documentos que pertencem à categoria "Financeiro"?
SELECT d.documento_id, d.titulo, c.nome AS nome_categoria
FROM Documento d
JOIN DocumentoCategoria dc ON d.documento_id = dc.documento_id
JOIN Categoria c ON dc.categoria_id = c.categoria_id
WHERE c.nome = 'Financeiro';

----------------------------------------------
--Qual é o tipo de documento mais utilizado na base de dados?
SELECT td.tipo_id, td.descricao, COUNT(d.documento_id) AS quantidade_documentos
FROM Documento d
JOIN TipoDocumento td ON d.tipo_id = td.tipo_id
GROUP BY td.tipo_id, td.descricao
ORDER BY quantidade_documentos DESC
LIMIT 1;

------------------------------------------------
--Quais são os documentos que foram acessados mais recentemente?
SELECT d.documento_id, d.titulo, la.data_acesso
FROM Documento d
JOIN LogAcesso la ON d.documento_id = la.documento_id
ORDER BY la.data_acesso DESC
LIMIT 10;

------------------------------------------------------
--Quantos documentos foram criados por cada usuário?
SELECT u.usuario_id, u.nome AS nome_usuario, COUNT(d.documento_id) AS quantidade_documentos
FROM Usuario u
LEFT JOIN Documento d ON u.usuario_id = d.usuario_id
GROUP BY u.usuario_id, u.nome
ORDER BY quantidade_documentos DESC;
