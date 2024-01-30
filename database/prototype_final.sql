create database prototype_final_new1234;
use prototype_final_new1234;

CREATE TABLE player (
    id_player CHAR(36),
    name VARCHAR(16) UNIQUE,
    password varchar(150),
	mail varchar(150),
    budget INT NOT NULL,
    turn INT NOT NULL,
    CONSTRAINT playerPK PRIMARY KEY (id_player),
    index(turn)
);

DELIMITER //
 CREATE PROCEDURE get_player_turn (in var char(36))
 BEGIN
 select player.turn from player where player.id_player = var;
 END
 //DELIMITER ;
 
call get_player_turn('2ece5ae2-871d-11e9-9959-309c2390c766');

CREATE TABLE region (
    id_region CHAR(36),
    id_player CHAR(36),
    tile INT NOT NULL,
    production INT NOT NULL,
    happiness INT NOT NULL,
    population_ip INT NOT NULL,
    corporate_ip INT NOT NULL,
    CONSTRAINT regionPK PRIMARY KEY (id_region),
    FOREIGN KEY (id_player)
        REFERENCES player (id_player)
);

CREATE TABLE card_type (
    id_card_type CHAR(36),
    duplicate_number INT NOT NULL,
    name_card VARCHAR(40) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    cost INT NOT NULL,
    CONSTRAINT cardPK PRIMARY KEY (id_card_type)
);

CREATE TABLE card_effect (
    id_effect CHAR(36),
    type VARCHAR(20) NOT NULL,
    CONSTRAINT effectPK PRIMARY KEY (id_effect),
    index(type)
);

CREATE TABLE card_to_effect (
    id CHAR(36),
    id_card_type CHAR(36),
    id_effect CHAR(36),
    value INT NOT NULL,
    CONSTRAINT idPK PRIMARY KEY (id),
    FOREIGN KEY (id_card_type)
        REFERENCES card_type (id_card_type),
    FOREIGN KEY (id_effect)
        REFERENCES card_effect (id_effect)
);

CREATE TABLE event_type (
    id_event_type CHAR(36),
    description VARCHAR(500) NOT NULL,
    id_effect VARCHAR(36),
    value INT NOT NULL,
    CONSTRAINT eventPK PRIMARY KEY (id_event_type),
	FOREIGN KEY (id_effect)
        REFERENCES card_effect (id_effect)
);

CREATE TABLE card_to_event (
    id CHAR(36),
    id_card_type CHAR(36),
    id_event CHAR(36),
    CONSTRAINT idPK PRIMARY KEY (id),
    FOREIGN KEY (id_card_type)
        REFERENCES card_type (id_card_type),
    FOREIGN KEY (id_event)
        REFERENCES event_type (id_event_type)
);

CREATE TABLE card (
    id_card CHAR(36),
    id_player CHAR(36),
    id_card_type CHAR(36),
    position INT NOT NULL,
    remaining BOOLEAN NOT NULL DEFAULT TRUE,
    hand BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT idPK PRIMARY KEY (id_card),
    FOREIGN KEY (id_player)
        REFERENCES player (id_player),
    FOREIGN KEY (id_card_type)
        REFERENCES card_type (id_card_type)
);

CREATE TABLE card_to_region (
    id CHAR(36),
    id_card CHAR(36) unique,
    id_region CHAR(36),
    turn_played int not null,
    event_flag BOOLEAN NOT NULL DEFAULT FALSE,
    duration INT NOT NULL DEFAULT 3,
    CONSTRAINT idPK PRIMARY KEY (id),
    FOREIGN KEY (id_card)
        REFERENCES card (id_card),
    FOREIGN KEY (id_region)
        REFERENCES region (id_region),
         index(turn_played)
);

CREATE TABLE event_to_region (
    id CHAR(36),
    id_event CHAR(36),
    id_region CHAR(36),
    turn INT REFERENCES player (turn),
    answered BOOLEAN NOT NULL DEFAULT FALSE,
    CONSTRAINT idPK PRIMARY KEY (id),
    FOREIGN KEY (id_event)
        REFERENCES event_type (id_event_type),
    FOREIGN KEY (id_region)
        REFERENCES region (id_region),
        index(turn)
);

CREATE TABLE event_penalty (
    id CHAR(36),
    id_event CHAR(36),
    id_card_effect CHAR(36),
    penalty INT NOT NULL,
    CONSTRAINT idPK PRIMARY KEY (id),
    FOREIGN KEY (id_event)
        REFERENCES event_type (id_event_type),
    FOREIGN KEY (id_card_effect)
        REFERENCES card_effect (id_effect)
);

CREATE TABLE event_bonus (
    id CHAR(36),
    id_event CHAR(36),
    id_card_effect CHAR(36),
    bonus INT NOT NULL,
    CONSTRAINT idPK PRIMARY KEY (id),
    FOREIGN KEY (id_event)
        REFERENCES event_type (id_event_type),
    FOREIGN KEY (id_card_effect)
        REFERENCES card_effect (id_effect)
);

DELIMITER //
CREATE TRIGGER before_insert_player
BEFORE INSERT ON player
FOR EACH ROW
BEGIN
  IF new.id_player IS NULL THEN
    SET new.id_player = uuid();
  END IF;
END
//DELIMITER ;

DELIMITER -
CREATE TRIGGER before_insert_region
BEFORE INSERT ON region
FOR EACH ROW
BEGIN
  IF new.id_region IS NULL THEN
    SET new.id_region = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_card_type
BEFORE INSERT ON card_type
FOR EACH ROW
BEGIN
  IF new.id_card_type IS NULL THEN
    SET new.id_card_type = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_card_effect
BEFORE INSERT ON card_effect
FOR EACH ROW
BEGIN
  IF new.id_effect IS NULL THEN
    SET new.id_effect = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_card_to_effect
BEFORE INSERT ON card_to_effect
FOR EACH ROW
BEGIN
  IF new.id IS NULL THEN
    SET new.id = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_event_type
BEFORE INSERT ON event_type
FOR EACH ROW
BEGIN
  IF new.id_event_type IS NULL THEN
    SET new.id_event_type = uuid();
  END IF;
END
-

 DELIMITER -
CREATE TRIGGER before_insert_card_to_event
BEFORE INSERT ON  card_to_event
FOR EACH ROW
BEGIN
  IF new.id IS NULL THEN
    SET new.id = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_card
BEFORE INSERT ON card
FOR EACH ROW
BEGIN
  IF new.id_card IS NULL THEN
    SET new.id_card = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_card_to_region
BEFORE INSERT ON card_to_region
FOR EACH ROW
BEGIN
  IF new.id IS NULL THEN
    SET new.id = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_event_to_region
BEFORE INSERT ON  event_to_region
FOR EACH ROW
BEGIN
  IF new.id IS NULL THEN
    SET new.id = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_event_penalty
BEFORE INSERT ON  event_penalty
FOR EACH ROW
BEGIN
  IF new.id IS NULL THEN
    SET new.id = uuid();
  END IF;
END
-
DELIMITER -
CREATE TRIGGER before_insert_event_bonus
BEFORE INSERT ON  event_bonus
FOR EACH ROW
BEGIN
  IF new.id IS NULL THEN
    SET new.id = uuid();
  END IF;
END
-

 /*
 DROP PROCEDURE IF EXISTS get_player_turn;
 CALL Verificar_Quantidade_Produtos(@total);
SELECT @total;
set @palyerId = "1b99c8c1-8612-11e9-b923-309c2390c766"; call get_player_turn(@palyerId);select @palyerId;
set @palyerId = "1b99c8c1-8612-11e9-b923-309c2390c766";
 call get_player_turn(@palyerId);
 select turn;
 */
/*
SHOW INDEXES FROM player;
ALTER TABLE player
ADD index(turn);
*/
/*
select name from player;
ALTER TABLE player
ADD mail varchar(150);

ALTER TABLE player
DROP COLUMN password;
*/ 
/*
 ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';
 UPDATE player
 SET password = "$2b$10$ZkCRNFbjakguuVbzwTiRv.e.97WnagJS3kJiTGOIyKgz45w7of.xG";
*/
/*
ALTER TABLE event_type
ADD value INT;

UPDATE event_type SET value=0 WHERE value IS NULL;
ALTER TABLE event_type MODIFY value INT NOT NULL;
ALTER TABLE event_type;
*/
/*
ALTER TABLE event_type
ADD value INT;

UPDATE event_type SET value=0 WHERE value IS NULL;
ALTER TABLE event_type MODIFY value INT NOT NULL;
ALTER TABLE event_type;
*/