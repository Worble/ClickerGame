module StartData exposing (..)

import Models exposing (Model, Building, Upgrade)
import Time exposing (Time, millisecond)

tick : Time
tick =
    millisecond*100

buildings : List Building
buildings =
    [ 
        Models.Building 1 10 10 1 0 "Skeleton" "Lasts 10 seconds before melting" 1 0.3 True 10 []
        , Models.Building 2 50 50 10 0 "Zombie" "2spook" 1 0.3 False 0 []
    ]

upgrades : List Upgrade
upgrades =
    [
        Models.Upgrade 1 1 50 1 False "Upgrade Skeletons" "Double skeleton output"
        , Models.Upgrade 2 1 250 2 False "Upgrade Zombies" "Double zombie output"
    ]