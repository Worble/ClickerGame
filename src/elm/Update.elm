module Update exposing (update)

import Msgs exposing (Msg(..))
import Models exposing (Model, Building, Upgrade)
import Time exposing (inSeconds)
import StartData exposing (tick)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            ({ model | counter = model.counter + model.amountPerClick }, Cmd.none)

        Tick _ ->
            (performTick model, Cmd.none) 

        BuyBuilding building ->
            if model.counter < building.cost
            then
                (model, Cmd.none)                
            else
                (updateBuildings building model, Cmd.none)

        BuyUpgrade upgrade ->
            if model.counter < upgrade.cost
            then
                (model, Cmd.none)
            else
                (updateUpgrades upgrade model, Cmd.none)

        CastSpell spell ->
            ({ model | counter = model.counter + spell.value, mana = model.mana - spell.cost }, Cmd.none)

        NoOp ->
            (model, Cmd.none)

updateBuildings : Building -> Model -> Model
updateBuildings newBuilding model =
    let
        newBuildings =
            List.map
                (\building ->
                    if building.id == newBuilding.id
                    then
                        if building.isTemp
                        then
                            { building | 
                                amount = (building.amount + 1)
                                , cost = calculateBuildingCost building.initialCost building.costModifier building.amount
                                , temp = (building.tempTime :: building.temp) }
                        else
                            { building | 
                                amount = (building.amount + 1)
                                , cost = calculateBuildingCost building.initialCost building.costModifier building.amount  
                            }
                    else
                        building
                )
                model.buildings
    in
        { model | 
            buildings = newBuildings
            , counter = model.counter - newBuilding.cost
        }

updateUpgrades : Upgrade -> Model -> Model
updateUpgrades newUpgrade model =
    let
        newUpgrades =
            List.map
                (\upgrade ->
                    if upgrade.id == newUpgrade.id
                    then
                        { upgrade | bought = True }
                    else
                        upgrade
                )
                model.upgrades

        newBuildings = 
            List.map
                (\building ->
                if building.id == newUpgrade.buildingId
                then
                    {building | modifier = building.modifier + newUpgrade.modifier}
                else
                    building
                )
                model.buildings
    in
        { model |
            upgrades = newUpgrades
            , buildings = newBuildings
            , counter = model.counter - newUpgrade.cost
        }

calculateTick : List Building -> Float
calculateTick buildings =
    List.sum
        (List.map
            (\building ->
                if building.amount > 0
                then
                    ((building.value * (inSeconds tick)) * building.modifier) * building.amount
                else
                    0
            )
            buildings)

performTick : Model -> Model
performTick model =
    let
        newTick =
            calculateTick model.buildings

        newBuildings =
            List.map
                (\building ->
                    if building.isTemp
                    then
                        buildingLength building
                    else
                        building
                )
                model.buildings
    in
        { model |
            counter = model.counter + newTick
            , buildings = newBuildings
            , amountPerTick = newTick
            , mana = if model.mana < model.maxMana then
                        model.mana + model.manaPerTick
                    else
                        model.mana
        }

buildingLength : Building -> Building
buildingLength building =
    let
        newTemp =
            List.filterMap
                (\temp ->
                    if temp < (inSeconds tick)
                    then
                        Nothing
                    else
                        Just (temp - (inSeconds tick))
                )
                building.temp
    in
        { building | 
            temp = newTemp, amount = toFloat(List.length newTemp)
            , cost = calculateBuildingCost building.initialCost building.costModifier (toFloat(List.length newTemp)) 
        }

calculateBuildingCost : Float -> Float -> Float -> Float
calculateBuildingCost initialCost modifier amount =
    toFloat (round (initialCost * ( 1 + modifier )^amount))