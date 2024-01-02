module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, ul, li, input)
import Html.Events exposing (onSubmit, onInput)
import Html.Attributes exposing (disabled, value)

-- MAIN
main =
    Browser.sandbox
      { init = init
      , update = update
      , view = view
      }

-- MODEL
type alias Model =
    { notes : List String
    , input : String
    }

init : Model
init =
    { notes = []
    , input = ""
    }

-- UPDATE
type Msg
    = Input String
    | Submit

update : Msg -> Model -> Model
update msg model =
    case msg of
        Input input ->
            { model | input = input }
        Submit ->
            { model
                | notes = model.input :: model.notes
                , input = ""
            }
      

-- VIEW
view: Model -> Html Msg
view model =
    div []
        [ ul [] (List.map (\note -> li [] [ text note ]) (List.reverse model.notes))
        , Html.form [ onSubmit Submit ]
            [ input [ value model.input, onInput Input ] []
            , button [ disabled (String.length model.input <1) ] [ text "Add" ]
            ]
        ]
