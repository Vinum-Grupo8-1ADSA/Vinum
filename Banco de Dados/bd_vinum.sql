create database bd_vinum;

use bd_vinum;

create table Endereco (
    idEndereco int primary key auto_increment,
    CEP varchar(8),
    logradouro varchar(50),
    numeroEndereco varchar(5)
);

create table Empresa (
    idEmpresa int primary key auto_increment,
    nomeEmpresa varchar(60),
    inscricaoEstadual varchar(9) not null,
    CNPJ varchar(14) not null unique,
    codEndereco int not null
);

create table Contato (
    idContato int primary key auto_increment,
    telefone varchar(13),
    email varchar(40),
    codEmpresa int not null
);

create table Usuario (
    idUsuario int primary key auto_increment,
    nomeUsuario varchar(40),
    email varchar(80),
    password varchar(40),
    codEmpresa int not null
);

create table Vinho (
    idVinho int primary key auto_increment,
    categoriaVinho varchar(40),
    nomeMarca varchar(40),
    dataProducao date,
    codMarca int not null,
    codEmpresa int not null
);

create table Geladeira (
    idGeladeira int primary key auto_increment,
    quatidade varchar(10),
    codVinho int not null
);

create table Registro (
    idRegistro int primary key auto_increment,
    codGeladeira int not null,
    temperatura decimal (2,1),
    umidade int,
    horario datetime default current_timestamp
);
 
