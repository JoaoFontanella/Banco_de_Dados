--Função count_documents_by_category
CREATE OR REPLACE FUNCTION count_documents_by_category(p_categoria_id INTEGER)
RETURNS INTEGER AS $$
DECLARE
    total_documents INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO total_documents
    FROM DocumentoCategoria
    WHERE categoria_id = p_categoria_id;

    RETURN total_documents;
END;
$$ LANGUAGE plpgsql;



SELECT count_documents_by_category(1);

-------------------------------------------------------------------------------------------------------
--Obter o nome de um usuário pelo ID
CREATE OR REPLACE FUNCTION get_user_name(user_id INTEGER)
RETURNS VARCHAR(100) AS $$
DECLARE
    user_name VARCHAR(100);
BEGIN
    SELECT nome INTO user_name
    FROM Usuario
    WHERE usuario_id = user_id;
    
    RETURN user_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
$$ LANGUAGE plpgsql;



SELECT get_user_name(1);

----------------------------------------------------------------------------------------------
--Função count_permissions_by_user
CREATE OR REPLACE FUNCTION count_permissions_by_user(p_usuario_id INTEGER)
RETURNS INTEGER AS $$
DECLARE
    total_permissions INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO total_permissions
    FROM Permissao
    WHERE usuario_id = p_usuario_id;

    RETURN total_permissions;
END;
$$ LANGUAGE plpgsql;



SELECT count_permissions_by_user(1);