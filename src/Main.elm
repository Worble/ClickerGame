module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, Building, Upgrade)
import Update exposing (update)
import View exposing (view)
import Time exposing (Time, millisecond)
import StartData exposing (buildings, upgrades, tick)

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every tick Msgs.Tick

init : ( Model, Cmd Msg )
init =
    (Model 0 0 1 buildings upgrades, Cmd.none )

-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }