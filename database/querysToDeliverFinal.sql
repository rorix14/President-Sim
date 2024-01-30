-- The following query represents what happens when a player registers for the first time
-- when registering a new player in the database
INSERT INTO player (name, mail, password, budget, turn)
 VALUES 
('1034', '@exemplo', '$2b$10$CwbuyboZrPE/lRJv7nUgauOI28Do8/mrQScp8/s6W3bLz7oNu6ik2', 5000, 1);

-- query used for suport in the authentication
SELECT id_player as user_id from player where name ='1034';

-- This query is used to get the data necessary to make a deck of cards
select card_type.id_card_type as id, card_type.name_card, card_type.duplicate_number as duplicateNumber, card_type.description
from card_type;

-- alter computing values to make the deck in the script insert its result to make the deck in the DB.
INSERT INTO card (id_player, id_card_type, position)
 VALUES
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "21cc4252-5bf3-11e9-9fbf-309c2390c766", "0"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "21cc43bb-5bf3-11e9-9fbf-309c2390c766", "1"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "21cc42ef-5bf3-11e9-9fbf-309c2390c766", "2"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "21cc4620-5bf3-11e9-9fbf-309c2390c766", "3"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "21cc3fe4-5bf3-11e9-9fbf-309c2390c766", "4"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "21cc3afb-5bf3-11e9-9fbf-309c2390c766", "5"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "21cc4459-5bf3-11e9-9fbf-309c2390c766", "6"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "21cc4108-5bf3-11e9-9fbf-309c2390c766", "7");
 
 -- Make the regions for a player
 insert into region (id_player, tile, production, happiness, population_ip, corporate_ip)
 values 
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "1","30","36" ,"357" ,"389"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "2","50","55" ,"577" ,"430"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "3","43","37" ,"642" ,"384"),
 ("e0d49f9f-86e2-11e9-b923-309c2390c766", "4","53","50" ,"649" ,"585");
 -- --------------------------------------------------------------------------------------------------------------------
 -- when entering the game after registing the player will recive his regions, cards, etc 
 -- the following querys are the ones that are used to get that information
 
 -- get all the cards that make that players deck
 select player.id_player as id, player.turn, player.budget, card.id_card as cardId,
        card.position, card.remaining, card.hand, card_type.name_card as type,
        card_type.description, card_type.cost
        from  player, card, card_type
        where player.id_player = card.id_player
        and card.id_card_type = card_type.id_card_type
        and player.name = "1034"
        order by card.position;
        
-- get all the regions that belong to that player  
        select region.id_region as regionId, region.tile, region.production, region.happiness,
        region.population_ip as populationIP, region.corporate_ip as corporateIP
        from region, player
        where player.id_player = region.id_player and player.name = "1034";
        
-- get all the cards that were played on regions by that player
        select card_to_region.id_card as cardId, card_to_region.duration,
        card_to_region.id_region as regionId, card_type.name_card as type, card_type.description, card_type.cost
        from card_to_region, card, player, card_type
        where card_to_region.id_card = card.id_card and
        card.id_card_type = card_type.id_card_type and
        card.id_player = player.id_player and
        player.name = "1034";
        
-- gets the event along with the region that recived that event, that was atributed to that player on his current turn
	select event_type.description, event_type.id_event_type as eventId , region.id_region as regionId, region.tile
    from event_type, region, event_to_region, player
    where event_type.id_event_type = event_to_region.id_event and
    region.id_region = event_to_region.id_region and
	player.id_player = region.id_player
	and player.id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766" and
    event_to_region.turn = 1;
    
-- right at the begining of the game the player will draw four cards, this query is used to update those cards
    update card 
        set remaining = false , hand = true
        where id_card = "e0d63e7e-86e2-11e9-b923-309c2390c766"
        and id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766";
        
-- --------------------------------------------------------------------------------------------------------------------        
-- the following querys are used to update all the player stats once the turn is over

-- this query is used when a card is drawn, to remove it from the deck and to put it into the player hand
update card 
        set remaining = false , hand = true
        where id_card = "e0d744cb-86e2-11e9-b923-309c2390c766"
        and id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766";
        
-- query used to get the current turn of the player, this result is going to be used on further queries
call get_player_turn("e0d49f9f-86e2-11e9-b923-309c2390c766");

-- this query selects all the the cards that were played by a player and reduces their durantion by one
update card_to_region 
     set card_to_region.duration = card_to_region.duration - 1
     where card_to_region.id_card
     in (select card_to_region.id_card as cardId
         from card, player, card_type
         where card_to_region.id_card = card.id_card and
         card.id_card_type = card_type.id_card_type and
         card.id_player = player.id_player and
         player.id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766");

-- this query updates the player the player turn and budget
update player
    set player.turn = player.turn + 1, player.budget=6000
    where player.id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766";
    
-- query used to get the current turn of the player, this result is going to be used on further queries
-- select player.turn from player where player.id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766"; /*storing procedures!!!*/
call get_player_turn("e0d49f9f-86e2-11e9-b923-309c2390c766");

select region.production as production, region.happiness as happiness, 
        region.id_region as id
        from region, player
        where region.id_player = player.id_player and
        player.id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766";
        
 -- selects an event that has a value similar to the production or happiness of a region
        SELECT event_type.id_event_type as eventId, event_type.description, 
        event_type.value as value, ABS(event_type.value - 50) as diff
        FROM event_type, card_effect 
        WHERE card_effect.type = 'happiness'
        AND card_effect.id_effect = event_type.id_effect
        ORDER BY diff asc;

-- insert the chosen event along with the region that was alsow chosen to have that event along wiht the curent turn
insert into event_to_region (id_event, id_region, turn) values
("23ea8e36-5bf3-11e9-9fbf-309c2390c766", "e0d91a28-86e2-11e9-b923-309c2390c766",3);
-- ---------------------------------------------------------------------------------------------------------------------
-- querys used update other actions that the player can make

-- used to update cards that were played
update card 
        set remaining = false , hand = false
        where id_card = "e0d6ae40-86e2-11e9-b923-309c2390c766"
        and id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766";
        
-- query used to get the sumed effect values of all the cards that are cative in a spcific region, this query executes for each region that has a card active on it     
        select card_effect.type, sum(card_to_effect.value) as sumedValues from card_effect, card_to_effect
        where card_effect.id_effect = card_to_effect.id_effect and card_to_effect.id_card_type 
        in (select card_type.id_card_type from card, player, card_to_region, card_type
        where card_to_region.duration > 0 and
        card.id_player = player.id_player and
        player.id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766" and
        card_to_region.id_card = card.id_card and 
        card.id_card_type = card_type.id_card_type 
        and card_to_region.id_region = "e0d91a28-86e2-11e9-b923-309c2390c766")
        group by card_effect.type
        order by card_effect.type;
        
-- this query uses the results from the previous query to add them to that regions current stats    
	select region.production + -2 as production, 
    region.happiness + 3 as happiness 
   from region, player
   where region.id_region = "e0d91a28-86e2-11e9-b923-309c2390c766" and 
   region.id_player = player.id_player and
   player.id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766";

-- the values of the previous query then are used in this one to update the region with its new values          
update region
            set region.production = "51", region.happiness ="53"
            where region.id_region = "e0d91a28-86e2-11e9-b923-309c2390c766";
          
 -- this query sees if a card was played on a turn in the region that the events corresponds to and if it was it sees if that card responds to that envent         
select card_to_event.id_card_type, card_to_event.id_event from card_to_event, card_type, event_type
where card_to_event.id_event = event_type.id_event_type and
event_type.id_event_type = "23ea8e36-5bf3-11e9-9fbf-309c2390c766" and
card_to_event.id_card_type = card_type.id_card_type and
 card_type.id_card_type in(select card_type.id_card_type from card, card_to_region
where card_to_region.id_card = card.id_card and
card.id_card_type = card_type.id_card_type and
card_to_region.id_region = "e0d91a28-86e2-11e9-b923-309c2390c766" and
card_to_region.turn_played = 3);

-- query used to get the bonus values that the event can give, in this case the event was reponded correctley, 
-- other wise it the player would recive a panaltey, the query for this would be the same exept their would be panalty insted of bonus
select card_effect.type, event_bonus.bonus as value from event_bonus, card_effect
         where card_effect.id_effect =  event_bonus.id_card_effect and
         event_bonus.id_event = "23ea8e36-5bf3-11e9-9fbf-309c2390c766"
         order by card_effect.type;
         
-- this query uses the results from the previous query to add them to that regions current stats      
select region.production + 13 as production, 
    region.happiness + 6 as happiness 
   from region, player
   where region.id_region = "e0d91a28-86e2-11e9-b923-309c2390c766" and 
   region.id_player = player.id_player and
   player.id_player = "e0d49f9f-86e2-11e9-b923-309c2390c766";
   
-- the values of the previous query then are used in this one to update the region with its new values 
   update region
			set region.production = "64", region.happiness ="59"
            where region.id_region = "e0d91a28-86e2-11e9-b923-309c2390c766";