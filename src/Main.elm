module Main exposing (..)

import Ports exposing (..)


----- MODEL ----


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
            ( { model | device = iPhoneModel }, Cmd.none )

        ChooseiPad ->
            ( { model | device = iPadModel }, Cmd.none )

        ChangeZoom zoom ->
            ( { model | device = (setZoom model.device zoom) }, Cmd.none )


setZoom : Device -> Float -> Device
setZoom device zoom =
    { device | zoom = zoom }
