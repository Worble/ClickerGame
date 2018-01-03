module StartData exposing (..)

import Models exposing (Model, Building, Upgrade, Spell)
import Time exposing (Time, millisecond)

model : Model
model =
    { counter = 0, mana = 10, maxMana = 10, manaPerTick = (1 * (Time.inSeconds tick)), amountPerTick = 0
    , amountPerClick = 1, buildings = buildings, upgrades = upgrades, spells = spells}

tick : Time
tick =
    millisecond*100

buildings : List Building
buildings =
    [ 
        { id = 1, cost = 10, initialCost = 10, value = 5, amount = 0, name = "Skeleton", 
            description = "Lasts 10 seconds before melting", modifier = 1, costModifier = 0.3, 
            isTemp = True,  tempTime = 10, temp = [] }
        , Models.Building 2 50 50 10 0 "Zombie" "2spook" 1 0.3 False 0 []

    ]

upgrades : List Upgrade
upgrades =
    [
        { id = 1, modifier = 1, cost = 50, buildingId = 1, bought = False, name = "Upgrade Skeletons", description = "Double skeleton output" }
        , Models.Upgrade 2 1 250 2 False "Upgrade Zombies" "Double zombie output"
    ]

spells : List Spell
spells =
    [
        { id = 1, cost = 1, value = 1, cooldown = 0, name = "Fireball", description = "Shoots fire yo" }
        , Models.Spell 2 10 20 5 "Thunder Blast" "Shocking"
    ]