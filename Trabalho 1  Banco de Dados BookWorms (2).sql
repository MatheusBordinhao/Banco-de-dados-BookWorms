CREATE DATABASE AV1BookWorms;
use AV1BookWorms;

-- Criação da Tabela de Livros
CREATE TABLE Livros (
    ISBN VARCHAR(13) PRIMARY KEY,
    Titulo VARCHAR(100),
    Autor VARCHAR(50),
    Genero VARCHAR(50),
    AnoPublicacao INT,
    Preco DECIMAL(10,2),
    QuantidadeEstoque INT
);

-- Criação da Tabela de Usuários
CREATE TABLE Usuarios (
    UserID INT PRIMARY KEY,
    Nome VARCHAR(50),
    Email VARCHAR(100),
    DataNascimento DATE,
    Cidade VARCHAR(50),
    Estado VARCHAR(2),
    CEP VARCHAR(9)
);

-- Criação da Tabela de Compras
CREATE TABLE Compras (
    CompraID INT PRIMARY KEY,
    UserID INT,
    ISBN VARCHAR(13),
    DataCompra DATE,
    Quantidade INT,
    ValorTotal DECIMAL(10,2),
    FOREIGN KEY (UserID) REFERENCES Usuarios(UserID),
    FOREIGN KEY (ISBN) REFERENCES Livros(ISBN)
);

-- Criação da Tabela de Avaliações
CREATE TABLE Avaliacoes (
    AvaliacaoID INT PRIMARY KEY,
    UserID INT,
    ISBN VARCHAR(13),
    Avaliacao INT,
    Comentario TEXT,
    FOREIGN KEY (UserID) REFERENCES Usuarios(UserID),
    FOREIGN KEY (ISBN) REFERENCES Livros(ISBN)
);
-- Criação da Tabela de Editoras
CREATE TABLE Editoras (
    Editoras_id INT PRIMARY KEY,
    NomeEditoras VARCHAR(100),
    PaisOrigem VARCHAR(50)
);
-- Adicionando a chave estrangeira na tabela Livros para se relacionar com a tabela Editoras em uma relação de 1 pra 1
ALTER TABLE Livros ADD COLUMN Editoras_id INT, ADD FOREIGN KEY (Editoras_id) REFERENCES Editoras(Editoras_id);

-- Teste para ver se a coluna foi adcionada na tabela 
SELECT * FROM Livros;

-- Criação da Tabela de Autores
CREATE TABLE Autores(
	Autores_id INT PRIMARY KEY,
    NomeAutores VARCHAR(50),
    Nacionalidade VARCHAR(50)
);
-- Criação da Tabela de Livros_Autores para relacionar a tabela Livros e Autores em uma relação de muitos para muitos
CREATE TABLE Livros_Autores (
    LivroISBN VARCHAR(13),
    Autores_id INT,
    FOREIGN KEY (LivroISBN) REFERENCES Livros(ISBN),
    FOREIGN KEY (Autores_id) REFERENCES Autores(Autores_id)
);
-- Criação da Tabela de Cidade 
CREATE TABLE Cidade(
	Cidade_id INT PRIMARY KEY,
    NomeCidade VARCHAR(50)
);

-- Criação da Tabela de Estado
CREATE TABLE Estado(
	Estado_id INT PRIMARY KEY,
    NomeEstado VARCHAR(50)
);
-- Adicionando a chave estrangeira na tabela Usuarios para se relacionar com as tabelas Cidade e Estado em uma relação de 1 pra muitos
ALTER TABLE Usuarios ADD COLUMN Cidade_id INT, ADD COLUMN Estado_id INT, 
ADD FOREIGN KEY (Cidade_id) REFERENCES Cidade(Cidade_id), ADD FOREIGN KEY (Estado_id) REFERENCES Estado(Estado_id);

-- Teste para ver se as colunas foram adcionadas na tabela 
SELECT * FROM Usuarios;

-- Alterando a culuna nome para NomeUsuario da tabela Usuario para uma padronização do Banco 
ALTER TABLE Usuarios CHANGE COLUMN Nome NomeUsuario VARCHAR(50);	

-- Obs: acho que para a atividade 2 eu poderia alterar os ID de cada tabela como por exemplo 
-- ALTER TABLE Usuarios CHANGE COLUMN UserID Usuario_id INT; para manter uma padronização
-- de todos os ID do banco mas fiquei receoso de alterar e causar algum problema nas relações do banco,
-- como por exemplo a tabela compras que tem relação com a tabela Usuarios através da chave estrangeira UserID

-- Inserindo dados na tabela Editoras
INSERT INTO Editoras (Editoras_id, NomeEditoras, PaisOrigem) VALUES
(1, 'Pearson', 'Reino Unido'),
(2, 'Bertelsmann', 'Alemanha'),
(3, 'Darkside', 'Brasil');

-- Inserindo dados na tabela Autores
INSERT INTO Autores (Autores_id, NomeAutores, Nacionalidade) VALUES
(1, 'Iñaki Godoy', 'Mexicano'),
(2, 'Emily Rudd', 'Americana'),
(3, 'J.J. Jr. Mackenyu', 'Japonês');

-- Inserindo dados na tabela Cidade
INSERT INTO Cidade (Cidade_id, NomeCidade) VALUES
(1, 'Sapucaia do Sul'),
(2, 'Bombinhas'),
(3, 'Osasco');

-- Inserindo dados na tabela Estado
INSERT INTO Estado (Estado_id, NomeEstado) VALUES
(1, 'Rio Grande do Sul'),
(2, 'Santa Catarina'),
(3, 'São Paulo');


-- Inserindo um valor de ISBN na tabela Livros
INSERT INTO Livros(ISBN) VALUES('9788533302273');

-- Inserindo o preço de um livro da tabela Livros que possui um ISBN específico
UPDATE Livros SET Preco = 8 WHERE ISBN = '9788533302273';

-- Inserindo os valores na tabela Usuarios
INSERT INTO Usuarios (UserID, NomeUsuario, Email, DataNascimento, Cidade, Estado, CEP)
VALUES (1, 'Matheus', 'matheus@email.com', '2006-09-27', 'Sapucaia', 'RS', '83269-453');

-- inserindo os valores na tabela Compras que está relacionada com as tabelas Usuario e Livros
INSERT INTO Compras (CompraID, UserID, ISBN, DataCompra, Quantidade, ValorTotal)
VALUES (1, 1, '9788533302273', '2022-02-17', 2, 40);

-- inserindo os valores na tabela Avaliacoes que está relacionada com as tabelas Usuario e Livros
INSERT INTO Avaliacoes (AvaliacaoID, UserID, ISBN, Avaliacao, Comentario)
VALUES (1, 1, '9788533302273', 9, 'Ótimo livro');

-- Deletando todas as colunas da Tabela Compras na qual o ID do usuario seja igual a 1 
DELETE FROM Compras WHERE UserID = 1;

-- Deletando todas as colunas da Tabela Avaliacoes na qual o ID do usuario seja igual a 1 
DELETE FROM Avaliacoes WHERE UserID = 1;

-- Deletanado um usuario da tabela Usuario que tenha um ID igual a 1
DELETE FROM Usuarios WHERE UserID = 1;

-- Inserindo a coluna ISBN na tabela Editorias para uma relação 1 pra muitos entre as tabelas Livros e Editoras
ALTER TABLE Editoras ADD COLUMN ISBN VARCHAR(13), ADD FOREIGN KEY (ISBN) REFERENCES Livros(ISBN);

-- Inserindo os valores na tabela Livros 
INSERT INTO Livros( ISBN, Titulo, Autor, Genero, AnoPublicacao, Preco, QuantidadeEstoque) VALUE 
('9788533302274', 'O Pequeno Príncipe', 'Antoine de Saint-Exupéry', 'Literatura infantil', 1943, 19, 50);

-- inserindo os valores na tabela Editoras que está relacionada com a tabela Livro
INSERT INTO Editoras ( Editoras_id, NomeEditoras, PaisOrigem, ISBN) 
VALUES (4, 'Companhia da Letras','Brasil', '9788533302274');

-- Selecioando todos os valores da tabela Livro através do nome de uma editora
SELECT * FROM Livros WHERE ISBN = (SELECT ISBN FROM Editoras WHERE NomeEditoras = 'Companhia da Letras');

-- Adcionando a coluna Status na tabela Compras para saber se foi concluida ou nao a compra do livro
ALTER TABLE Compras ADD COLUMN Status VARCHAR(25);

-- Atualizando as informações da tabela Compras para marcar como concluido o Status do Livro que possui o ID igual a 1
UPDATE Compras SET Status = 'Concluída' WHERE CompraID = 1 ;

-- Teste para ver se as informções estão corretas 
SELECT * FROM Compras;

-- Adcionando a coluna DataPublicacao na tabela Livros
ALTER TABLE Livros ADD COLUMN DataPublicacao DATE;

-- Inserindo a data de publicação do livros que possui ISBN igual a 9788533302274
UPDATE Livros SET DataPublicacao = '1943-04-06' WHERE ISBN = '9788533302274' ;

-- Inserindo um segundo usuario no banco 
INSERT INTO Usuarios (UserID, NomeUsuario, Email, DataNascimento, Cidade, Estado, CEP)
VALUES (2, 'Isadora', 'isadora@email.com', '2007-09-14', 'Sapucaia', 'RS', '58042-864');

-- Inserindo as Avaliacoes desse segundo usuario
INSERT INTO Avaliacoes (AvaliacaoID, UserID, ISBN, Avaliacao, Comentario)
VALUES (2, 2, '9788533302274', 9, 'Um livro Excelente');

-- Selecionado todas as Avaliacoes do Livro através de sua ISBN e ordenando por DataPublicacao
SELECT * FROM Avaliacoes WHERE ISBN = '9788533302274' ORDER BY DataPublicacao;

-- Inserindo um terceiro usuario no banco 
INSERT INTO Usuarios (UserID, NomeUsuario, Email, DataNascimento, Cidade, Estado, CEP)
VALUES (3, 'Rodrigo', 'rodrigo@email.com', '1982-06-29', 'Sapucaia', 'RS', '94825-273');

-- Inserindo as informações das Compras desse terceiro usuario
INSERT INTO Compras (CompraID, UserID, ISBN, DataCompra, Quantidade, ValorTotal)
VALUES (3, 3, '9788533302274', '2020-05-15', 3, 60);

-- Deletando o terceiro usuario do banco 
DELETE FROM Usuarios WHERE UserID = 3;

-- Deletando todas iformações de Compras do terceiro usuario
DELETE FROM Compras  WHERE UserID = 3 AND Status IS NULL;

-- Teste para ver se os dados foram excluídos
SELECT * FROM Compras;

-- Acionando os ID de Cidade e Estado na tabela Usuarios
UPDATE Usuarios SET Cidade_id = 1 WHERE UserID = 1 ;
UPDATE Usuarios SET Estado_id = 1 WHERE UserID = 1 ;
UPDATE Usuarios SET Cidade_id = 1 WHERE UserID = 2 ;
UPDATE Usuarios SET Estado_id = 1 WHERE UserID = 2 ;

-- Selecionado os Nomes de todos os Usuarios que moram em uma determinada cidade
SELECT NomeUsuario FROM Usuarios WHERE Cidade_id = (SELECT Cidade_id FROM Cidade WHERE NomeCidade = 'Sapucaia do Sul');