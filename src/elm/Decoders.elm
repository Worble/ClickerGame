module Decoders exposing (..)

import Models exposing (Model)
import Json.Decode exposing (int, string, float, Decoder, list, bool)
import Json.Decode.Pipeline exposing (decode, required, optional, hardcoded)

modelDecoder : Decoder Model
modelDecoder = 
  decode Model
   |> required "counter" float
   |> required "mana" float
   |> required "maxMana" float
   |> required "manaPerTick" float
   |> required "spells" (list spellDecoder)
   |> required "amountPerTick" float
   |> required "amountPerClick" float
   |> required "buildings" (list buildingDecoder)
   |> required "upgrades" (list upgradeDecoder)

spellDecoder : Decoder Models.Spell
spellDecoder =
  decode Models.Spell
    |> required "id" int
    |> required "cost" float
    |> required "value" float
    |> required "cooldown" float
    |> required "name" string
    |> required "description" string

buildingDecoder : Decoder Models.Building
buildingDecoder =
  decode Models.Building
    |> required "id" int
    |> required "cost" float
    |> required "initialCost" float
    |> required "value" float
    |> required "amount" float
    |> required "name" string
    |> required "description" string
    |> required "modifier" float
    |> required "costModifier" float
    |> required "isTemp" bool
    |> required "tempTime" float
    |> required "temp" (list float)

upgradeDecoder : Decoder Models.Upgrade
upgradeDecoder =
  decode Models.Upgrade
    |> required "id" int
    |> required "modifier" float
    |> required "cost" float
    |> required "buildingId" int
    |> required "bought" bool
    |> required "name" string
    |> required "description" string