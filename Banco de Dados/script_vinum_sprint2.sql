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
constraint ckduracaomeses check (duracaoMeses in (12, 24, 36)),
preco float
);

create table usuario (
idUsuario int primary key auto_increment,
nomeUser varchar(30),
email varchar(50) not null,
senha varchar(30) not null,
fkDistribuidora int not null,
constraint fkdistribuidora foreign key (fkDistribuidora) references distribuidora(idDistribuidora),
fkAssinaturas int not null,
constraint fkassinaturas foreign key (fkAssinaturas) references assinaturas(idAssinaturas)
);

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