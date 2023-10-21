create database VinumSprint2;
use VinumSprint2;

create table distribuidora (
idDistribuidora int primary key auto_increment,
nomeFantasia varchar(20) not null,
razaoSocial varchar(20) not null,
CNPJ char(14) not null unique,
telefone varchar(15),
email varchar(30)
);

create table endereco (
idEndereco int primary key auto_increment,
CEP char(8) not null,
logradouro varchar(50),
numEndereco int,
complemento varchar(10),
fkDistribuidora int not null,
constraint fkdistribuidora foreign key (fkDistribuidora) references distribuidora(idDistribuidora)
);

create table assinaturas (
idAssinaturas int primary key auto_increment,
duracaoMeses int,
constraint ckduracaomeses check (duracaoMeses in (12, 36, 60)), -- mudando o check para as assinaturas
preco float
);

create table usuario (
idUsuario int primary key auto_increment,
nomeUser varchar(30),
email varchar(50) not null,
senha varchar(30) not null,
fkDistribuidora int not null,
constraint fkdistribuidoraUsuario foreign key (fkDistribuidora) references distribuidora(idDistribuidora),
fkAssinaturas int not null,
constraint fkassinaturas foreign key (fkAssinaturas) references assinaturas(idAssinaturas)
); -- mudei o nome da constraint da foreign key, porque estava desencadeando em um erro(1826).

create table produto (
idProduto int primary key auto_increment,
categoriaVinho varchar(30), -- talvez precise colocar um check
marcaVinho varchar(30),
dataSafra date,
qtdVinho int,
fkUsuario int not null,
constraint fkusuario foreign key (fkUsuario) references usuario(idUsuario)
);

create table localizacao (
idLocalizacao int primary key auto_increment,
CEP char(8) not null,
logradouro varchar(50),
numEndereco int,
complemento varchar(10),
qtdModulos int
);

create table modulo (
idModulo int primary key auto_increment,
nomeModulo varchar(20),
temperatura float not null,
umidade int not null,
horario datetime not null,
fkProduto int not null,
constraint fkproduto foreign key (fkProduto) references produto(idProduto),
fkLocalizacao int not null,
constraint fklocalizacao foreign key (fkLocalizacao) references localizacao(idLocalizacao)
);

insert into distribuidora(idDistribuidora, nomeFantasia, razaoSocial, CNPJ, telefone, email) values
(null, 'Empresa A','Distribuidora A ltda','00000000009301','5511900001111','contato@empresaA.com'),
(null, 'Empresa B','Distribuidora B SA','00000000009401','5511900001112','atendimento@empresab.com'),
(null, 'Empresa C','Distribuidora C ltda','00000000009501','5511900001113','contato@empresaC.com');

select * from distribuidora;
desc endereco;
insert into endereco(idEndereco, fkDistribuidora, logradouro, numEndereco, complemento, CEP)values
(null, 1,'Rua Y',501,'Conjnt 42',01001000),
(null, 2,'Rua X',96,'Unidade 6',02405001),
(null, 1,'Avenida W',727,'Conjnt 31',05002000),
(null, 3,'Edificio U, Rua H',612,'4º Andar',04205000),
(null, 1,'Avenida Z',333,'Unidade 4',07070000),
(null, 2,'Rua T',567,'Conjnt 27',07265000);
select * from endereco;

desc assinaturas;
insert into assinaturas values
(null, 12, 999.99),
(null, 36, 2399.99),
(null, 60, 4999.99);
select * from assinaturas;

desc usuario;
insert into usuario(idUsuario, nomeUser, fkDistribuidora, fkAssinaturas, email, senha) values
(null, 'Usuario X', 1,3,'userX@empresaA.com', '!123#Aa'),
(null, 'Usuario Y', 1,3,'userY@empresaA.com', '!321#Aa'),
(null, 'Usuario A', 2,2,'usuarioA@empresaB.com', '7272!Bb'),
(null, 'Usuario B', 2,2,'usuarioB@empresaB.com', '6262!Bb'),
(null, 'Usuario 1', 3,1,'colaborador1@empresaC.com', '#s1Bc7');
select *  from usuario;

desc produto;
insert into produto(idProduto, fkUsuario, categoriaVinho, marcaVinho, datasafra, qtdVinho) values
(null, 1, 'Vinho Tinto', 'Salentein', '2020-02-19', 427),
(null, 1, 'Vinho Rosé', 'Saurus', '2019-01-22', 320),
(null, 1, 'Vinho Branco', 'Cocodrilo', '2018-03-21', 174),
(null, 2, 'Vinho Tinto', 'Salentein', '2021-02-04', 207),
(null, 2, 'Vinho Rosé', 'Garzon', '2017-01-09', 338),
(null, 3, 'Vinho Branco', 'Pizzato', '2020-02-21', 142),
(null, 3, 'Vinho Espumante', 'Ferrari', '2022-03-13', 89);
select * from produto;

desc localizacao;
insert into localizacao(idLocalizacao, logradouro, numEndereco, complemento, CEP, qtdModulos)values
(null,'Rua Y',501,'Conjnt 42',01001000, 39),
(null,'Rua X',96,'Unidade 6',02405001, 28),
(null,'Avenida W',727,'Conjnt 31',05002000, 14),
(null,'Edificio U, Rua H',612,'4º Andar',04205000, 16),
(null,'Avenida Z',333,'Unidade 4',07070000, 19),
(null,'Rua T',567,'Conjnt 27',07265000, 7);
select * from localizacao;

desc modulo;
insert into modulo(idModulo, fkProduto, nomeModulo, temperatura, umidade, horario, fkLocalizacao)values
(null, 01, '1º mdl esquerda',10.42, 66, '2023-10-11 09:58:30', 1),
(null, 01, '2º mdl esquerda',10.41, 67, '2023-10-11 10:00:00', 1),
(null, 01, '3º mdl esquerda',10.32, 67, '2023-10-11 11:01:30', 1),
(null, 01, '4º mdl esquerda',10.31, 70, '2023-10-11 11:03:00', 1),
(null, 01, '5º mdl esquerda',9.98, 72, '2023-10-11 11:04:30', 1),
(null, 02, '1º mdl centro',10.01, 73, '2023-10-11 11:06:00', 1),
(null, 02, '2º mdl centro',11.42, 70, '2023-10-11 11:07:30', 1),
(null, 02, '3º mdl centro',11.72, 68, '2023-10-11 11:09:00', 1),
(null, 02, '4º mdl centro',11.20, 67, '2023-10-11 11:10:30', 1);
select * from modulo;

