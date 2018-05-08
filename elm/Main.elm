module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Data.Raw as Data
import View.Raw
import Data.Formatted as Data
import View.Formatted
import Data.Render
import View.Render


-- MODEL

type alias Model =
  { raw: Data.Raw
  , formatted: Data.Formatted
  , display: Display
  }

type Display
  = Raw
  | Formatted

initialModel =
  Model "" (Data.Formatted "" "" "" "") Formatted

-- UPDATE

type Action
  = ChangeDisplay Display
  | ChangeSubject String
  | ChangeFrom String
  | ChangeBody String

update : Action -> Model -> Model
update action model =
  case action of
    ChangeDisplay display ->
      { model | display = display }
    ChangeSubject subject ->
      let
        email formatted =
          { formatted | subject = subject }
      in
        { model | formatted = email model.formatted }
    ChangeFrom from ->
      let
        email formatted =
          { formatted | from = from }
      in
        { model | formatted = email model.formatted }
    ChangeBody body ->
      let
        email formatted =
          { formatted | body = body }
      in
        { model | formatted = email model.formatted }

-- VIEW

view : Model -> Html Action
view model =
  let
    email =
      case model.display of
        Raw -> View.Raw.display model.raw
        Formatted -> View.Formatted.display
          model.formatted
          ChangeSubject
          ChangeFrom
          ChangeBody
    render =
      case model.display of
        Raw -> Data.Render.Raw model.raw
        Formatted ->
          Data.Render.Formatted model.formatted
    mainStyle =
      style
        [ ("background-color", "#121212")
        , ("color", "white")
        , ("height", "100%")
        , ("padding-top", "15px")
        ]
    boxStyle =
      style
        [ ("margin", "auto")
        , ("max-width", "768px")
        , ("font-family", "sans-serif")
        ]
    contentStyle =
      style
        [ ("display", "flex")
        , ("justify-content", "space-between")
        ]
    inputStyle =
      style
        [ ("width", "48%")
        ]
    outputStyle =
      style
        [ ("width", "48%")
        ]
  in
    section [ mainStyle ] [ div [ boxStyle ]
      [ h1 [ style [("margin", "0 0 20px 0")] ] [ text "Beautemail" ]
      -- , div []
      --   [ label [ for "display" ] [ text "Raw" ]
      --   , input [ type_ "checkbox", id "display", onCheck (\checked -> if checked then ChangeDisplay Raw else ChangeDisplay Formatted) ] []
      --   ]
      , div [ contentStyle ]
        [ div [ inputStyle ] [ email ]
        , div [ outputStyle ] [ View.Render.display render ]
        ]
      ]]

-- MAIN

main =
  Html.beginnerProgram
    { model = initialModel
    , view = view
    , update = update
    }
