module View.Raw exposing (display)

import Html exposing (..)

import Data.Raw exposing (Raw)


-- VIEW

display : Raw -> Html msg
display raw =
  textarea [] [ text raw ]
