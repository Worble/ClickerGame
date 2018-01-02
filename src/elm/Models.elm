module Models exposing (..)

import Time exposing (Time)

type alias Model =
    { 
        counter : Float
        , amountPerTick : Float
        , amountPerClick : Float
        , buildings : List Building
        , upgrades : List Upgrade
    }

type alias Building =
    {
        id : Int
        , cost : Float
        , initialCost : Float
        , value : Float
        , amount : Float
        , name : String
        , description : String
        , modifier : Float
        , costModifier : Float
        , isTemp : Bool
        , tempTime : Float
        , temp : List Float
    }

type alias Upgrade =
    {
        id : Int
        , modifier : Float
        , cost : Float
        , buildingId : Int
        , bought : Bool
        , name : String
        , description : String
    }