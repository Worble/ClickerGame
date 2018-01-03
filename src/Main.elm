module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, Building, Upgrade)
import Update exposing (update)
import View exposing (view)
import Time exposing (Time, millisecond)
import StartData exposing (buildings, upgrades, tick, spells, model)
import Ports exposing (save, load, doload)

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch 
        [ Time.every tick Msgs.Tick
        , load Msgs.Load
        ]

init : ( Model, Cmd Msg )
init =
    (model, Cmd.none )

-- MAIN
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }