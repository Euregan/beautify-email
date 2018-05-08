module View.Formatted exposing (display)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Data.Formatted exposing (..)


-- VIEW

display : Formatted -> (String -> msg) -> (String -> msg) -> (String -> msg) -> Html msg
display email onSubject onFrom onBody =
  let
    mainStyle =
      style
        [ ("display", "flex")
        , ("flex-direction", "column")
        ]
  in
    div [ mainStyle ]
      [ subject email.subject onSubject
      , from email.from onFrom
      , body email.body onBody
      ]

inputStyle : List (String, String) -> Attribute msg
inputStyle styles =
  style (List.append
    [ ("background-color", "#353535")
    , ("border-radius", "3px")
    , ("border", "none")
    , ("padding", "5px 10px")
    , ("margin-bottom", "5px")
    ]
    styles)

subject : Subject -> (String -> msg) -> Html msg
subject subject onSubject =
  input [ type_ "text", placeholder "Subject", onInput onSubject, value subject, inputStyle [] ] []

from : Someone -> (String -> msg) -> Html msg
from from onFrom =
  input [ type_ "text", placeholder "From", onInput onFrom, value from, inputStyle [] ] []

body : Body -> (String -> msg) -> Html msg
body body onBody =
  textarea
    [ placeholder "Body"
    , onInput onBody
    , value body
    , inputStyle
      [ ("resize", "none")
      , ("margin-bottom", "0")
      , ("height", "250px")
      ]
    ] []
