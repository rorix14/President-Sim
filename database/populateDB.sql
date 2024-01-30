INSERT INTO `player` (`id_player`, `name`, `budget`,`turn`)
VALUES
('efc58ddb-4d77-11e9-9ccc-309c2390c766','PlayerOne', 5000, 1);

insert into `region` ( `id_region`,`id_player`, `tile`, `production`, `happiness`, `population_ip`, `corporate_ip`)
values
('205a4aca-5ca9-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766', 1, 5, 3,500 ,500 ),
('205adcce-5ca9-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766', 4, 3, 5,500 ,500 ),
('205adf45-5ca9-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766', 7, 2, 4,500 ,500 ),
('205ae089-5ca9-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766', 9, 4, 2,500 ,500 );

select * from card_type;
INSERT INTO `card_type` (`id_card_type`,`name_card`, `description`, `cost`, `duplicate_number`) 
VALUES
('1','A','Loosen alcohol sales laws.',2000 ,2),
('2','B',' Build a new structure on the account of the corporate.',1500 ,2),
('3','C','Build a new structure on the account of the population.',2500 ,2),
('4','D','Build a new structure at the expense of the government.',2000 ,2),
('5','E','Permit the corporate to privatize an industry.',1500 ,2),
('6','F','Loosen gun laws.', 3000,2),
('7','G','Loosen environment protection laws.', 2500 ,2),
('8','H','Loosen requirements for loans', 3000,2),
('9','I','Lower fines for misdemeanours.', 2000,2),
('10','J','Reduce work hours.', 2500,2),
('11','K','Increase work hours', 2500,2),
('12','L','Organize a public sporting event.', 3000,2),
('13','M','Loosen Hunting laws', 2500,2),
('14','N','Increase benefits and pensions for population.', 3000,2),
('15','O','More lenient taxes for the corporate.', 3000,2),
('16','P','More lenient taxes for the population.', 3000,2);


INSERT INTO `card_effect` (`id_effect`, `type`) 
VALUES
('5def7a73-5d75-11e9-9fbf-309c2390c766','population influence'),
('5def8585-5d75-11e9-9fbf-309c2390c766','corporate influence'),
('fdea7e28-4d81-11e9-9ccc-309c2390c766', 'happiness'),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', 'production');

-- UPDATE card_effect SET type = 'happiness' WHERE card_effect.id_effect = 'fdea7e28-4d81-11e9-9ccc-309c2390c766';
/*d7831d6e-87c5-11e9-bf9d-54ab3aa8c7d2
d783226a-87c5-11e9-bf9d-54ab3aa8c7d2
d7832470-87c5-11e9-bf9d-54ab3aa8c7d2
d7832617-87c5-11e9-bf9d-54ab3aa8c7d2
d78328b6-87c5-11e9-bf9d-54ab3aa8c7d2
d7832a16-87c5-11e9-bf9d-54ab3aa8c7d2
d7832bb9-87c5-11e9-bf9d-54ab3aa8c7d2
d7832d6b-87c5-11e9-bf9d-54ab3aa8c7d2
d7832f1e-87c5-11e9-bf9d-54ab3aa8c7d2
d7833089-87c5-11e9-bf9d-54ab3aa8c7d2
d783319a-87c5-11e9-bf9d-54ab3aa8c7d2
d7833321-87c5-11e9-bf9d-54ab3aa8c7d2
d7833441-87c5-11e9-bf9d-54ab3aa8c7d2
d783369e-87c5-11e9-bf9d-54ab3aa8c7d2
d783381d-87c5-11e9-bf9d-54ab3aa8c7d2
d7833a36-87c5-11e9-bf9d-54ab3aa8c7d2*/
select * from card_to_effect;
INSERT INTO `card_to_effect` (`id_effect`, `id_card_type`, `value`)
VALUES
-- a
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '1', 3),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '1', 3),
-- b
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '2', 3),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '2', -5),
-- c
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '3', -5),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '3', 3),
-- d
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '4', 3),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '4', 3),
-- e
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '5', -5),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '5', 5),
-- f
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '6', 0),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '6', 1),
-- g
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '7', -4),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '7', 3),
-- h
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '8', 1),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '8', 0),
-- i 
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '9', 1),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '9', 0),
-- j
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '10', 4),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '10', -5),
-- k
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '11', -5),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '11', 3),
-- l
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '12', 3),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '12', 0),
-- m
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '13', 1),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '13', 0),
-- n
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '14', 5),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '14', 0),
-- o
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '15', 0),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '15', 3),
-- p 
('fdea7e28-4d81-11e9-9ccc-309c2390c766', '16', 3),
('fdea81cd-4d81-11e9-9ccc-309c2390c766', '16', 0);

select * from card_effect;
select * from event_type;

INSERT INTO `card` (`id_card`,`id_player`, `id_card_type`, `position`)
VALUES
('d1cf0ea9-5bf6-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766','21cc4620-5bf3-11e9-9fbf-309c2390c766',0),
('d1cf1297-5bf6-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766','21cc4459-5bf3-11e9-9fbf-309c2390c766',1),
('d1cf1392-5bf6-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766','21cc43bb-5bf3-11e9-9fbf-309c2390c766',2),
('d1cf140a-5bf6-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766','21cc42ef-5bf3-11e9-9fbf-309c2390c766',3),
('d1cf1495-5bf6-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766','21cc4252-5bf3-11e9-9fbf-309c2390c766',4),
('d1cf1509-5bf6-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766','21cc4108-5bf3-11e9-9fbf-309c2390c766',5),
('d1cf1579-5bf6-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766','21cc3fe4-5bf3-11e9-9fbf-309c2390c766',6),
('d1cf15fa-5bf6-11e9-9fbf-309c2390c766','efc58ddb-4d77-11e9-9ccc-309c2390c766','21cc3afb-5bf3-11e9-9fbf-309c2390c766',7);

insert into `card_to_region`(`id`,`id_card`, `id_region`)
values
('1b58b810-5cac-11e9-9fbf-309c2390c766','21cc3afb-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766'),
('1b58bc0c-5cac-11e9-9fbf-309c2390c766','21cc3fe4-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766'),
('1b58bdc5-5cac-11e9-9fbf-309c2390c766','21cc4108-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766'),
('1b58bf18-5cac-11e9-9fbf-309c2390c766','21cc4252-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766'),
('1b58c073-5cac-11e9-9fbf-309c2390c766','21cc42ef-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766'),
('1b58c219-5cac-11e9-9fbf-309c2390c766','21cc43bb-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766'),
('1b58c342-5cac-11e9-9fbf-309c2390c766','21cc4459-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766'),
('1b58c47e-5cac-11e9-9fbf-309c2390c766','21cc4620-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766'),
('1b58c5d0-5cac-11e9-9fbf-309c2390c766','21cc3afb-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766'),
('1b58c7d8-5cac-11e9-9fbf-309c2390c766','21cc3fe4-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766'),
('1b58c9ba-5cac-11e9-9fbf-309c2390c766','21cc4108-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766'),
('1b58cba6-5cac-11e9-9fbf-309c2390c766','21cc4252-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766'),
('1b58cd14-5cac-11e9-9fbf-309c2390c766','21cc42ef-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766'),
('1b58ce5d-5cac-11e9-9fbf-309c2390c766','21cc43bb-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766'),
('1b58cf8b-5cac-11e9-9fbf-309c2390c766','21cc4459-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766'),
('1b58d0cb-5cac-11e9-9fbf-309c2390c766','21cc4620-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766'),
('1b58d1ef-5cac-11e9-9fbf-309c2390c766','21cc3afb-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766'),
('1b58d370-5cac-11e9-9fbf-309c2390c766','21cc3fe4-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766'),
('1b58d4c2-5cac-11e9-9fbf-309c2390c766','21cc4108-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766'),
('1b58d5eb-5cac-11e9-9fbf-309c2390c766','21cc4252-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766'),
('1b58d730-5cac-11e9-9fbf-309c2390c766','21cc42ef-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766'),
('1b58d866-5cac-11e9-9fbf-309c2390c766','21cc43bb-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766'),
('1b58d9b4-5cac-11e9-9fbf-309c2390c766','21cc4459-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766'),
('1b58daf0-5cac-11e9-9fbf-309c2390c766','21cc4620-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766'),
('1b58dc22-5cac-11e9-9fbf-309c2390c766','21cc3afb-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766'),
('1b58dd62-5cac-11e9-9fbf-309c2390c766','21cc3fe4-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766'),
('1b58de8b-5cac-11e9-9fbf-309c2390c766','21cc4108-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766'),
('1b58dfeb-5cac-11e9-9fbf-309c2390c766','21cc4252-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766'),
('1b58e130-5cac-11e9-9fbf-309c2390c766','21cc42ef-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766'),
('1b58e262-5cac-11e9-9fbf-309c2390c766','21cc43bb-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766'),
('1b58e3c7-5cac-11e9-9fbf-309c2390c766','21cc4459-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766'),
('1b58e4f9-5cac-11e9-9fbf-309c2390c766','21cc4620-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766');

insert into `event_to_region`(`id`,`id_event`, `id_region`, `turn`)
values
('9fcc6316-5cae-11e9-9fbf-309c2390c766','23ea8824-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc6abb-5cae-11e9-9fbf-309c2390c766','23ea8bd2-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc6d8e-5cae-11e9-9fbf-309c2390c766','23ea8cb9-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc6ed3-5cae-11e9-9fbf-309c2390c766','23ea8d3b-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc7005-5cae-11e9-9fbf-309c2390c766','23ea8dc6-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc714a-5cae-11e9-9fbf-309c2390c766','23ea8e36-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc728e-5cae-11e9-9fbf-309c2390c766','23ea8eaa-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc73bc-5cae-11e9-9fbf-309c2390c766','23ea8f30-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc74f7-5cae-11e9-9fbf-309c2390c766','23ea8f9b-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc7637-5cae-11e9-9fbf-309c2390c766','23ea902b-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc7732-5cae-11e9-9fbf-309c2390c766','23ea9091-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc785f-5cae-11e9-9fbf-309c2390c766','23ea9112-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc7a2a-5cae-11e9-9fbf-309c2390c766','23ea9178-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc7bb0-5cae-11e9-9fbf-309c2390c766','23ea91ff-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc7d84-5cae-11e9-9fbf-309c2390c766','23ea9273-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc7f2f-5cae-11e9-9fbf-309c2390c766','23ea92eb-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc8045-5cae-11e9-9fbf-309c2390c766','23ea935b-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc8169-5cae-11e9-9fbf-309c2390c766','23ea93d8-5bf3-11e9-9fbf-309c2390c766','205a4aca-5ca9-11e9-9fbf-309c2390c766',1),

('9fcc8297-5cae-11e9-9fbf-309c2390c766','23ea8824-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc839f-5cae-11e9-9fbf-309c2390c766','23ea8bd2-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc84c8-5cae-11e9-9fbf-309c2390c766','23ea8cb9-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc85cc-5cae-11e9-9fbf-309c2390c766','23ea8d3b-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc86eb-5cae-11e9-9fbf-309c2390c766','23ea8dc6-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc881d-5cae-11e9-9fbf-309c2390c766','23ea8e36-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc8921-5cae-11e9-9fbf-309c2390c766','23ea8eaa-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc8a45-5cae-11e9-9fbf-309c2390c766','23ea8f30-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc8b44-5cae-11e9-9fbf-309c2390c766','23ea8f9b-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc8c7b-5cae-11e9-9fbf-309c2390c766','23ea902b-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc8d9f-5cae-11e9-9fbf-309c2390c766','23ea9091-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc8ebf-5cae-11e9-9fbf-309c2390c766','23ea9112-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9008-5cae-11e9-9fbf-309c2390c766','23ea9178-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc910c-5cae-11e9-9fbf-309c2390c766','23ea91ff-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9230-5cae-11e9-9fbf-309c2390c766','23ea9273-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc934f-5cae-11e9-9fbf-309c2390c766','23ea92eb-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9458-5cae-11e9-9fbf-309c2390c766','23ea935b-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc958a-5cae-11e9-9fbf-309c2390c766','23ea93d8-5bf3-11e9-9fbf-309c2390c766','205adcce-5ca9-11e9-9fbf-309c2390c766',1),

('9fcc96a0-5cae-11e9-9fbf-309c2390c766','23ea8824-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc97d2-5cae-11e9-9fbf-309c2390c766','23ea8bd2-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9900-5cae-11e9-9fbf-309c2390c766','23ea8cb9-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9a08-5cae-11e9-9fbf-309c2390c766','23ea8d3b-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9b31-5cae-11e9-9fbf-309c2390c766','23ea8dc6-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9c34-5cae-11e9-9fbf-309c2390c766','23ea8e36-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9d59-5cae-11e9-9fbf-309c2390c766','23ea8eaa-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9e66-5cae-11e9-9fbf-309c2390c766','23ea8f30-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcc9f98-5cae-11e9-9fbf-309c2390c766','23ea8f9b-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcca0ea-5cae-11e9-9fbf-309c2390c766','23ea902b-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcca1fc-5cae-11e9-9fbf-309c2390c766','23ea9091-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcca329-5cae-11e9-9fbf-309c2390c766','23ea9112-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcca432-5cae-11e9-9fbf-309c2390c766','23ea9178-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcca556-5cae-11e9-9fbf-309c2390c766','23ea91ff-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcca69f-5cae-11e9-9fbf-309c2390c766','23ea9273-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcca7ac-5cae-11e9-9fbf-309c2390c766','23ea92eb-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fcca8da-5cae-11e9-9fbf-309c2390c766','23ea935b-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),
('9fccaa02-5cae-11e9-9fbf-309c2390c766','23ea93d8-5bf3-11e9-9fbf-309c2390c766','205adf45-5ca9-11e9-9fbf-309c2390c766',1),

('9fccab39-5cae-11e9-9fbf-309c2390c766','23ea8824-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccac46-5cae-11e9-9fbf-309c2390c766','23ea8bd2-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccad6f-5cae-11e9-9fbf-309c2390c766','23ea8cb9-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccae9c-5cae-11e9-9fbf-309c2390c766','23ea8d3b-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccafa9-5cae-11e9-9fbf-309c2390c766','23ea8dc6-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccb0f7-5cae-11e9-9fbf-309c2390c766','23ea8e36-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccb266-5cae-11e9-9fbf-309c2390c766','23ea8eaa-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccb377-5cae-11e9-9fbf-309c2390c766','23ea8f30-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccb4a5-5cae-11e9-9fbf-309c2390c766','23ea8f9b-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccb5b2-5cae-11e9-9fbf-309c2390c766','23ea902b-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccb74a-5cae-11e9-9fbf-309c2390c766','23ea9091-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccb877-5cae-11e9-9fbf-309c2390c766','23ea9112-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccb9ae-5cae-11e9-9fbf-309c2390c766','23ea9178-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccbaee-5cae-11e9-9fbf-309c2390c766','23ea91ff-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccbc09-5cae-11e9-9fbf-309c2390c766','23ea9273-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccbd40-5cae-11e9-9fbf-309c2390c766','23ea92eb-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccbe97-5cae-11e9-9fbf-309c2390c766','23ea935b-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1),
('9fccbfd2-5cae-11e9-9fbf-309c2390c766','23ea93d8-5bf3-11e9-9fbf-309c2390c766','205ae089-5ca9-11e9-9fbf-309c2390c766',1);

INSERT INTO `event_type` (`id_event_type`, `id_effect`, `value`, `description`) 
VALUES
('1','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Teachers request the return of flogging as punishment for misbehaviour in class.'),
('2','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'The mayor requests a new library for the people on the account of the corporate.'),
('3','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Students request the sale of alcohol at universities'),
('4','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Truckers want the unrestricted use of sawn-off shotguns for hunting!'),
('5','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'The people need the construction of a new school at the expense of the government.'),
('6','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'The people demand more accessible housing loans!'),
('7','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Parents are asking for the end of corporal punishment in schools.'),
('8','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'A large crowd protested for lowering the administrative fine for being drunk in public'),
('9','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Young graduates request that compulsory work hours be reduced to 40 hours per week.'),
('10','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Middle school students want free entry to the circus'),
('11','fdea7e28-4d81-11e9-9ccc-309c2390c766',0,'The people are concerned about the amount of public littering in some neighbourhoods.'),
('12','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'The people want more public marathons and events to combat the growing obesity rates in the population.'),
('13','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Some hunters have gathered in front of parliament demanding a longer hunting season.'),
('14','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Parents in a remote part of the region want a new kindergarten for their children to attend.'),
('15','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'The regional prison is getting overcrowded, so police is being more laid back when arresting criminals. The people want a new prison in order to feel safer in the streets.'),
('16','fdea7e28-4d81-11e9-9ccc-309c2390c766',0 ,'Elderly people formed an online petition that harnessed great success to have their benefits raised.'),

('17','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Corporate wants permission for the cutting down of protected forests to gather materials for a new condo.'),
('18','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Permit convicted corporate members to serve their sentences in their palaces?'),
('19','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Permit companies to dump toxic waste in the rivers?'),
('20','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Corporate CEOs are pressuring you to lower the tax on textile goods.'),
('21','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Corporate CEOs would like to privatize a large chunk of the health care industry.'),
('22','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Corporate CEOs would like to privatize a large chunk of the higher education industry.'),
('23','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Corporate is looking for permission to build a new luxury hotel at the expense of the taxpayers.'),
('24','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'A private company approached you and asked you to make an investment in their new R&D department.'),
('25','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Families of high ranked corporate executives demand separate toilets in public places for them.'),
('26','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'The meat industry would like you to increase the strict maximum toxic emissions allowance.'),
('27','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Families of corporate members would like you to open a new school exclusively for their children.'),
('28','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'A company’s CEO told you that they need you to invest in his company immediately to save it from bankruptcy.'),
('29','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Corporate wants permission for the cutting down of protected forests to gather materials for a new condo.'),
('30','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Permit convicted corporate members to serve their sentences in their palaces?'),
('31','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Permit companies to dump toxic waste in the rivers?'),
('32','fdea81cd-4d81-11e9-9ccc-309c2390c766',0 ,'Corporate CEOs are pressuring you to lower the tax on textile goods.');


insert into event_penalty (id_event, id_card_effect, penalty)
values 
('1','fdea7e28-4d81-11e9-9ccc-309c2390c766', -8),
('1','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('2','fdea7e28-4d81-11e9-9ccc-309c2390c766', -8),
('2','fdea81cd-4d81-11e9-9ccc-309c2390c766', 2),

('3','fdea7e28-4d81-11e9-9ccc-309c2390c766', -8),
('3','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('4','fdea7e28-4d81-11e9-9ccc-309c2390c766',-8),
('4','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('5','fdea7e28-4d81-11e9-9ccc-309c2390c766',-8),
('5','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('6','fdea7e28-4d81-11e9-9ccc-309c2390c766', -8),
('6','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('7','fdea7e28-4d81-11e9-9ccc-309c2390c766', -8),
('7','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('8','fdea7e28-4d81-11e9-9ccc-309c2390c766', -8),
('8','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('9','fdea7e28-4d81-11e9-9ccc-309c2390c766', -8),
('9','fdea81cd-4d81-11e9-9ccc-309c2390c766', -0),

('10','fdea7e28-4d81-11e9-9ccc-309c2390c766',-8),
('10','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('11','fdea7e28-4d81-11e9-9ccc-309c2390c766', -8),
('11','fdea81cd-4d81-11e9-9ccc-309c2390c766', 0),

('12','fdea7e28-4d81-11e9-9ccc-309c2390c766',-8),
('12','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('13','fdea7e28-4d81-11e9-9ccc-309c2390c766',-8),
('13','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('14','fdea7e28-4d81-11e9-9ccc-309c2390c766',-8),
('14','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('15','fdea7e28-4d81-11e9-9ccc-309c2390c766',-8),
('15','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('16','fdea7e28-4d81-11e9-9ccc-309c2390c766',-8),
('16','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('17','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('17','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('18','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('18','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('19','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('19','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('20','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('20','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('21','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('21','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('22','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('22','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('23','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('23','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('24','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('24','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('25','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('25','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('26','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('26','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('27','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('27','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('28','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('28','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('29','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('29','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('30','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('30','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('31','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('31','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8),

('32','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('32','fdea81cd-4d81-11e9-9ccc-309c2390c766',-8);

insert into event_bonus (id_event, id_card_effect, bonus)
values
('1','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('1','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('2','fdea7e28-4d81-11e9-9ccc-309c2390c766',9),
('2','fdea81cd-4d81-11e9-9ccc-309c2390c766',-3),

('3','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('3','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('4','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('4','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('5','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('5','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('6','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('6','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('7','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('7','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('8','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('8','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('9','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('9','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('10','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('10','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('11','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('11','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('12','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('12','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('13','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('13','fdea81cd-4d81-11e9-9ccc-309c2390c766',0),

('14','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('14','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('15','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('15','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('16','fdea7e28-4d81-11e9-9ccc-309c2390c766',8),
('16','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('17','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('17','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('18','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('18','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('19','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('19','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('20','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('20','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('21','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('21','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('22','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('22','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('23','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('23','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('24','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('24','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('25','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('25','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('26','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('26','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('27','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('27','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('28','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('28','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('29','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('29','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('30','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('30','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('31','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('31','fdea81cd-4d81-11e9-9ccc-309c2390c766',8),

('32','fdea7e28-4d81-11e9-9ccc-309c2390c766',0),
('32','fdea81cd-4d81-11e9-9ccc-309c2390c766',8);

insert into `card_to_event` (`id_card_type`,`id_event`)
values
/*('','1'),*/
('1','2'),
('2','2'),
('4','2'),

('1','3'),
('8','3'),
('9','3'),

('1','4'),
('6','4'),
('12','4'),
('13','4'),

('4','5'),
('8','5'),
('10','5'),

('1','6'),
('8','6'),
('10','6'),
('14','6'),
('16','6'),

('1','7'),

('1','8'),
('9','8'),
('16','8'),

('1','9'),
('10','9'),

('1','10'),

('1','11'),

('12','12'),

('7','13'),
('13','13'),

('2','14'),
('3','14'),
('4','14'),

('2','15'),
('3','15'),
('4','15'),

('14','16'),
('16','16'),

('7','17'),

/*('14','18'),*/
('7','19'),

('5','20'),
('15','20'),

('5','21'),
('15','21'),

('5','22'),
('15','22'),

('3','23'),
('4','23'),

('11','24'),
('15','24'),

('3','25'),
('4','25'),

('7','26'),

('3','27'),
('4','27'),

('11','28'),
('15','28'),

('7','29'),

('7','30'),

('5','31'),
('15','31'),

('5','32'),
('15','32');