let deck = {};
let name = '';
const initialHand = 4;
const handLimit = 6;

$(document).ready(function () {


    let url = `/players`;
    $.getJSON(url, processDeck);


    // document.getElementById('Search').onclick = function () {

    //     const TTBar = document.getElementById('TTBar');

    //     name = document.getElementById('getName').value;
    //     let url = `/players?name=${name}`;

    //     $.getJSON(url, processDeck);
    // };

    // document.getElementById('Post').onclick = function () {

    //     let name = document.getElementById('postName').value;

    //     var DATA = {
    //         name: name
    //     }

    //     console.log(DATA);
    //     $.post('/players', DATA, cb, 'json');
    //     function cb(response) {
    //         console.log(response);
    //     }
    // };

    document.getElementById('endTurn2').onclick = function () {

        const card = drawCard();

        if (deck.turn > 48) {
            endGameConditions(deck);
            return
        }

        if (card) {
            updateServerCards([card]);
        }

        endTurn()
    };

    document.getElementsByClassName('globe')[0].onclick = function () {
        showPOPRegions(deck)
    }
    // document.getElementById('test').onclick = function () {
    // showEvent(deck)
    // showPOPRegions(deck)
    // }
});
// make modal appear and close 
function startModal(modelId) {

    const modal = document.getElementById(modelId);

    modal.classList.add('show');
    modal.addEventListener('click', (ev) => {
        if (ev.target.id === modelId || ev.target.className === 'close') {
            modal.classList.remove('show')
        };
    });
};

function showEvent(deck) {

    if (!deck.event) {
        return
    }
    const event = document.getElementById('description');
    const region = document.getElementById('region');
    event.innerHTML = `${deck.event.description}.`;
    region.innerHTML = `Region ${deck.event.tile}`;

    startModal('model-event')
    highlightEventCards(deck.eventMachingCards)
};

function activateEventButton() {

    const button = document.getElementsByClassName('eventButton')[0];

    if (deck.event) {
        button.classList.add('eventActive');

        document.getElementsByClassName('eventActive')[0].onclick = function () {
            if (deck.event) {
                startModal('model-event')
            }
        };
    } else if (!deck.event) {
        if (document.getElementsByClassName('eventButton eventActive')[0]) {
            document.getElementsByClassName('eventButton eventActive')[0].classList.remove('eventActive')
        }
    }
}

function outOfBugetPopup() {

    const h1 = document.getElementsByClassName('outOfBuget')[0];

    h1.innerHTML = 'You do not have enough money to play that card!';
    startModal("model-outOfBuget")
}

// drag drop cards into regions
function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("cardId", ev.target.id);
}

function drop(ev) {

    ev.preventDefault();
    const cardId = ev.dataTransfer.getData("cardId");
    const regionId = ev.target.id;
    const card = getCardById(cardId);

    if (!cardId) {
        return;
    }

    if (card.cost > deck.budget) {
        // return alert('You do not have enough money to play that card!')
        return outOfBugetPopup();
    }

    playCard(cardId, regionId);
    ev.target.appendChild(document.getElementById(cardId));
}

function playCard(cardId, regionId) {

    const card = getCardById(cardId);

    deck.budget = deck.budget - card.cost
    card.cost = 0
    card.hand = 0;
    card.remaining = 0;
    card.regionId = regionId;
    showTurn(deck);
}

function getCardInRegionById(deck) {
    return deck.cardsOnRegions.filter(card => card.duration > 0)
}

function getCardById(cardId) {
    return deck.cards.filter(card => card.id === cardId)[0];
}

function getRegionById(regionId) {
    return deck.regions.filter(region => region.id === regionId)[0];
}

function processDeck(data) {
    const previousRegionsStats = deck.regions;
    deck = data;
    console.log(deck);

    if (alreadyInitialDraw(deck)) {
        getHandCards(deck);
    } else {
        const hand = initialDraw(deck, initialHand);
        updateServerCards(hand);
    }

    showHand(deck);
    showRegions(deck, previousRegionsStats);
    showTurn(deck);
    cardsOnRegions(deck);
    numberOfCardsInDeck(deck);
    showMonth(deck);
    showEvent(deck);
    activateEventButton(deck)
}

function alreadyInitialDraw(deck) {
    return deck.cards.some(card => !card.remaining);
}

function getHandCards(deck) {
    return deck.cards.filter(card => card.hand);
}

function initialDraw(deck, number) {

    const hand = [];

    deck.cards.forEach((card) => {

        if (hand.length === number) {
            return;
        }

        if (!card.hand) {
            card.hand = 1;
            card.remaining = 0;

            hand.push(card);
        }
    });
    return hand;
}

function drawCard() {

    const atHandLimit = getHandCards(deck).length === handLimit;

    for (const cardIndex in deck.cards) {

        const card = deck.cards[cardIndex];

        if (card.remaining) {
            card.hand = atHandLimit ? 0 : 1;
            card.remaining = 0;
            // const hand = getHandCards(deck)
            //if (!atHandLimit) { hand.push(card) }
            return card;
        }
    }
}

function updateServerCards(cards) {

    const deckId = deck.id;
    showHand(deck);

    jsonPatch(`/players/` + deckId + `/cards`, cards,
        (response) => {
            console.log(response);
        }
    );
}

const jsonPatch = (url, body, successCb) => {
    $.ajax({
        type: `PATCH`,
        url: url,
        success: successCb,
        data: JSON.stringify(body),
        dataType: `json`,
        contentType: `application/json`
    });
}

function showHand(deck) {

    const hand = getHandCards(deck);

    let handDiv = document.getElementById('showHand');

    handDiv.innerHTML = '';

    hand.forEach((card, index) => {
        const p = document.createElement('div');
        p.setAttribute('id', card.id);
        p.setAttribute('class', `cards`);
        p.setAttribute('draggable', `true`);
        p.setAttribute('ondragstart', `drag(event)`);
        // p.innerHTML = `Cost: ${card.cost}$ Type: ${card.type}, Description: ${card.description}`;
        p.innerHTML = `${card.cost}$ <p>${card.description}</p>`;
        p.classList.add(`cardImage`);

        // assignCardImage(card, p)

        handDiv.appendChild(p);
    });
}

function cardsOnRegions(deck) {

    let playedCards = getCardInRegionById(deck)

    playedCards.forEach((playedCard) => {
        const cardsOnRegion = document.createElement('div');

        cardsOnRegion.setAttribute('id', playedCard.cardId);
        cardsOnRegion.setAttribute('class', `playedCards`);
        // cardsOnRegion.innerHTML = `Cost: ${playedCard.cost}$ Type: ${playedCard.type}, Description: ${playedCard.description}`;
        cardsOnRegion.innerHTML = `${playedCard.duration} <p>${playedCard.description}</p> `;
        cardsOnRegion.classList.add(`cardImage`);

        //assignCardImage(playedCard, cardsOnRegion);

        document.getElementById(playedCard.regionId).appendChild(cardsOnRegion);
    });
    // console.log(playedCards);
}

function assignCardImage(card, element) {
    element.classList.add(`${card.type}`);
}

function showTurn(deck) {

    const t = document.getElementById('TotalInfluence');
    const turn = document.getElementById('turn');
    const budget = document.getElementById('budget');
    const TotalInfluencePercentageBar = document.getElementsByClassName('TTBar_level');
    const totalHappiness = document.getElementById('totalHappiness');
    const totalProduction = document.getElementById('totalProduction');

    t.innerHTML = `Total Influence: ${deck.worldStats.totalInfluence}%`;
    turn.innerHTML = `Turn: ${deck.turn}`;
    budget.innerHTML = `${deck.budget} (${(deck.worldStats.budgetPerTurn)})`
    totalHappiness.innerHTML = `T. Happiness: ${deck.worldStats.totalHappiness}%`;
    totalProduction.innerHTML = `T. Production: ${deck.worldStats.totalProduction}%`;

    TotalInfluencePercentageBar[0].setAttribute('style', `width: ${deck.worldStats.totalInfluence}%`);
}

function endTurn() {

    const regionsWithCards = [];

    deck.cards.forEach(card => {

        if (!card.regionId) {
            return;
        }

        const region = getRegionById(card.regionId);

        if (!region.cards) {
            region.cards = [];
        }

        region.cards.push(card);

        if (regionsWithCards.indexOf(region) === -1) {
            regionsWithCards.push(region);
        }
    });

    console.log(regionsWithCards);

    jsonPatch(`/players/` + deck.id + `/turns`, {
        regions: regionsWithCards,
        budget: deck.budget,
        budgetPerTurn: deck.worldStats.budgetPerTurn,
        RegionsWithActiveCards: getCardInRegionById(deck),
        event: deck.event ? deck.event : null,
    }, (response) => {
        let url = `/players?name=${name}`
        $.getJSON(url, processDeck)
    })
}

function showRegions(deck, previousRegionsStats) {

    console.log(previousRegionsStats);
    const regions = deck.regions;
    const regiosDiv = document.getElementsByClassName("Region");

    $('.Region').empty();
    for (let i = 0; i < regions.length; i++) {
        regiosDiv[i].setAttribute('id', `${regions[i].id}`);
        regiosDiv[i].onclick = showRegionMoodOnClick;

        const region = regions[i];
        const previousRegion = getAttributeOrUndefined(previousRegionsStats, i);

        const populationMood = getMoodForValue(region.happiness);
        const corporateMood = getMoodForValue(region.production);

        const populationArrowClass = getRegionArrowClass(region.happiness, getAttributeOrUndefined(previousRegion, "happiness"));
        const corporateArrowClass = getRegionArrowClass(region.production, getAttributeOrUndefined(previousRegion, "production"));

        regiosDiv[i].innerHTML = `<div class="regionMood"><span class="image pop${populationMood}"></span>
        <span class="image arrow ${populationArrowClass}"></span></div>
        <div class="regionMood right"><span class="image cor${corporateMood}"></span>
        <span class="image arrow ${corporateArrowClass}"></span></div>`;
    }
    // selectedRegion(regions)
    // showRegionMoodOnClick(regions);
}

function getAttributeOrUndefined(object, attribute) {
    return object ? object[attribute] : undefined;
}

function getRegionArrowClass(current, previous) {

    const variation = computeVariation(current, previous);

    if (variation === 0) {
        return "";
    }

    if (variation === 1) {
        return "greenArrow";
    }

    return "redArrow";
}

function computeVariation(current, previous) {

    if (!previous || current === previous) {
        return 0;
    }

    return current > previous ? 1 : -1;
}

function getMoodForValue(value) {

    let mood = "VeryAngry";
    if (value >= 20 && value < 40) {
        mood = "Angry";
    } else if (value >= 40 && value < 50) {
        mood = "Anoyed";
    } else if (value >= 50 && value < 60) {
        mood = "Normal";
    } else if (value >= 60 && value < 80) {
        mood = "Happy";
    } else if (value >= 80 && value <= 100) {
        mood = "VeryHappy";
    }
    return mood;
}

function showRegionMoodOnClick(event) {
    console.log(event);
}
// mostrar regions stats onclick
// function selectedRegion(regions) {

//     const regionDiv = document.getElementsByClassName("Region");
//     const regionStats = document.getElementsByClassName("selectedRegionStats")[0];
//     regionStats.innerHTML = '';
//     showStatsOnClick(regions, regionDiv, regionStats)
// }

// function showStatsOnClick(region, regionDiv, div) {
//     for (let i = 0; i < region.length; i++) {

//         regionDiv[i].onclick = function () {
//             div.innerHTML =
//                 `<p>Production: ${region[i].production}</p> <p>Happiness: ${region[i].happiness}</p> <p>PopulationIP: ${region[i].populationIP}</p>
//             CorporateIP ${region[i].corporateIP}`;
//         }
//     }
// }

// show regions stats on popup
function showPOPRegions(deck) {
    const region = deck.regions;
    const regionNunber = document.getElementsByClassName("regNumber");
    const regionStats = document.getElementsByClassName("regeStats");

    for (let i = 0; i < region.length; i++) {
        regionNunber[i].innerHTML = `Region ${region[i].tile}`;
        regionStats[i].innerHTML = `<p>Production: ${region[i].production}</p> <p>Happiness: ${region[i].happiness}</p> <p>PopulationIP: ${region[i].populationIP}</p>
        CorporateIP ${region[i].corporateIP}`
    }
    startModal('model-region')
}

function numberOfCardsInDeck(deck) {
    let numberOfCards = 0;
    const deckDiv = document.getElementById("deck")

    deck.cards.forEach(card => {
        if (card.remaining) {
            numberOfCards++;
        }
    })

    deckDiv.innerHTML = `${numberOfCards} cards remaining`
}

function showMonth(deck) {
    const monthDiv = document.getElementById("month");
    const months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
    let number = deck.turn;
    let year = "";

    if (deck.turn > 12 && deck.turn <= 24) {
        year = "2nd Year";
    } else if (deck.turn > 24 && deck.turn <= 36) {
        year = "3rd Year";
    } else if (deck.turn > 36) {
        year = "4th Year";
    } else {
        year = "1st Year";
    }
    // while (number > 12) {
    //     number = number - 12
    // }
    number = (number - 1) % 12;

    monthDiv.innerHTML = `${year}, ${months[number]} `;
}

function endGameConditions(deck) {
    const htmlBody = document.getElementsByTagName("body")
    htmlBody[0].innerHTML = '';
    const gameResult = document.createElement('h1')


    if (deck.WorldStats.totalInfluence >= 50) {
        // gameResult.setAttribute('class', 'bg')
        // gameResult.setAttribute('src', './one nation under cthulhu.png')
        gameResult.innerHTML = `YOU WIN!`;
        htmlBody[0].appendChild(gameResult);

    } else {
        // gameResult.setAttribute('class', './one nation under cthulhu.png')
        gameResult.innerHTML = `YOU LOSE..`;
        htmlBody[0].appendChild(gameResult);
    }
}

function highlightEventCards(eventMatchingCards) {
    const handHtml = document.getElementsByClassName("cards")

    for (let i = 0; i < handHtml.length; i++) {

        for (let j = 0; j < eventMatchingCards.length; j++) {

            if (eventMatchingCards[j].cardId === handHtml[i].id) {
                handHtml[i].classList.add('highlightCards');
            }
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// PARA REMOVER CARTA QUANDO CLICADA

// function clickCards() {
//     document.getElementById('showHand').style.border = '2px solid black';
//     let button = document.getElementsByClassName('cards');
//     let playedCard;

//     for (let i = 0; i < button.length; i++) {
//         button[i].onclick = function () {
//             playedCard = hand.splice(i, 1)
//             if (playedCard) {
//                 console.log(playedCard)
//                 playedCard[0].hand = 0
//                 playedCard[0].remaining = 0
//                 updateServerCards(playedCard)
//             }
//         }
//     }
// }

//  PASSAR CARTA PARA NÃO DRAGABLE

//  regionsWithCards.forEach(region => {

//     region.cards.forEach(card => {
//         const cardInRegion = document.getElementById(card.id);
//         cardInRegion.setAttribute('draggable', `false`);
//     })
// })

// CREATION OF OLD REGIONS
// function showRegions(deck) {

    //     const regions = deck.regions;
    //     let rgionNumber = 0;
    //     let regionsDiv = document.getElementById('showRegions');
    //     regionsDiv.innerHTML = '';

    //     regions.forEach(region => {
    //         rgionNumber += 1
    //         const p = document.createElement('div');
    //         p.setAttribute('id', region.id);
    //         p.setAttribute('class', 'block');
    //         p.setAttribute('ondragover', 'allowDrop(event)');
    //         p.setAttribute('ondrop', 'drop(event)');
    //         p.innerHTML = `Region: ${rgionNumber}`;
    //         regionsDiv.appendChild(p);
    //         selectedRegion(regions)
    //     });
    // }

    // function selectedRegion(regions) {
    //     let block = document.getElementsByClassName('block');
    //     let regionDiv = document.getElementById('selectedRegion');
    //     regionDiv.innerHTML = '';

    //     for (let i = 0; i < block.length; i++) {
    //         block[i].onclick = function () {
    //             regionDiv.innerHTML = `Production: ${regions[i].production}, Happiness: ${regions[i].happiness},
    //             PopulationIP: ${regions[i].populationIP}, CorporateIP ${regions[i].corporateIP}`;
    //         }
    //     }
    // }


    // CREATING DYNAMIC HTML
    //TTBar.innerHTML = '';
        // const divTurn = document.createElement('div')
        // const endTurnButton = document.createElement('input')
        // const barDiv = document.createElement('div')
        // const tt = document.createElement('p')
        // const b = document.createElement('div');
        // const TotalInfluencePercentageBar = document.createElement('div');

        // barDiv.setAttribute('id', 'barDiv')
        // endTurnButton.setAttribute('id', 'endTurn2')
        // endTurnButton.setAttribute('type', 'button')
        // endTurnButton.setAttribute('value', 'End Turn')

        // divTurn.setAttribute('id', 'divTurn')
        // tt.setAttribute('id', 'TotalInfluence')
        // b.setAttribute('class', 'TTBar');
        // TotalInfluencePercentageBar.setAttribute('class', 'TTBar_level');

        // TTBar.appendChild(barDiv)
        // barDiv.appendChild(tt);
        // barDiv.appendChild(b);
        // b.appendChild(TotalInfluencePercentageBar);
        // TTBar.appendChild(divTurn)
        // divTurn.appendChild(endTurnButton);

    // OLD ASSING REGIONS ATRIBUETS 
         // const regions = deck.regions;
    // const region1 = document.getElementsByClassName("Region R1")[0];
    // const region2 = document.getElementsByClassName("Region R2")[0];
    // const region3 = document.getElementsByClassName("Region R3")[0];
    // const region4 = document.getElementsByClassName("Region R4")[0];
    // $('.Region').empty();

    // region1.setAttribute('id', `${regions[0].id}`)
    // region2.setAttribute('id', `${regions[1].id}`)
    // region3.setAttribute('id', `${regions[2].id}`)
    // region4.setAttribute('id', `${regions[3].id}`)
///////////////////////////////////////////////////////////////////////
    // const region1 = document.getElementsByClassName("Region R1")[0];
    // const region2 = document.getElementsByClassName("Region R2")[0];
    // const region3 = document.getElementsByClassName("Region R3")[0];
    // const region4 = document.getElementsByClassName("Region R4")[0];
    // const regionStats = document.getElementsByClassName("selectedRegionStats")[0];
    // regionStats.innerHTML = '';

    // showStatsOnClick(regions[0], region1, regionStats)
    // showStatsOnClick(regions[1], region2, regionStats)
    // showStatsOnClick(regions[2], region3, regionStats)
    // showStatsOnClick(regions[3], region4, regionStats)
    /////////////////////////////////////////////////////////////
    // regionClass.onclick = function () {
    //     div.innerHTML = `Production: ${region.production}, Happiness: ${region.happiness},
    //     PopulationIP: ${region.populationIP}, CorporateIP ${region.corporateIP}`;
    // }