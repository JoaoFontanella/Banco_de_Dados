-- Inserção de dados na tabela Usuario
INSERT INTO Usuario (nome, email, senha) VALUES
('Alice Silva', 'alice.silva@gmail.com', 'senha123'),
('Bruno Pereira', 'bruno.pereira@gmail.com', 'senha456'),
('Carla Souza', 'carla.souza@gmail.com', 'senha789'),
('Daniel Fernandes', 'daniel.fernandes@gmail.com', 'senha321'),
('Elisa Costa', 'elisa.costa@gmail.com', 'senha654');

-- Inserção de dados na tabela TipoDocumento
INSERT INTO TipoDocumento (descricao,tipo) VALUES
('Relatório','pdf'),
('Contrato','pdf'),
('Memorando','pdf'),
('Fatura','pdf'),
('Plano de Projeto','pdf');

-- Inserção de dados na tabela Categoria
INSERT INTO Categoria (nome) VALUES
('Financeiro'),
('RH'),
('TI'),
('Marketing'),
('Vendas');

-- Inserção de dados na tabela Documento
INSERT INTO Documento (titulo, conteudo, usuario_id, tipo_id) VALUES
('Relatório Anual 2023', 'Conteúdo do relatório anual de 2023', 1, 1),
('Contrato de Prestação de Serviços', 'Detalhes do contrato de prestação de serviços', 2, 2),
('Memorando Interno', 'Instruções internas sobre novo procedimento', 3, 3),
('Fatura de Serviços de TI', 'Detalhes da fatura dos serviços de TI', 4, 4),
('Plano de Projeto Alpha', 'Detalhes do plano de projeto Alpha', 5, 5);

-- Inserção de dados na tabela DocumentoCategoria
INSERT INTO DocumentoCategoria (documento_id, categoria_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 5), 
(2, 1); 

-- Inserção de dados na tabela Permissao
INSERT INTO Permissao (documento_id, usuario_id, nivel) VALUES
(1, 1, 'escrita'),
(2, 2, 'escrita'),
(3, 3, 'escrita'),
(4, 4, 'escrita'),
(5, 5, 'escrita'),
(1, 2, 'escrita'), 
(2, 1, 'escrita');  

-- Inserção de dados na tabela LogAcesso
INSERT INTO LogAcesso (documento_id, usuario_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(1, 2),  
(2, 1);  