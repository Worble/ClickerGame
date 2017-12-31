module Main exposing (..)

import Html exposing (program)
import Msgs exposing (Msg)
import Models exposing (Model, Building, Upgrade)
import Update exposing (update)
import View exposing (view)
import Time exposing (Time, millisecond)


init : ( Model, Cmd Msg )
init =
    (Model 0 0 1 buildings upgrades, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every (millisecond*100) Msgs.Tick

buildings : List Building
buildings =
    [ 
        Models.Building 1 10 1 0 "Skeleton" "Spooky" 1
        , Models.Building 2 50 10 0 "Zombie" "Scary" 1
    ]

upgrades : List Upgrade
upgrades =
    [
        Models.Upgrade 1 1 50 1 False "Upgrade Skeletons" "Double skeleton output"
        , Models.Upgrade 2 1 250 2 False "Upgrade Zombies" "Double zombie output"
    ]

-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }