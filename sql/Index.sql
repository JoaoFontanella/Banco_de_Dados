-- Índices para a Tabela Usuario
CREATE INDEX idx_usuario_nome ON Usuario(nome);
CREATE INDEX idx_usuario_email ON Usuario(email);

-- Índices para a Tabela TipoDocumento
CREATE INDEX idx_tipodocumento_descricao ON TipoDocumento(descricao);
CREATE INDEX idx_tipodocumento_tipo ON TipoDocumento(tipo);

-- Índices para a Tabela Categoria
CREATE INDEX idx_categoria_nome ON Categoria(nome);

-- Índices para a Tabela Documento
CREATE INDEX idx_documento_titulo ON Documento(titulo);
CREATE INDEX idx_documento_usuario_id ON Documento(usuario_id);
CREATE INDEX idx_documento_tipo_id ON Documento(tipo_id);

-- Índices para a Tabela DocumentoCategoria
CREATE INDEX idx_documentocategoria_documento_id ON DocumentoCategoria(documento_id);
CREATE INDEX idx_documentocategoria_categoria_id ON DocumentoCategoria(categoria_id);

-- Índices para a Tabela Permissao
CREATE INDEX idx_permissao_documento_id ON Permissao(documento_id);
CREATE INDEX idx_permissao_usuario_id ON Permissao(usuario_id);

-- Índices para a Tabela LogAcesso
CREATE INDEX idx_logacesso_documento_id ON LogAcesso(documento_id);
CREATE INDEX idx_logacesso_usuario_id ON LogAcesso(usuario_id);
CREATE INDEX idx_logacesso_data_acesso ON LogAcesso(data_acesso);