module View exposing (view)

import Html exposing (Html, div, text, button)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Msgs exposing (Msg)
import Models exposing (Model, Building)


view : Model -> Html Msg
view model =
    div [ class "container grid-xl" ]
    [ 
        div [ class "columns" ]
        [
            div [ class "column col-sm-12 col-6" ]
            [
                div [ class "columns" ]
                [ 
                    div [ class "column col-12" ]
                    [ 
                        text "Count/second: "
                        , text (toString (round (model.amountPerTick * 10))) 
                    ]
                ]
                , div [ class "columns" ]
                [ 
                    div [ class "column col-12" ]
                    [ 
                        text "Current Count: "
                        , text (toString (round model.counter)) 
                    ]
                ]
                , div [ class "columns" ]
                [ 
                    div [ class "column col-12" ]
                    [ 
                        text "Each manual click is worth: "
                        , text (toString model.amountPerClick) 
                    ]
                ]
                , div [ class "columns" ]
                [
                    div [ class "column col-12" ]
                    [ 
                        button [ class "btn", onClick Msgs.Click ] [ text "Increment Counter" ]
                    ]
                ]
            ]
            , div [ class "column col-sm-12 col-6" ]
            [ 
                div [ class "columns" ]
                [ 
                    div [ class "column col-12"]
                    [ 
                        text "Upgrades" 
                    ]
                    , div [ class "column col-12"]
                     (viewUpgrades model.upgrades)
                ]
                , div [ class "columns" ]
                [ 
                    div [ class "column col-12"]
                    [ 
                        text "Buildings" 
                    ]
                    , div [ class "column col-12"]
                     (List.map viewBuilding model.buildings)
                ]
            ]               
        ]
    ]

viewBuilding : Models.Building -> Html Msg
viewBuilding building =
    div [] 
    [
        button [ class "btn btn-primary", onClick (Msgs.BuyBuilding building), style [("white-space", "unset"), ("height", "unset")] ] [ text (buyBuildingButtonText building) ] 
    ]

buyBuildingButtonText : Models.Building -> String
buyBuildingButtonText building =
    building.name ++ " (+" ++ (toString (building.value * building.modifier)) ++  " clicks per second): " ++ building.description ++ " (cost " ++ (toString building.cost) ++ ") (owned: " ++ (toString building.amount) ++ ")"

viewUpgrades : List Models.Upgrade -> List (Html Msg)
viewUpgrades upgrades =
    List.map
        viewUpgrade
        (
            List.filterMap 
            (\upgrade ->
                if upgrade.bought
                then
                    Nothing
                else
                    Just upgrade
            )
            upgrades
        )        

viewUpgrade : Models.Upgrade -> Html Msg
viewUpgrade upgrade =
    div [] 
    [
        button [ class "btn", onClick (Msgs.BuyUpgrade upgrade) ] [ text (buyUpgradeButtonText upgrade) ] 
    ]

buyUpgradeButtonText : Models.Upgrade -> String
buyUpgradeButtonText upgrade =
    upgrade.name ++ ": " ++ upgrade.description ++ " (cost " ++ (toString upgrade.cost) ++ ")"
