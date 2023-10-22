create database bd_vinum;

use bd_vinum;

create table Endereco (
    idEndereco int primary key auto_increment,
    CEP char(8),
    logradouro varchar(50),
    numeroEndereco varchar(5)
);



create table Empresa (
    idEmpresa int primary key auto_increment,
    nomeEmpresa varchar(60),
    inscricaoEstadual varchar(9) not null,
    CNPJ varchar(14) not null unique,
    telefone varchar(13),
    email varchar(40),
    fkEndereco int not null,
    constraint fkEnd foreign key (fkEndereco) 
        references Endereco(idEndereco)
) auto_increment = 1000;


create table Usuario (
    idUsuario int primary key auto_increment,
    nomeUsuario varchar(40),
    email varchar(80),
    password varchar(40),
    fkEmpresa int not null,
    constraint fkEmp foreign key (fkEmpresa)
        references Empresa(idEmpresa)
);


create table Vinho (
    idVinho int primary key auto_increment,
    categoriaVinho varchar(40),
    nomeMarca varchar(40),
    dataProducao date,
    fkEmpresa int not null,
    constraint fkEmp3 foreign key (fkEmpresa)
        references Empresa(idEmpresa)
);


create table Modulo (
    idModulo int primary key auto_increment,
    estoque int,
    categoriaVinho varchar(40)
) auto_increment = 100;


create table Registro (
    idRegistro int primary key auto_increment,
    temperatura float,
    umidade int,
    horario datetime default current_timestamp,
    fkModulo int not null,
    constraint fkMod foreign key (fkModulo)
        references Modulo(idModulo)
);


select * from Endereco;
select * from Empresa;
select * from Usuario;
select * from Vinho;
select * from Modulo;
select * from Registro;