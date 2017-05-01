port module App exposing (..)

import Bootstrap.Button as Button
import Bootstrap.Form as Form
import Bootstrap.Form.Input as Input
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Html exposing (..)
import Html.Attributes exposing (..)
import Material.Slider as Slider
import Round


---- MODEL ----


type alias Model =
    { name : String
    , age : String
    , location : String
    , device : Device
    }


type alias Device =
    { name : String
    , width : Int
    , height : Int
    , zoom : Float
    }


initModel : Model
initModel =
    { name = ""
    , age = ""
    , location = ""
    , device = initDeviceModel
    }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( initModel
    , renderPreview ()
    )


initDeviceModel : Device
initDeviceModel =
    iPhoneModel


iPhoneModel : Device
iPhoneModel =
    { name = "iPhone"
    , width = 375
    , height = 667
    , zoom = 1.0
    }


iPadModel : Device
iPadModel =
    { name = "iPad"
    , width = 768
    , height = 1024
    , zoom = 0.75
    }



---- UPDATE ----


type Msg
    = NameInput String
    | AgeInput String
    | LocationInput String
    | ChangeZoom Float
    | ChooseiPhone
    | ChooseiPad


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NameInput name ->
            ( { model | name = name }, renderPreview () )

        AgeInput age ->
            ( { model | age = age }, renderPreview () )

        LocationInput location ->
            ( { model | location = location }, renderPreview () )

        ChooseiPhone ->
            ( { model | device = iPhoneModel }, renderPreview () )

        ChooseiPad ->
            ( { model | device = iPadModel }, renderPreview () )

        ChangeZoom zoom ->
            ( { model | device = (setZoom model.device zoom) }, renderPreview () )


setZoom : Device -> Float -> Device
setZoom device zoom =
    { device | zoom = zoom }



---- VIEW ----


stylesheet : String -> Html Msg
stylesheet link =
    let
        tag =
            "link"

        attrs =
            [ attribute "rel" "stylesheet"
            , attribute "property" "stylesheet"
            , attribute "href" link
            ]

        children =
            []
    in
        node tag attrs children


view : Model -> Html Msg
view model =
    div []
        [ navbar "Elm Live Preview"
        , Grid.container [ class "main-container" ]
            [ hiddenView model
            , Grid.row [ Row.attrs [ class "padding-top" ] ]
                [ Grid.col [] [ frameControlSection model ]
                , Grid.col [] [ iPhoneIframe model ]
                ]
            ]
        ]


navbar : String -> Html Msg
navbar title =
    nav [ class "navbar navbar-inverse bg-inverse" ]
        [ h1 [ class "navbar-brand mb-1" ] [ text title ]
        ]


hiddenView : Model -> Html Msg
hiddenView model =
    div [ class "content-row" ]
        [ stylesheet "//maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css"
        , stylesheet "//cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.3.2/css/mdb.min.css"
        , navbar model.device.name
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


frameControlSection : Model -> Html Msg
frameControlSection model =
    Grid.row []
        [ Grid.col []
            [ Grid.row []
                [ Grid.col []
                    [ h2 [] [ text "Control iPhone Preview" ] ]
                ]
            , Grid.row []
                [ Grid.col [] [ frameControlForm ]
                ]
            , Grid.row []
                [ Grid.col []
                    [ h4 [ class "pb-2 pt-2" ]
                        [ text "Set Zoom"
                        , text " ("
                        , text ((model.device.zoom * 100.0) |> (Round.round 2))
                        , text " %)"
                        ]
                    , slider model
                    ]
                ]
            , Grid.row []
                [ Grid.col []
                    [ Button.button
                        [ Button.primary
                        , Button.onClick ChooseiPhone
                        ]
                        [ text "iPhone" ]
                    , Button.button
                        [ Button.primary
                        , Button.onClick ChooseiPad
                        , Button.attrs [ class "ml-1" ]
                        ]
                        [ text "iPad" ]
                    ]
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


slider : Model -> Html Msg
slider model =
    p []
        [ Slider.view
            [ Slider.onChange ChangeZoom
            , Slider.value model.device.zoom
            , Slider.min 0.1
            , Slider.max 2.0
            , Slider.step 0.01
            ]
        ]


iPhoneIframe : Model -> Html Msg
iPhoneIframe model =
    div [ style [ ( "height", "10px" ), ( "width", "10px" ) ] ]
        [ iframe
            [ height model.device.height
            , width model.device.width
            , srcdoc ""
            , style
                [ ( "transform"
                  , (String.concat [ "scale(", (toString model.device.zoom), ")" ])
                  )
                , ( "transform-origin", "left top 0px" )
                ]
            , id "iphoneFrame"
            , name "iphoneFrame"
            , seamless False
            ]
            []
        ]



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
