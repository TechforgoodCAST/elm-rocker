module Update exposing (..)

import Http
import Model exposing (..)
import Request exposing (postRequest)


init : ( Model, Cmd Msg )
init =
    { threadIds = []
    , currentThread = []
    }
        ! [ Http.send ReceivePosts postRequest ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceivePosts (Ok postList) ->
            { model | currentThread = postList } ! []

        ReceivePosts (Err err) ->
            let
                log =
                    Debug.log "error" err
            in
                model ! []
