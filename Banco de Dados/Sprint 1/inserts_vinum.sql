insert into Endereco (CEP, logradouro, numeroEndereco) values
    ('01001001', 'Praça da Sé', 567),
    ('01310100', 'Avenida Paulista', 1234),
    ('01305000', 'Rua Augusta', 782);

insert into Empresa (nomeEmpresa, inscricaoEstadual, CNPJ, telefone, email, fkEndereco) values
    ('empresa A', '123456789', '12345678000100', '1234567891234', 'empresaa@email.com', 2),
    ('empresa B', '987654321', '98765432000101', '1234567891234', 'empresab@email.com', 1),
    ('empresa C', '456789123', '23456789000102', '1234567891234', 'empresac@email.com', 3),
    ('empresa D', '321654987', '87654321000103', '1234567891234', 'empresad@email.com', 3);

insert into Usuario (nomeUsuario, email, password, fkEmpresa) values
    ('usuario A', 'usuarioa@email.com', 'senha123', 1000),
    ('usuario B', 'usuariob@email.com', 'senha123', 1002),
    ('usuario C', 'usuarioc@email.com', 'senha123', 1002),
    ('usuario D', 'usuariod@email.com', 'senha123', 1001),
    ('usuario E', 'usuarioe@email.com', 'senha123', 1001),
    ('usuario F', 'usuariof@email.com', 'senha123', 1002);

insert into Vinho (categoriaVinho, nomeMarca, dataProducao, fkEmpresa) values
    ('tinto', 'marca', '2021-09-15', 1002),
    ('espumante', 'marca', '2021-04-04', 1000),
    ('rosé', 'marca', '2023-02-23', 1001),
    ('tinto', 'marca', '2022-11-07', 1001),
    ('branco', 'marca', '2022-08-28', 1002);

insert into Modulo (estoque, categoriaVinho) values
    (10, 'espumante'),
    (10, 'tinto'),
    (10, 'branco'),
    (10, 'seco'),
    (10, 'tinto'),
    (10, 'rosé'),
    (10, 'doce'),
    (10, 'branco'),
    (10, 'espumante'),
    (10, 'seco');
 
insert into Registro (temperatura, umidade, horario, fkModulo) values
    (4.6, 98, current_timestamp, 100),
    (4.6, 98, current_timestamp, 101),
    (4.6, 98, current_timestamp, 102),
    (4.6, 98, current_timestamp, 103),
    (4.6, 98, current_timestamp, 104),
    (4.6, 98, current_timestamp, 105),
    (4.6, 98, current_timestamp, 106),
    (4.6, 98, current_timestamp, 107),
    (4.6, 98, current_timestamp, 108),
    (4.6, 98, current_timestamp, 109);