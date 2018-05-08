module Data.Render exposing (Email(..))

import Data.Raw as Data
import Data.Formatted as Data


type Email
  = Raw Data.Raw
  | Formatted Data.Formatted
