CREATE DATABASE SUCOS_VENDAS;

DROP DATABASE SUCOS_VENDAS_2;

USE master;

DROP DATABASE SUCOS_VENDAS_2;

/*Colunas:
CPF, código de identificação do cliente;
Nome completo de cada cliente;
Endereço, um campo que será decomposto quando armazenado na base de dados;
Data de nascimento;
Idade;
Sexo;
Limite de crédito;
Limite mínimo de compra do produto;
Por fim, se o cliente já realizou alguma compra; isso informa se ele é um cliente novo ou antigo na empresa.
*/

CREATE TABLE [TABELA DE CLIENTES](

[CPF] [CHAR] (11),
[NOME] [VARCHAR] (150),
[RUA] [VARCHAR] (150),
[COMPLEMENTO] [VARCHAR] (150),
[BAIRRO] [VARCHAR] (150),
[ESTADO] [CHAR] (2),
[CEP] [CHAR] (8),
[DATA DE NASCIMENTO] [DATE],
[IDADE] [SMALLINT],
[SEXO] [CHAR] (1),
[LIMITE DE CREDITO] [MONEY],
[VOLUME MINIMO] [FLOAT],
[PRIMEIRA COMPRA] [BIT]

);

/*Colunas:
código do produto; precisa dos comandos 'not null' e 'primary key' para ter um código único e não ficar vazio
nome do produto;
embalagem;
tamanho;
sabor;
preço de lista.
*/

CREATE TABLE [TABELA DE PRODUTOS](

[CODIGO DO PRODUTO] [VARCHAR] (20) NOT NULL PRIMARY KEY, 
[NOME DO PRODUTO] [VARCHAR] (50), 
[EMBALAGEM] [VARCHAR] (50), 
[TAMANHO] [VARCHAR] (50), 
[SABOR] [VARCHAR] (50), 
[PRECO DE LISTA] [SMALLMONEY]

);

ALTER TABLE [TABELA DE CLIENTES] ALTER COLUMN [CPF] [CHAR] (11) NOT NULL;

ALTER TABLE [TABELA DE CLIENTES] ADD CONSTRAINT PK_TABELA_CLIENTE
PRIMARY KEY CLUSTERED ([CPF]);

/*
o comando SELECT * FROM [nome da tabela]; tras todos os dados daquela tabela
*/
SELECT * FROM [TABELA DE PRODUTOS]; 

SELECT * FROM [TABELA DE CLIENTES];

/*
é possível filtrar as colunas da tabela com  SELECT [nome da coluna a], [nome da coluna b] FROM [nome da tabela]; 
é possível chamar em qualquer ordem
o ORDER BY [nome da coluna] deixa na ordem selecionada, no caso de nomes, deixa em ordem alfabética
*/
SELECT [NOME], [ESTADO] FROM [TABELA DE CLIENTES];

SELECT * FROM [TABELA DE PRODUTOS] ORDER BY [NOME DO PRODUTO];

/*o AS (de ALIAS) é um 'apelido' para dar a algum nome de coluna */
SELECT [NOME] AS [NOME DO CLIENTE], [CPF], [ESTADO] AS [UF]
FROM [TABELA DE CLIENTES];

/*o DISTINCT tras os valores sem repeti-los*/
SELECT DISTINCT [SABOR] FROM [TABELA DE PRODUTOS];

/* 
Novo suco: inserir O PRODUTO na tabela existente 'TABELA DE PRODUTOS'
olhar o tipo criado na tabela antes de adicionar as informações
1040107 // tipo VARCHAR,	uma espécie de string
Light 350 ml - Melancia
Lata
350 ml
Melancia
R$ 4,56 // tipo MONEY, deixar na notação dos USA
*/

INSERT INTO [TABELA DE PRODUTOS] VALUES (
 '1040107', 
 'Light 350 ml - Melancia',
 'Lata',
 '350 ml',
 'Melancia',
 4.56
);


INSERT INTO [TABELA DE PRODUTOS] VALUES
('1037797', 'Clean 2 Litros Laranja', 'PET', '2 Litros', 'Laranja', 16.01),
('1000889', 'Sabor da Montanha 700 ml Uva', 'Garrafa', '700 ml', 'Uva', 6.31),
('1004327', 'Videira do Campo - 1,5 Litros Melancia', 'PET', '1,5 Litros', 'Melancia', 19.51),
('1088126', 'Linha Citrus 1 Litro Limão', 'PET', '1 Litro', 'Limão', 7.00);

INSERT INTO [TABELA DE CLIENTES] VALUES
('00384393431', 'João da Silva', 'Rua Projetada A', 'Número 233', 'Copacabana', 'RJ', '20000000', '1965-03-21', 57, 'M', 20000000, 3000.30, 1),
('00384393555', 'Maria Clara', 'Rua Projetada A', 'Número 233', 'Copacabana', 'RJ', '20000000', '1975-03-21',47, 'F', 200000, 3000.30, 0);

/*
caso os dados não venha na ordem da tabela, é possível alterar essa ordem no código
na hora de inserir os dados na tebela, como é feito abaxio.
*/
INSERT INTO [TABELA DE PRODUTOS]
([CODIGO DO PRODUTO], [NOME DO PRODUTO], [EMBALAGEM], [TAMANHO], [PRECO DE LISTA], [SABOR])
VALUES
('5449310', 'Frescor do Verão - 350 ml - Limão', 'Lata', '350 ml',2.45, 'Limão'),
('1078680', 'Frescor do Verão - 350 ml - Manga', 'Lata', '350 ml',3.18, 'Manga');

SELECT [NOME] AS [NOME DO CLIENTE], ESTADO AS [UF], [PRIMEIRA COMPRA]
FROM [TABELA DE CLIENTES]
WHERE [PRIMEIRA COMPRA] = 1;

/*filtros */
SELECT * FROM [TABELA DE PRODUTOS] 
WHERE [PRECO DE LISTA] = 7.00;

SELECT * FROM [TABELA DE PRODUTOS] 
WHERE [PRECO DE LISTA] > 7.00;

SELECT * FROM [TABELA DE PRODUTOS] 
WHERE [PRECO DE LISTA] <= 7.00;

/*neste caso, ele filtra por ordem alfabética*/
SELECT * FROM [TABELA DE PRODUTOS] 
WHERE [EMBALAGEM] > 'Lata';

/* tem como trazer o maior e o menor ao mesmo tempo, excluindo somente a embalagem selecionada*/
SELECT * FROM [TABELA DE PRODUTOS] 
WHERE [EMBALAGEM] <> 'Lata';

/*a data pode ser filtrada tanto no modelo acima, quanto também colocando YEAR, MONTH ou DAY*/
SELECT [NOME], [DATA DE NASCIMENTO] 
FROM [TABELA DE CLIENTES]
WHERE YEAR([DATA DE NASCIMENTO]) > '1995';

/*concatenação de filtros com condições (operadores)*/
/*condição ou 'OR'*/
SELECT [NOME], [BAIRRO] 
FROM [TABELA DE CLIENTES]
WHERE [BAIRRO] = 'Copacabana' OR [BAIRRO] = 'Tijuca';

/*condição e 'AND'*/
SELECT [NOME], [ESTADO], [PRIMEIRA COMPRA] 
FROM [TABELA DE CLIENTES]
WHERE [PRIMEIRA COMPRA] = '1' AND [ESTADO] = 'SP';

/*atualiza o preço das lata, com desconto de 10%*/
UPDATE [TABELA DE PRODUTOS] 
SET [PRECO DE LISTA] = [PRECO DE LISTA] * 0.9
WHERE [EMBALAGEM] = 'Lata';

SELECT * FROM [TABELA DE PRODUTOS];

/*caso queira alterar um produto especifico, no caso, alterar embalagem e o seu preço do produto com o id='1088126'*/
UPDATE [TABELA DE PRODUTOS] 
SET [EMBALAGEM] = 'Garrafa', [PRECO DE LISTA] = 8.10
WHERE [CODIGO DO PRODUTO] = '1088126';

/*para deletar um produto*/
DELETE FROM [TABELA DE PRODUTOS]
WHERE [CODIGO DO PRODUTO] = '1004327';
