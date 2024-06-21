--Trigger para Registrar Log de Acesso

CREATE OR REPLACE FUNCTION trig_log_acesso()
RETURNS TRIGGER AS $$
BEGIN
    PERFORM log_acesso_documento(NEW.documento_id, NEW.usuario_id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER log_acesso
AFTER INSERT ON LogAcesso
FOR EACH ROW
EXECUTE FUNCTION trig_log_acesso();
