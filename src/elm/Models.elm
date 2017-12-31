module Models exposing (..)


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
        , value : Float
        , amount : Float
        , name : String
        , description : String
        , modifier : Float
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