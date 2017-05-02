module App exposing (..)

import Html exposing (..)
import Main exposing (..)
import Ports exposing (..)
import View exposing (..)


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initModel
    , renderPreview ()
    )



---- PROGRAM ----


type alias Flags =
    { path : String
    }


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
