module View exposing (..)

import Model exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)


view : Model -> Html Msg
view model =
    div [ class "tc mt5" ]
        [ p [ class "sans-serif blue" ] [ text "Hello world!" ] ]
