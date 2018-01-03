module Msgs exposing (..)
import Time exposing (Time)
import Models exposing (Building, Upgrade, Spell)


type Msg
    = Click
    | Tick Time
    | BuyBuilding Building
    | BuyUpgrade Upgrade
    | CastSpell Spell
    | Save
    | Load String
    | Doload
    | NoOp