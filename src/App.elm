module App exposing (..)

import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Html exposing (..)
import Html.Attributes exposing (..)


---- MODEL ----


type alias Model =
    { message : String
    , logo : String
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { message = "Your Elm App is working!", logo = flags.path }, Cmd.none )



---- UPDATE ----


type Msg
    = NoOp


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )



---- VIEW ----


view : Model -> Html Msg
view model =
    div []
        [ navbar
        , Grid.container [ class "main-container" ]
            [ hiddenView
            , Grid.row [ Row.attrs [ class "no-padding-top" ] ]
                [ Grid.col [] [ text "Select Name" ]
                , iPhoneIframe
                ]
            ]
        ]


navbar : Html Msg
navbar =
    nav [ class "navbar navbar-inverse bg-inverse" ]
        [ h1 [ class "navbar-brand mb-1" ] [ text "Admin Dashboard" ]
        ]


hiddenView : Html Msg
hiddenView =
    Grid.row [ Row.attrs [ class "content-row no-padding-top" ] ]
        [ Grid.col [ Col.xs12, Col.md6, Col.lg3 ] [ text "col-1" ]
        , Grid.col [ Col.xs12, Col.md6, Col.lg3 ] [ text "col-2" ]
        , Grid.col [ Col.xs12, Col.md6, Col.lg3 ] [ text "col-3" ]
        , Grid.col [ Col.xs12, Col.md6, Col.lg3 ] [ text "col-4" ]
        ]


iPhoneIframe : Grid.Column Msg
iPhoneIframe =
    Grid.col [] [ iframe [ height 667, width 375, srcdoc "", id "iPhoneiFrame" ] [] ]



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
