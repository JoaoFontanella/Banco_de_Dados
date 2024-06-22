-- Função para atualizar a data de modificação
CREATE OR REPLACE FUNCTION atualizar_data_modificacao()
RETURNS TRIGGER AS $$
BEGIN
    NEW.data_modificacao = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------
-- Trigger para atualizar a data de modificação
CREATE TRIGGER trigger_atualizar_data_modificacao
BEFORE UPDATE ON Documento
FOR EACH ROW
EXECUTE FUNCTION atualizar_data_modificacao();
----------------------------------------------------------------------
-- Teste da trigger
--Ja com os inserts dados na tabela documento é so executar o comando abaixo
-- Atualizar o documento inserido
UPDATE Documento
SET titulo = 'Título Atualizado'
WHERE documento_id = 1;

--depois

-- Verificar a atualização do campo data_modificacao
SELECT documento_id, data_modificacao
FROM Documento
WHERE documento_id = 1;


