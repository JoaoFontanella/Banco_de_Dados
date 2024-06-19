CREATE OR REPLACE FUNCTION get_documentos_por_usuario(p_usuario_id INTEGER)
RETURNS TABLE (
    documento_id INTEGER,
    nome VARCHAR(200),
    titulo VARCHAR(200),
    conteudo TEXT,
    data_criacao TIMESTAMP
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.documento_id,
        d.nome,
        d.titulo,
        d.conteudo,
        d.data_criacao
    FROM Documento d
    WHERE d.usuario_id = p_usuario_id;
END; $$
LANGUAGE plpgsql;

-------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION verificar_permissao(p_documento_id INTEGER, p_usuario_id INTEGER)
RETURNS VARCHAR(50) AS $$
DECLARE
    nivel_permissao VARCHAR(50);
BEGIN
    SELECT p.nivel
    INTO nivel_permissao
    FROM Permissao p
    WHERE p.documento_id = p_documento_id AND p.usuario_id = p_usuario_id;

    IF nivel_permissao IS NULL THEN
        RETURN 'Sem Permissão';
    ELSE
        RETURN nivel_permissao;
    END IF;
END; $$
LANGUAGE plpgsql;

----------------------------------------------------------------------------------------------

-- Criação da função para adicionar permissão a um documento
CREATE OR REPLACE FUNCTION adicionar_permissao(
    p_documento_id INTEGER,
    p_usuario_id INTEGER,
    p_nivel VARCHAR(50)
) RETURNS VOID AS $$
BEGIN
    -- Verifica se a permissão já existe
    IF EXISTS (
        SELECT 1
        FROM Permissao
        WHERE documento_id = p_documento_id
          AND usuario_id = p_usuario_id
    ) THEN
        -- Atualiza a permissão existente
        UPDATE Permissao
        SET nivel = p_nivel
        WHERE documento_id = p_documento_id
          AND usuario_id = p_usuario_id;
    ELSE
        -- Insere uma nova permissão
        INSERT INTO Permissao (documento_id, usuario_id, nivel)
        VALUES (p_documento_id, p_usuario_id, p_nivel);
    END IF;
END; $$
LANGUAGE plpgsql;