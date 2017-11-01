module Request exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Extra exposing (date)
import Json.Decode.Pipeline exposing (..)
import Json.Encode as Encode
import Model exposing (..)


postRequest : Http.Request (List Post)
postRequest =
    Http.post
        "http://localhost:9200/forum/_search?size=250"
        (Http.jsonBody postBody)
        payloadDecoder


postBody : Encode.Value
postBody =
    Encode.object
        [ ( "query"
          , Encode.object
                [ ( "terms"
                  , Encode.object
                        [ ( "topic_id"
                          , Encode.list
                                [ Encode.int 5804
                                , Encode.int 5882
                                , Encode.int 8995
                                ]
                          )
                        ]
                  )
                ]
          )
        , ( "sort"
          , Encode.object
                [ ( "message_id"
                  , Encode.object
                        [ ( "order"
                          , Encode.string "desc"
                          )
                        ]
                  )
                ]
          )
        ]


payloadDecoder : Decode.Decoder (List Post)
payloadDecoder =
    Decode.at [ "hits", "hits" ] (Decode.list <| Decode.field "_source" postDecoder)


postDecoder : Decode.Decoder Post
postDecoder =
    decode Post
        |> required "subject" Decode.string
        |> required "body" Decode.string
        |> required "message_id" Decode.int
        |> required "creation_date" date
