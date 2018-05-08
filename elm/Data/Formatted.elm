module Data.Formatted exposing (..)


type alias Formatted =
  { to: Someone
  , from: Someone
  , subject: Subject
  , body: Body
  }

type alias Someone = String

type alias Subject = String

type alias Body = String
