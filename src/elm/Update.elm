module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model, Building, Upgrade)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Click ->
            ({ model | counter = model.counter + model.amountPerClick }, Cmd.none)

        Tick _ ->
            if model.amountPerTick > 0
            then
            ({model | counter = model.counter + model.amountPerTick}, Cmd.none)
            else
            (model, Cmd.none)  

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

        NoOp ->
            ( model, Cmd.none )

updateBuildings : Building -> Model -> Model
updateBuildings newBuilding model =
    let
        newBuildings =
            List.map
                (\building ->
                    if building.id == newBuilding.id
                    then
                        { building | amount = (building.amount + 1), cost = toFloat (round (building.cost * 1.3)) }
                    else
                        building
                )
                model.buildings
    in
        { model | 
            buildings = newBuildings
            , amountPerTick = calculateTick newBuildings
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
            , amountPerTick = calculateTick newBuildings
        }

calculateTick : List Building -> Float
calculateTick buildings =
    List.sum
        (List.map
            (\building ->
            if building.amount > 0
            then
                ((building.value / 10) * building.modifier) * building.amount
            else
                0
            )
            buildings)