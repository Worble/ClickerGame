module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, Building, Upgrade)
import Update exposing (update)
import View exposing (view)
import Time exposing (Time, millisecond)
import StartData exposing (buildings, upgrades, tick, spells)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every tick Msgs.Tick

init : ( Model, Cmd Msg )
init =
    ({ counter = 0, mana = 10, maxMana = 10, manaPerTick = (1 * (Time.inSeconds tick)), amountPerTick = 0, amountPerClick = 1, buildings = buildings, upgrades = upgrades, spells = spells}, Cmd.none )

-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }