module Msgs exposing (..)
import Time exposing (Time)
import Models exposing (Building, Upgrade)


type Msg
    = Click
    | Tick Time
    | BuyBuilding Building
    | BuyUpgrade Upgrade
    | NoOp