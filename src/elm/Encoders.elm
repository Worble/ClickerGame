module Encoders exposing (..)

import Models exposing (Model)
import Json.Encode as Encode

modelEncoder : Model -> Encode.Value
modelEncoder model =
    Encode.object
        [ ( "counter", Encode.float model.counter )
        , ( "mana", Encode.float model.mana )
        , ( "maxMana", Encode.float model.maxMana )
        , ( "manaPerTick", Encode.float model.manaPerTick)
        , ( "spells", Encode.list (List.map spellEncoder model.spells))
        , ( "amounterPerTick", Encode.float model.amountPerTick )
        , ( "amountPerClick", Encode.float model.amountPerClick)
        , ( "buildings", Encode.list (List.map buildingEncoder model.buildings))
        , ( "upgrades", Encode.list (List.map upgradeEncoder model.upgrades))
        ]

spellEncoder : Models.Spell -> Encode.Value
spellEncoder spell =
    Encode.object
        [ ( "id", Encode.int spell.id )
        , ( "cost", Encode.float spell.cost)
        , ( "value", Encode.float spell.value)
        , ( "cooldown", Encode.float spell.cooldown)
        , ( "name", Encode.string spell.name)
        , ( "description", Encode.string spell.description)
        ]

buildingEncoder : Models.Building -> Encode.Value
buildingEncoder building =
    Encode.object
        [ ( "id", Encode.int building.id )
        , ( "cost", Encode.float building.cost )
        , ( "initialCost", Encode.float building.initialCost )
        , ( "value", Encode.float building.value )
        , ( "amount", Encode.float building.amount )
        , ( "name", Encode.string building.name )
        , ( "description", Encode.string building.description )
        , ( "modifier", Encode.float building.modifier )
        , ( "costModifier", Encode.float building.costModifier )
        , ( "isTemp", Encode.bool building.isTemp )
        , ( "tempTime", Encode.float building.tempTime )
        , ( "temp", Encode.list (List.map Encode.float building.temp) )
        ]

upgradeEncoder : Models.Upgrade -> Encode.Value
-- upgradeEncoder upgrade =
--     Encode.object
--         [ ( "id", Encode.int upgrade.id )

--         ]