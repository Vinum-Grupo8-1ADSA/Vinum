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
constraint ckduracaomeses check (duracaoMeses in (12, 36, 60)),
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
);

create table produto (
idProduto int primary key auto_increment,
categoriaVinho varchar(30),
constraint ckcategoriavinho check (categoriaVinho in ("Vinho Tinto", "Vinho Branco", "Vinho Rosé", "Vinho Espumante", "Vinho Licoroso")),
marcaVinho varchar(30),
dataSafra date,
qtdVinho int,
fkUsuario int not null,
constraint fkusuario foreign key (fkUsuario) references usuario(idUsuario)
);

create table localizacao (
idLocalizacao int primary key auto_increment,
posicao varchar(75),
fkEndereco int,
constraint fkenderecolocalizacao foreign key (fkEndereco) references endereco(idEndereco)
);

create table modulo (
idModulo int primary key auto_increment,
nomeModulo varchar(20),
temperatura float not null,
umidade float not null,
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

insert into endereco(idEndereco, fkDistribuidora, logradouro, numEndereco, complemento, CEP)values
(null, 1,'Rua Y',501,'Conjnt 42',01001000),
(null, 2,'Rua X',96,'Unidade 6',02405001),
(null, 1,'Avenida W',727,'Conjnt 31',05002000),
(null, 3,'Edificio U, Rua H',612,'4º Andar',04205000),
(null, 1,'Avenida Z',333,'Unidade 4',07070000),
(null, 2,'Rua T',567,'Conjnt 27',07265000);

select * from endereco;
select * from endereco
	join distribuidora on fkDistribuidora = idDistribuidora;

insert into assinaturas values
(null, 12, 999.99),
(null, 36, 2399.99),
(null, 60, 4999.99);

select * from assinaturas;

insert into usuario(idUsuario, nomeUser, fkDistribuidora, fkAssinaturas, email, senha) values
(null, 'Usuario X', 1,3,'userX@empresaA.com', '!123#Aa'),
(null, 'Usuario Y', 1,3,'userY@empresaA.com', '!321#Aa'),
(null, 'Usuario A', 2,2,'usuarioA@empresaB.com', '7272!Bb'),
(null, 'Usuario B', 2,2,'usuarioB@empresaB.com', '6262!Bb'),
(null, 'Usuario 1', 3,1,'colaborador1@empresaC.com', '#s1Bc7');

select *  from usuario;
select * from usuario
	join distribuidora on fkDistribuidora = idDistribuidora
    join assinaturas on fkAssinaturas = idAssinaturas;

insert into produto(idProduto, fkUsuario, categoriaVinho, marcaVinho, datasafra, qtdVinho) values
(null, 1, 'Vinho Tinto', 'Salentein', '2020-02-19', 427),
(null, 1, 'Vinho Rosé', 'Saurus', '2019-01-22', 320),
(null, 1, 'Vinho Branco', 'Cocodrilo', '2018-03-21', 174),
(null, 2, 'Vinho Tinto', 'Salentein', '2021-02-04', 207),
(null, 2, 'Vinho Rosé', 'Garzon', '2017-01-09', 338),
(null, 3, 'Vinho Branco', 'Pizzato', '2020-02-21', 142),
(null, 3, 'Vinho Espumante', 'Ferrari', '2022-03-13', 89);

select * from produto;
select * from produto
	join usuario on fkUsuario = idUsuario;
select * from endereco order by fkDistribuidora;

insert into localizacao(idLocalizacao, fkEndereco, posicao)values
(null, 1, 'Primeiro Módulo localizado na esquerda do subsolo 1 '),
(null, 1, 'Segundo Módulo localizado na esquerda do subsolo 1'),
(null, 1, 'Terceiro Módulo localizado na esquerda do subsolo 1'),
(null, 1, 'Quarto Módulo localizado na esquerda do subsolo 1'),
(null, 1, 'Primeiro Módulo localizado na direita do subsolo 1'),
(null, 1, 'Segundo Módulo localizado na direita do subsolo 1'),
(null, 1, 'Terceiro Módulo localizado na direita do subsolo 1'),
(null, 1, 'Quarto Módulo localizado na direita do subsolo 1'),
(null, 1, 'Quinto Módulo localizado na direita do subsolo 2'),
(null, 3, 'Primeiro Módulo localizado na esquerda do subsolo 2 '),
(null, 3, 'Segundo Módulo localizado na esquerda do subsolo 2'),
(null, 3, 'Terceiro Módulo localizado na esquerda do subsolo 2'),
(null, 3, 'Quarto Módulo localizado na esquerda do subsolo 2'),
(null, 3, 'Primeiro Módulo localizado na direita do subsolo 3'),
(null, 3, 'Segundo Módulo localizado na direita do subsolo 3'),
(null, 3, 'Terceiro Módulo localizado na direita do subsolo 3'),
(null, 3, 'Quarto Módulo localizado na direita do subsolo 3'),
(null, 3, 'Quinto Módulo localizado na direita do subsolo 3'),
(null, 5, 'Primeiro Módulo localizado na esquerda do armazém 1 '),
(null, 5, 'Segundo Módulo localizado na esquerda do armazém 1'),
(null, 5, 'Terceiro Módulo localizado na esquerda do armazém 1'),
(null, 5, 'Quarto Módulo localizado na esquerda do armazém 1'),
(null, 5, 'Primeiro Módulo localizado na direita do armazém 1'),
(null, 5, 'Segundo Módulo localizado na direita do armazém 1'),
(null, 5, 'Terceiro Módulo localizado na direita do armazém 1'),
(null, 5, 'Quarto Módulo localizado na direita do armazém 1'),
(null, 5, 'Quinto Módulo localizado na direita do armazém 1');

select * from localizacao;
select * from localizacao
	join endereco on fkEndereco = idEndereco;

insert into modulo(idModulo, fkProduto, nomeModulo, temperatura, umidade, horario, fkLocalizacao)values
(null, 01, 'Módulo A',10.42, 66, '2023-10-11 09:58:30', 1),
(null, 01, 'Módulo B',10.41, 67, '2023-10-11 10:00:00', 1),
(null, 01, 'Módulo C',10.32, 67, '2023-10-11 11:01:30', 1),
(null, 01, 'Módulo D',10.31, 70, '2023-10-11 11:03:00', 1),
(null, 01, 'Módulo F',9.98, 72, '2023-10-11 11:04:30', 1),
(null, 02, 'Módulo G',10.01, 73, '2023-10-11 11:06:00', 1),
(null, 02, 'Módulo H',11.42, 70, '2023-10-11 11:07:30', 1),
(null, 02, 'Módulo I',11.72, 68, '2023-10-11 11:09:00', 1),
(null, 02, 'Módulo J',11.20, 67, '2023-10-11 11:10:30', 1),
(null, 02, 'Módulo K',11.20, 67, '2023-10-11 11:12:00', 1);

select * from modulo;
select * from modulo
	join produto on fkProduto = idProduto
    join localizacao on fkLocalizacao = idLocalizacao;

select m.nomeModulo, m.temperatura, 
	   m.umidade, m.horario, 
	   p.categoriaVinho, p.marcaVinho,
       p.dataSafra, l.posicao
	from modulo as m
	join produto as p on fkProduto = idProduto
    join localizacao as l on fkLocalizacao = idLocalizacao
    where nomeModulo = 'Módulo A';

select l.posicao, e.* from localizacao as l
	join endereco as e on fkEndereco = idEndereco
    where idLocalizacao = 1;