module View.Render exposing (display)


import Html exposing (..)
import Html.Attributes exposing (..)

import Data.Render exposing (..)
import Data.Raw as Data
import Data.Formatted as Data


display : Email -> Html msg
display email =
  let
    mainStyle =
      style
        [ ("color", "black")
        , ("padding", "5px")
        , ("background-color", "white")
        , ("border-radius", "3px")
        ]
    content =
      case email of
        Raw raw -> [ text raw ]
        Formatted email -> formatted email
  in
    div [ mainStyle ] content

formatted : Data.Formatted -> List (Html msg)
formatted email =
  let
    subject =
      div
        [ style
          [
          ]
        ] [ text email.subject ]
    from =
      div
        [ style
          [
          ]
        ] [ text email.from ]
    body =
      pre
        [ style
          [ ("white-space", "pre-wrap")
          , ("margin", "12px 0 0 0")
          ]
        ] [ text email.body ]
  in
    [ div
      [ style
        [ ("display", "grid")
        , ("grid-template-columns", "1fr")
        , ("grid-auto-flow", "column")
        , ("gap", "10px")
        ]
      ]
      [ subject
      , from
      ]
    , body
    ]
