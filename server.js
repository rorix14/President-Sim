const express = require('express');
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')
const session = require('express-session')
const MySQLStore = require('express-mysql-session')(session);
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;
const mysql = require('mysql');

const bcrypt = require('bcrypt');
const saltRounds = 10;

const app = express();

// var user;

const dbase = mysql.createConnection({
    host: "localhost",
    port: 3306,
    user: "root",
    password: "password",
    database: "prototype_final_new1"
});

dbase.connect(function (err) {
    if (err) throw err;
    console.log("Connected!");
});

app.listen(3000, () => console.log('Example app listening on port 3000!'));

app.use(cookieParser());
app.use(express.static('web'));

//express mysql session
const options = {
    host: "localhost",
    port: 3306,
    user: "root",
    password: "password",
    database: "prototype_final_new1",
};

var sessionStore = new MySQLStore(options);

app.use(session({
    secret: 'hfdavvpaoerz',
    store: sessionStore,
    resave: false,
    saveUninitialized: false,
}));

app.use(passport.initialize());
app.use(passport.session());

// parse application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }))

// parse application/json
app.use(bodyParser.json())

app.get('/login', (req, res) => {
    console.log("hey")
    res.redirect('/index.html');
});

app.get('/register', (req, res) => {
    console.log("hey")
    res.redirect('/register.html');
});

//Local - for local database strategy
app.post('/login', passport.authenticate('local', {
    successRedirect: '/game',
    failureRedirect: '/login'
}));

app.get('/game', (req, res) => {
    console.log("redirecting to game")
    res.redirect('/game.html');
});

app.get('/logout', (req, res) => {
    //res.send(req.session.passport);
    req.logout();
    req.session.destroy(() => {
        res.clearCookie('connect.sid')
        res.redirect('/index.html')
    })
})

app.get('/authenticate', authenticationMiddleware(), (req, res) => {
    //  deserializeUser ... if so - creates a session and returns a session key
    res.send();
    //res.redirect('/do.html');
});

app.post('/register', (req, res) => {

    var name = req.body.name;
    var pass = req.body.pass;
    var mail = req.body.mail;

    if (!req.body || !name) {
        return respondBadRequest(res, "Required body param name not present");
    }

    bcrypt.hash(pass, saltRounds, function (err, hash) {
        // Store hash  your password dbase.
        const sql1 = "INSERT INTO player (name, mail, password, budget, turn) VALUES ('" + name + "', '" + mail + "', '" + hash + "', 5000, 1)"
        dbase.query(sql1, (err, result) => {
            // console.log(sql1)
            if (err) {
                return respondBadRequest(res, err.message);
            }

            const sql2 = "SELECT id_player as user_id from player where name ='" + name + "'";
            dbase.query(sql2, (err, result) => {
                // console.log(sql2)
                // if (err) throw err;
                if (err) {
                    return respondBadRequest(res, err.message);
                }

                var user_id = result[0];
                // console.log(result[0]);
                // console.log(result[0].user_id)
                // const user = result[0].user_id;

                function login() {
                    // console.log("logging in")
                    req.login(user_id, function (err) {
                        res.redirect('/game');
                    });
                }

                createPlayer(name, user_id, login);
            });
        });

    });
});

//verify if the user exists and the password is correct
passport.use(new LocalStrategy(
    function (username, password, done) {

        // console.log(username);
        // console.log(password);

        dbase.query('SELECT id_player, password FROM player WHERE name LIKE ?', [username], (err, result) => {
            // if (err) throw err;
            if (err) {
                return respondBadRequest(res, err.message);
            }
            console.log(result[0]);
            //if nothing is returned
            if (result.length === 0) {
                console.log("empty");
                return done(null, false);
            }
            const hash = result[0].password.toString();
            var res = bcrypt.compareSync(password, hash);
            if (res === true) {
                console.log("true")
                return done(null, { user_id: result[0].id_player });//id
            }
            else {
                console.log("false")
                return done(null, false);
            }
        });
    }
));


//writing user data in the session
passport.serializeUser(function (user_id, done) {
    done(null, user_id);
});

//retrieving user datafrom the session
passport.deserializeUser(function (user_id, done) {
    done(null, user_id);
});

function authenticationMiddleware() {
    return (req, res, next) => {
        console.log(`req.session.passport.user: ${JSON.stringify(req.session.passport)}`);

        if (req.isAuthenticated()) {
            // user = req.session.passport.user.user_id
            return next();
        }
        res.redirect('/login')
    }
}

/*
  * 
  * gets,posts & patch for the actual game
  *
  *
*/

function createPlayer(name, user_id, login) {

    //const requestBody = req.body;

    // if (!requestBody || !requestBody.name) {
    //   return respondBadRequest(res, "Required body param name not present");
    // }

    const deck = {
        name: name,
        //description: requestBody.description,
        cards: []
    };

    const cardTypeQuery = `select card_type.id_card_type as id, card_type.name_card, 
                            card_type.duplicate_number as duplicateNumber, card_type.description from card_type;`;

    dbase.query(cardTypeQuery, (err, result) => {
        // console.log(cardTypeQuery)
        if (err) {
            return respondBadRequest(res, err.message);
        }

        result.forEach(cardType => {
            for (let index = 0; index < cardType.duplicateNumber; index++) {
                deck.cards.push({ cardTypeId: cardType.id })
            }
        })

        shuffle(deck.cards)

        // const respondId = (id) => {
        //     //respond(res, 200, { id })
        //     login();
        // }

        const respondError = (err) => {
            console.log("error")
            //respondBadRequest(res, err.message);
        }

        insertShuffledDeck(deck, login, respondError);
    });
}

app.get('/players', authenticationMiddleware(), (req, res) => {

    dbase.query("select name from player where id_player ='" + req.user.user_id + "'", (err, result) => {
        if (err) {
            return respondBadRequest(res, err.message);
        }

        const playerName = result[0].name;
        // console.log(result)
        // console.log(playerName)

        const getCardsQuery = `select player.id_player as id, player.turn, player.budget, card.id_card as cardId,
        card.position, card.remaining, card.hand, card_type.name_card as type,
        card_type.description, card_type.cost
        from  player, card, card_type
        where player.id_player = card.id_player
        and card.id_card_type = card_type.id_card_type
        and player.name = "${playerName}"
        order by card.position;`;

        const getRegionQuery = `select region.id_region as regionId, region.tile, region.production, region.happiness,
        region.population_ip as populationIP, region.corporate_ip as corporateIP
        from region, player
        where player.id_player = region.id_player and player.name = "${playerName}";`

        const getCardsOnRegionsQuery = `select card_to_region.id_card as cardId, card_to_region.duration,
        card_to_region.id_region as regionId, card_type.name_card as type, card_type.description, card_type.cost
        from card_to_region, card, player, card_type
        where card_to_region.id_card = card.id_card and
        card.id_card_type = card_type.id_card_type and
        card.id_player = player.id_player and
        player.name = "${playerName}";`;

        const deck = {};

        dbase.query(getCardsQuery, (err, result) => {
            console.log(getCardsQuery)
            if (err) {
                return respondBadRequest(res, err.message);
            };

            if (!result || result.length === 0) {
                return res.status(404).send();
            }

            deck.id = result[0].id;
            deck.turn = result[0].turn;
            deck.budget = result[0].budget;

            deck.cards = result.map(card => {
                return {
                    id: card.cardId,
                    position: card.position,
                    remaining: card.remaining,
                    hand: card.hand,
                    type: card.type,
                    description: card.description,
                    cost: card.cost
                }
            })
            //respond(res, 200);

            dbase.query(getRegionQuery, (err, result) => {
                console.log(getRegionQuery)
                if (err) {
                    return respondBadRequest(res, err.message);
                };

                if (!result || result.length === 0) {
                    return res.status(404).send();
                }
                console.log("--------------------------")
                console.log(result);
                console.log("--------------------------")
                deck.worldStats = caculateTotalInfluence(result)

                deck.regions = result.map(region => {
                    return {
                        id: region.regionId,
                        tile: region.tile,
                        production: region.production,
                        happiness: region.happiness,
                        populationIP: region.populationIP,
                        corporateIP: region.corporateIP,
                    }
                });

                dbase.query(getCardsOnRegionsQuery, (err, result) => {
                    console.log(getCardsOnRegionsQuery)
                    if (err) {
                        return respondBadRequest(res, err.message);
                    };

                    deck.cardsOnRegions = result.map(cardonRegion => {
                        return {
                            cardId: cardonRegion.regionId,
                            regionId: cardonRegion.regionId,
                            cost: cardonRegion.cost,
                            duration: cardonRegion.duration,
                            type: cardonRegion.type,
                            description: cardonRegion.description,
                        }
                    })

                    const doEventCards = (event) => {
                        deck.event = event;
                        eventCards(deck.id, deck.event, respondCb, respondWithError)
                    };

                    const respondWithError = function (err) {
                        respondBadRequest(res, err.message);
                    };

                    const respondCb = (cardIds) => {
                        deck.eventMachingCards = cardIds;
                        respond(res, 200, deck);
                    };

                    dispatchEvent(deck.id, deck.turn, doEventCards, respondWithError);
                })
                //respond(res, 200, deck);
            });
        });
    });
});

function eventCards(playerId, event, cb, errCb) {

    if (event === null) {
        return cb(null)
    }

    const eventCards = `select card.id_card as cardId from card, card_to_event, player
    where player.id_player = card.id_player and
     player.id_player = "${playerId}" and
     card.id_card_type = card_to_event.id_card_type and 
     card_to_event.id_event = "${event.eventId}";`;

    dbase.query(eventCards, (err, result) => {
        // console.log(eventCards)
        if (err) {
            return errCb(err);
        }
        cb(result)
    });
};

const dispatchEvent = (playerId, turn, cb, errCb) => {

    const getEventQuery = `select event_type.description, event_type.id_event_type as eventId , region.id_region as regionId, region.tile
    from event_type, region, event_to_region, player
    where event_type.id_event_type = event_to_region.id_event and
    region.id_region = event_to_region.id_region and
	player.id_player = region.id_player
	and player.id_player = "${playerId}" and
    event_to_region.turn = ${turn};`;

    dbase.query(getEventQuery, (err, result) => {
        console.log(getEventQuery)
        if (err) {
            return errCb(err);
        }

        let event = result[0]
        if (!event) {
            event = null;
        }

        cb(event)
    })
}


app.patch('/players/:id/cards', (req, res) => {

    const respondCb = (operationResult, success) => {
        respond(res, success ? 200 : 400, operationResult);
    }

    patchCards(req.params.id, req.body, respondCb);
});

app.patch('/players/:id/turns', (req, res) => {

    const playerId = req.params.id;
    const regions = req.body.regions;
    const budget = req.body.budget;
    const extra = req.body.budgetPerTurn;
    const RegionsWithActiveCards = req.body.RegionsWithActiveCards;
    const event = req.body.event
    let currTurn;

    const respondWithError = function (err) {
        respondBadRequest(res, err.message);
    };

    const respondWithOk = function () {
        respond(res, 200);
    };

    const doCreatePlay = function (turn) {
        currTurn = turn;
        createPlay(playerId, turn, regions, doUpdateRegions, respondWithError);
    };

    const doUpdateRegions = () => {
        updateRegions(playerId, regions, RegionsWithActiveCards, doUpdatecardsOnRegions, respondWithError);
    };

    const doUpdatecardsOnRegions = () => {
        UpdatecardsOnRegions(playerId, doUpdateRegionWhithEvent, respondWithError);
    }

    const doUpdateRegionWhithEvent = () => {
        updateRegionWhithEvent(event, currTurn, playerId, doEndTurn, respondWithError)
    }

    const doEndTurn = () => {
        endTurn(playerId, budget, extra, doChooseEvent, respondWithError);
    };

    const doChooseEvent = () => {
        chooseEvent(playerId, respondWithOk, respondWithError)
    }

    getCurrentTurn(playerId, doCreatePlay, respondWithError);
});

const updateRegionWhithEvent = (event, turn, playerId, cb, errCb) => {

    if (event === null) {
        return cb();
    }

    if ((turn) % 3 !== 0) {
        return cb();
    }

    const seeIfEventWasResponded = `select card_to_event.id_card_type, card_to_event.id_event from card_to_event, card_type, event_type
where card_to_event.id_event = event_type.id_event_type and
event_type.id_event_type = "${event.eventId}" and
card_to_event.id_card_type = card_type.id_card_type and
 card_type.id_card_type in(select card_type.id_card_type from card, card_to_region
where card_to_region.id_card = card.id_card and
card.id_card_type = card_type.id_card_type and
card_to_region.id_region = "${event.regionId}" and
card_to_region.turn_played = ${turn});`;

    dbase.query(seeIfEventWasResponded, (err, result) => {
        // console.log(seeIfEventWasResponded)
        if (err) {
            return errCb(err);
        }

        const entity = result.length === 0 ? `penalty` : `bonus`;

        const applyValues = `select card_effect.type, event_${entity}.${entity} as value from event_${entity}, card_effect
         where card_effect.id_effect =  event_${entity}.id_card_effect and
         event_${entity}.id_event = "${event.eventId}"
         order by card_effect.type;`;

        dbase.query(applyValues, (err, result) => {
            // console.log(applyValues)
            if (err) {
                return errCb(err);
            }

            if (result.length < 2) {
                return errCb({ message: "Effects not present (check db)" })
            }

            updateRegionStats(result[1].value, result[0].value, event.regionId, playerId, cb, errCb);

        });
    })
};

const chooseEvent = (playerId, cb, errCb) => {
    ////// see Stored Procedures 
    const getUpdatedTurn = `select player.turn from player where player.id_player = "${playerId}";`;

    dbase.query(getUpdatedTurn, (err, result) => {
        // console.log(getUpdatedTurn)
        if (err) {
            return errCb(err);
        }
        const turn = result[0].turn

        if (turn % 3 !== 0) {
            return cb(null);
        }

        const getRegionsStatusQuery = `select region.production as production, region.happiness as happiness, 
        region.id_region as id
        from region, player
        where region.id_player = player.id_player and
        player.id_player = "${playerId}";`;

        dbase.query(getRegionsStatusQuery, (err, result) => {
            // console.log(getRegionsStatusQuery)
            if (err) {
                return errCb(err);
            }

            const regionStats = getRandomElement(result);
            const eventType = regionStats.production < regionStats.happiness ? 'production' : 'happiness';
            const eventValue = regionStats[eventType];

            const getEventQuery = `SELECT event_type.id_event_type as eventId, event_type.description, 
        event_type.value as value, ABS(event_type.value - ${eventValue}) as diff
        FROM event_type, card_effect 
        WHERE card_effect.type = '${eventType}'
        AND card_effect.id_effect = event_type.id_effect
        ORDER BY diff asc;`

            dbase.query(getEventQuery, (err, result) => {
                // console.log(getEventQuery)
                if (err || result.length === 0) {
                    return errCb(err);
                }

                const closestEvents = [];
                const minDiffValue = result[0].diff;

                for (const index in result) {
                    const row = result[index];

                    if (row.diff > minDiffValue) {
                        break;
                    }
                    row.regionId = regionStats.id;
                    closestEvents.push(row);
                }

                const chosenEvent = getRandomElement(closestEvents)

                const insertEventAndRegion = `insert into event_to_region (id_event, id_region, turn) values
            ("${chosenEvent.eventId}", "${chosenEvent.regionId}",${turn});`;

                dbase.query(insertEventAndRegion, (err, result) => {
                    // console.log(insertEventAndRegion)
                    if (err) {
                        return errCb(err);
                    }
                    cb()
                })
            });
        });
    });
};

const getCurrentTurn = (playerId, cb, errCb) => {

    const currentTurnQuery = `SELECT player.turn from player where player.id_player = "${playerId}";`;

    dbase.query(currentTurnQuery, (err, result) => {
        // console.log(currentTurnQuery)
        if (err) {
            return errCb(err);
        }

        cb(result[0].turn);
    });
};

const createPlay = (playerId, turn, regions, cb, errCb) => {

    const cards = [];

    let updateRegionQuery = regions.reduce((query, region, RegionsIndex) => {

        region.cards.forEach((card, cardIndex) => {
            cards.push(card);
            card.hand = 0;
            card.remaining = 0;
            query += `("${card.id}", "${region.id}", ${turn})${RegionsIndex === regions.length - 1 && cardIndex === region.cards.length - 1 ? ";" : ","}`
        })
        return query;
    }, 'insert into `card_to_region`(`id_card`, `id_region`, `turn_played`) values');

    if (cards.length === 0) {
        return cb();
    }

    dbase.query(updateRegionQuery, (err, result) => {
        // console.log(updateRegionQuery)
        if (err) {
            return errCb(err);
        }

        patchCards(playerId, cards, cb);
    });
};

const updateRegions = (playerId, regions, RegionsWithActiveCards, cb, errCb) => {

    const allRegionsWithCards = []

    if ((!regions || regions.length === 0) && (!RegionsWithActiveCards || RegionsWithActiveCards.length === 0)) {
        return cb();
    }

    if (regions.length > 0) {
        regions.forEach(region => {

            if (allRegionsWithCards.indexOf(region.id) === -1) {
                allRegionsWithCards.push(region.id);
            }
        });
    }

    if (RegionsWithActiveCards.length > 0) {

        RegionsWithActiveCards.forEach(region => {

            if (allRegionsWithCards.indexOf(region.regionId) === -1) {
                allRegionsWithCards.push(region.regionId);
            }
        });
    }

    allRegionsWithCards.forEach((region, index) => {

        const valueOnRegion = `select card_effect.type, sum(card_to_effect.value) as sumedValues from card_effect, card_to_effect
        where card_effect.id_effect = card_to_effect.id_effect and card_to_effect.id_card_type 
        in (select card_type.id_card_type from card, player, card_to_region, card_type
        where card_to_region.duration > 0 and
        card.id_player = player.id_player and
        player.id_player = "${playerId}" and
        card_to_region.id_card = card.id_card and 
        card.id_card_type = card_type.id_card_type 
        and card_to_region.id_region = "${region}")
        group by card_effect.type
        order by card_effect.type;`;

        dbase.query(valueOnRegion, (err, result) => {
            // console.log(valueOnRegion)
            if (err) {
                return errCb(err);
            }

            if (result.length < 2) {
                return errCb({ message: "Effects not present (check db)" })
            }

            const callCbOnLastIndex = function () {
                if (index === allRegionsWithCards.length - 1) {
                    cb();
                }
            }

            updateRegionStats(result[1].sumedValues, result[0].sumedValues, region, playerId, callCbOnLastIndex, errCb);

        });
    });
};

const updateRegionStats = function (production, happiness, regionId, playerId, cb, errCb) {

    const computeValues = `select region.production + ${production} as production, 
    region.happiness + ${happiness} as happiness 
   from region, player
   where region.id_region = "${regionId}" and 
   region.id_player = player.id_player and
   player.id_player = "${playerId}";`;

    dbase.query(computeValues, (err, result) => {
        // console.log(computeValues)
        if (err) {
            return errCb(err);
        }

        const updateRegionStats = `update region
            set region.production = "${clamp(result[0].production)}", region.happiness ="${clamp(result[0].happiness)}"
            where region.id_region = "${regionId}";`

        dbase.query(updateRegionStats, (err, result) => {
            // console.log(updateRegionStats)
            if (err) {
                return errCb(err);
            }

            cb();
        });
    });
}

const UpdatecardsOnRegions = (playerId, cb, errCb) => {

    const updateDurationQuery = `update card_to_region 
     set card_to_region.duration = card_to_region.duration - 1
     where card_to_region.id_card
     in (select card_to_region.id_card as cardId
         from card, player, card_type
         where card_to_region.id_card = card.id_card and
         card.id_card_type = card_type.id_card_type and
         card.id_player = player.id_player and
         player.id_player = "${playerId}");`;


    dbase.query(updateDurationQuery, (err, result) => {
        // console.log(updateDurationQuery)
        if (err) {
            return errCb(err);
        }

        cb();
    });
}

const endTurn = (playerId, budget,extra, cb, errCb) => {

    const updatePlayerStats = `update player
    set player.turn = player.turn + 1, player.budget=${budget + extra}
    where player.id_player = "${playerId}";`;

    dbase.query(updatePlayerStats, (err, result) => {
        // console.log(updatePlayerStats)
        if (err) {
            return errCb(err);
        }

        cb();
    });
};

function patchCards(playerId, cards, endCb) {

    let allSuccess = true;
    const operationResults = [];

    const returnCb = (result, err, index) => {

        if (err) {
            allSuccess = false;
        }

        operationResults.push({
            success: err ? false : true,
            message: err ? err.message : "Updated successfully"
        })

        if (index === cards.length - 1) {
            endCb(operationResults, allSuccess)
        }
    }

    cards.map((card, index) => {

        const updateHand = `update card 
        set remaining = ${toBoolean(card.remaining)} , hand = ${toBoolean(card.hand)}
        where id_card = "${card.id}"
        and id_player = "${playerId}";`

        executeQuery(updateHand, returnCb, index);
    })
};

const executeQuery = (query, cb, index) => {
    dbase.query(query, (err, result) => {
        // console.log(query)
        return cb(result, result.affectedRows === 0 ? { message: "Card not found" } : null, index)
    })
}

function insertShuffledDeck(deck, cb, errCb) {
    // console.log(deck.name)
    const query = "select id_player from player where name ='" + deck.name + "'"
    // console.log(query)
    dbase.query(query, (err, res) => {
        if (err) {
            // console.log(query)
            return errCb(err);
        }
        // console.log(res[0])

        //const createDeckQuery = `INSERT INTO player (id_player, name, budget, turn) VALUES ("${playerId}", "${deck.name}", 5000, 1)`;
        const insertCardsQuery = deck.cards.reduce((query, card, index) => {
            return query += `("${res[0].id_player}", "${card.cardTypeId}", "${index}")${index === deck.cards.length - 1 ? ";" : ","}`;
        }, `INSERT INTO card (id_player, id_card_type, position) VALUES`);

        dbase.query(insertCardsQuery, err => {
            // console.log(insertCardsQuery);
            if (err) {
                return errCb(err);
            }

            cb();
        });

        let totalInfluence = 5800;
        let currentInfluence = totalInfluence;
        let minInfluence = 600;
        let maxInfluence = 2300;
        let regionsIP = [];
        let corpIP = [];
        let happiness = [];
        let production = [];

        for (var i = 1; i <= 4; i++) {
            if (i == 4) {
                regionsIP[i]  = currentInfluence;
                //console.log(regionsIP[i])
                currentInfluence -= currentInfluence
                break;
            };
            let random = getRandomInteger(minInfluence/100,maxInfluence/100) * 100
            regionsIP[i] = random
            currentInfluence -= random;
            if(i == 3){
                while(currentInfluence < minInfluence/100){
                    currentInfluence += random;
                    random = getRandomInteger(minInfluence/100,maxInfluence/100) * 100
                    regionsIP[i] = random
                    currentInfluence -= random;
                };
            };
            //console.log(regionsIP[i])
        };
        for (var i = 1; i <= 4; i++) {
            var number = Math.floor(regionsIP[i]/3)
            corpIP[i] = Math.ceil(number / 10) * 10;
            //console.log(corpIP[i])
        }


        for (var i = 1; i <= 4; i++) {
            happiness[i] = getRandomInteger(35, 55);
            production[i] = getRandomInteger(35, 55);
            console.log(happiness[i], production[i]);
        };

        const createRegionQuery = `insert into region (id_player, tile, production, happiness, population_ip, corporate_ip)
        values 
        ("${res[0].id_player}", "${1}","${production[1]}",
        "${happiness[1]}" ,"${regionsIP[1]}" ,"${corpIP[1]}"),

        ("${res[0].id_player}", "${2}","${production[2]}",
        "${happiness[2]}" ,"${regionsIP[2]}" ,"${corpIP[2]}"),

        ("${res[0].id_player}", "${3}","${production[3]}",
        "${happiness[3]}" ,"${regionsIP[3]}" ,"${corpIP[3]}"),

        ("${res[0].id_player}", "${4}","${production[4]}",
        "${happiness[4]}" ,"${regionsIP[4]}" ,"${corpIP[4]}");`;
        // ("${res[0].id_player}", "${2}","${getRandomInteger(30, 60)}",
        // "${getRandomInteger(30, 60)}" ,"${getRandomInteger(300, 700)}" ,"${getRandomInteger(300, 700)}"),
        // ("${res[0].id_player}", "${3}","${getRandomInteger(30, 60)}",
        // "${getRandomInteger(30, 60)}" ,"${getRandomInteger(300, 700)}" ,"${getRandomInteger(300, 700)}"),
        // ("${res[0].id_player}", "${4}","${getRandomInteger(30, 60)}",
        // "${getRandomInteger(30, 60)}" ,"${getRandomInteger(300, 700)}" ,"${getRandomInteger(300, 700)}");`;

        dbase.query(createRegionQuery, err => {
            // console.log(createRegionQuery);
            if (err) {
                return errCb(err);
            }
        });
    });
};

function shuffle(array) {
    var currentIndex = array.length, temporaryValue, randomIndex;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;

        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
    }
    return array;
}

const respondBadRequest = (res, message) => {
    respond(res, 400, { error: message })
}

const respond = (res, status, body = "") => {
    console.log(`Response status ${status} with body ${JSON.stringify(body)}`)
    res.status(status).send(JSON.stringify(body));
}

function uuid() {
    return ("" + 1e7 + -1e3 + -4e3 + -8e3 + -1e11).replace(/1|0/g, function () { return (0 | Math.random() * 16).toString(16) });
}

const toBoolean = (val) => {
    return val ? true : false;
}

function getRandomInteger(min, max) {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
};

function clamp(number) {
    // number = number > 100 ? 100 : number < 0 ? 0 : number
    return Math.min(100, Math.max(0, number));
}

function caculateTotalInfluence(result) {
    let totalHappiness = 0;
    let totalProduction = 0;
    let totalPopulationIp = 0;
    let totalcorporateIp = 0;
    let totalHappinessPersentage;
    let totalProductionPersentage;
    let totalInfluence;

    for (let i = 0; i < result.length; i++) {
        totalHappiness += (result[i].happiness * result[i].populationIP) / 100;
        totalProduction += (result[i].production * result[i].corporateIP) / 100;
        totalPopulationIp += result[i].populationIP;
        totalcorporateIp += result[i].corporateIP;
    }
    totalHappinessPersentage = (totalHappiness) * 100 / (totalPopulationIp);
    totalProductionPersentage = (totalProduction) * 100 / (totalcorporateIp);
    totalInfluence = (totalHappiness + totalProduction) * 100 / (totalPopulationIp + totalcorporateIp);
    console.log(totalInfluence);

    return {
        totalHappiness: Math.ceil(totalHappinessPersentage),
        totalProduction: Math.ceil(totalProductionPersentage),
        totalInfluence: Math.ceil(totalInfluence),
        budgetPerTurn: Math.ceil(totalProduction),
    }
}

const getRandomElement = (array) => {
    return array[getRandomIndex(array)];
}

const getRandomIndex = (array) => {
    return getRandomInteger(0, array.length - 1);
}
