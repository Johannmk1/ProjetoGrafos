/*
drop table arestas
drop table vertices

CREATE TABLE vertices (
	id SERIAL PRIMARY KEY,
    nome varchar(50)
);

CREATE TABLE arestas (
id SERIAL PRIMARY KEY,
    origem integer,
	destino integer,
	peso real
);


INSERT INTO vertices (nome) VALUES
('AGL'),
('AGN'),
('ATA'),
('AUR'),
('BRA'),
('CHA'),
('DON'),
('GET'),
('IBI'),
('ITU'),
('JOS'),
('LAU'),
('LON'),
('MIR'),
('NER'),
('PET'),
('POU'),
('RDC'),
('RDO'),
('RDS'),
('SAL'),
('TAI'),
('TER'),
('TRO'),
('VID'),
('VIT'),
('WIT');

INSERT INTO arestas (origem, destino, peso) VALUES
((SELECT id FROM vertices WHERE nome = 'AGL'), (SELECT id FROM vertices WHERE nome = 'CHA'), 64.26),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'ITU'), 16.90),
((SELECT id FROM vertices WHERE nome = 'JOS'), (SELECT id FROM vertices WHERE nome = 'TAI'), 2.00),
((SELECT id FROM vertices WHERE nome = 'AGN'), (SELECT id FROM vertices WHERE nome = 'SAL'), 47.25),
((SELECT id FROM vertices WHERE nome = 'BRA'), (SELECT id FROM vertices WHERE nome = 'POU'), 55.25),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'PET'), 18.00),
((SELECT id FROM vertices WHERE nome = 'ATA'), (SELECT id FROM vertices WHERE nome = 'JOS'), 30.60),
((SELECT id FROM vertices WHERE nome = 'AGN'), (SELECT id FROM vertices WHERE nome = 'JOS'), 22.50),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'NER'), 11.70),
((SELECT id FROM vertices WHERE nome = 'ATA'), (SELECT id FROM vertices WHERE nome = 'LON'), 6.80),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'LON'), 14.00),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'TAI'), 10.20),
((SELECT id FROM vertices WHERE nome = 'AUR'), (SELECT id FROM vertices WHERE nome = 'IBI'), 7.80),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'LON'), 22.10),
((SELECT id FROM vertices WHERE nome = 'MIR'), (SELECT id FROM vertices WHERE nome = 'VID'), 14.40),
((SELECT id FROM vertices WHERE nome = 'BRA'), (SELECT id FROM vertices WHERE nome = 'TRO'), 17.68),
((SELECT id FROM vertices WHERE nome = 'GET'), (SELECT id FROM vertices WHERE nome = 'RDS'), 12.50),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'RDO'), 3.06),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'MIR'), 40.63),
((SELECT id FROM vertices WHERE nome = 'BRA'), (SELECT id FROM vertices WHERE nome = 'MIR'), 23.40),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'RDC'), 36.72),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'PET'), 39.10),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'PET'), 11.05),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'VID'), 5.40),
((SELECT id FROM vertices WHERE nome = 'BRA'), (SELECT id FROM vertices WHERE nome = 'NER'), 8.75),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'NER'), 21.13),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'TRO'), 6.00),
((SELECT id FROM vertices WHERE nome = 'CHA'), (SELECT id FROM vertices WHERE nome = 'JOS'), 15.30),
((SELECT id FROM vertices WHERE nome = 'IBI'), (SELECT id FROM vertices WHERE nome = 'NER'), 20.00),
((SELECT id FROM vertices WHERE nome = 'PET'), (SELECT id FROM vertices WHERE nome = 'WIT'), 15.75),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'TAI'), 27.30),
((SELECT id FROM vertices WHERE nome = 'ITU'), (SELECT id FROM vertices WHERE nome = 'TAI'), 21.13),
((SELECT id FROM vertices WHERE nome = 'IBI'), (SELECT id FROM vertices WHERE nome = 'SAL'), 22.10),
((SELECT id FROM vertices WHERE nome = 'GET'), (SELECT id FROM vertices WHERE nome = 'PET'), 64.26),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'TER'), 23.40),
((SELECT id FROM vertices WHERE nome = 'IBI'), (SELECT id FROM vertices WHERE nome = 'RDS'), 6.00),
((SELECT id FROM vertices WHERE nome = 'GET'), (SELECT id FROM vertices WHERE nome = 'RDC'), 39.10),
((SELECT id FROM vertices WHERE nome = 'AGL'), (SELECT id FROM vertices WHERE nome = 'RDC'), 1.00),
((SELECT id FROM vertices WHERE nome = 'DON'), (SELECT id FROM vertices WHERE nome = 'WIT'), 43.20),
((SELECT id FROM vertices WHERE nome = 'LAU'), (SELECT id FROM vertices WHERE nome = 'TER'), 40.63),
((SELECT id FROM vertices WHERE nome = 'RDO'), (SELECT id FROM vertices WHERE nome = 'VIT'), 10.20),
((SELECT id FROM vertices WHERE nome = 'LAU'), (SELECT id FROM vertices WHERE nome = 'SAL'), 19.50),
((SELECT id FROM vertices WHERE nome = 'AGN'), (SELECT id FROM vertices WHERE nome = 'BRA'), 2.00),
((SELECT id FROM vertices WHERE nome = 'AGL'), (SELECT id FROM vertices WHERE nome = 'LON'), 6.25),
((SELECT id FROM vertices WHERE nome = 'ATA'), (SELECT id FROM vertices WHERE nome = 'RDC'), 17.68),
((SELECT id FROM vertices WHERE nome = 'GET'), (SELECT id FROM vertices WHERE nome = 'JOS'), 15.00),
((SELECT id FROM vertices WHERE nome = 'LAU'), (SELECT id FROM vertices WHERE nome = 'WIT'), 36.00),
((SELECT id FROM vertices WHERE nome = 'NER'), (SELECT id FROM vertices WHERE nome = 'TAI'), 16.00),
((SELECT id FROM vertices WHERE nome = 'AGL'), (SELECT id FROM vertices WHERE nome = 'POU'), 25.50),
((SELECT id FROM vertices WHERE nome = 'ATA'), (SELECT id FROM vertices WHERE nome = 'RDS'), 19.80);
*/