port module App exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


---- MODEL ----


type alias Model =
    { name : String
    , age : String
    , location : String
    }


initModel : Model
initModel =
    { name = ""
    , age = ""
    , location = ""
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initModel
    , renderPreview ()
    )



---- UPDATE ----


type Msg
    = NameInput String
    | AgeInput String
    | LocationInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NameInput name ->
            ( { model | name = name }, renderPreview () )

        AgeInput age ->
            ( { model | age = age }, renderPreview () )

        LocationInput location ->
            ( { model | location = location }, renderPreview () )



---- VIEW ----


stylesheet =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" "//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
            ]

        children =
            []
    in
        node tag attrs children


view : Model -> Html Msg
view model =
    div []
        [ navbar
        , Grid.container [ class "main-container" ]
            [ hiddenView model
            , Grid.row [ Row.attrs [ class "padding-top" ] ]
                [ Grid.col [] [ frameControlSection ]
                , Grid.col [] [ iPhoneIframe ]
                ]
            ]
        ]


navbar : Html Msg
navbar =
    nav [ class "navbar navbar-inverse bg-inverse" ]
        [ h1 [ class "navbar-brand mb-1" ] [ text "Elm iPhone Preview" ]
        ]


hiddenView : Model -> Html Msg
hiddenView model =
    div [ class "content-row" ]
        [ stylesheet
        , Grid.row []
            [ Grid.col [ Col.xs12 ]
                [ Grid.row [ Row.attrs [ style [ ( "padding", "1rem" ) ] ] ]
                    [ Grid.col []
                        [ h6 [] [ text "My name is: " ]
                        ]
                    , Grid.col [] [ h6 [] [ text model.name ] ]
                    ]
                ]
            ]
        , Grid.row []
            [ Grid.col [ Col.xs12 ]
                [ Grid.row [ Row.attrs [ style [ ( "padding", "1rem" ) ] ] ]
                    [ Grid.col []
                        [ h6 [] [ text "I am: " ]
                        ]
                    , Grid.col []
                        [ h6 []
                            [ text model.age
                            , text
                                (if (String.isEmpty model.age) then
                                    ""
                                 else
                                    " Years Old"
                                )
                            ]
                        ]
                    ]
                ]
            ]
        , Grid.row []
            [ Grid.col [ Col.xs12 ]
                [ Grid.row [ Row.attrs [ style [ ( "padding", "1rem" ) ] ] ]
                    [ Grid.col []
                        [ h6 [] [ text "I live in: " ]
                        ]
                    , Grid.col [] [ h6 [] [ text model.location ] ]
                    ]
                ]
            ]
        ]


frameControlSection : Html Msg
frameControlSection =
    Grid.row []
        [ Grid.col []
            [ Grid.row []
                [ Grid.col []
                    [ h2 [] [ text "Control iPhone Preview" ] ]
                ]
            , Grid.row []
                [ Grid.col [] [ frameControlForm ]
                ]
            ]
        ]


frameControlForm : Html Msg
frameControlForm =
    Form.form []
        [ Form.group []
            [ Form.label [ for "myname" ] [ text "What is your name?" ]
            , Input.text [ Input.id "myname", Input.onInput NameInput ]
            ]
        , Form.group []
            [ Form.label [ for "myage" ] [ text "How old are you?" ]
            , Input.text [ Input.id "myage", Input.onInput AgeInput ]
            ]
        , Form.group []
            [ Form.label [ for "mylocation" ] [ text "Where do you live?" ]
            , Input.text [ Input.id "mylocation", Input.onInput LocationInput ]
            ]
        ]


iPhoneIframe : Html Msg
iPhoneIframe =
    iframe
        [ height 667
        , width 375
        , srcdoc ""
        , id "iphoneFrame"
        , name "iphoneFrame"
        , seamless True
        ]
        []



---- PROGRAM ----


type alias Flags =
    { path : String
    }


port renderPreview : () -> Cmd msg


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
