module Model exposing (..)

import Date exposing (Date)
import Http


type alias Model =
    { threadIds : List Int
    , currentThread : List Post
    }


type alias Post =
    { subject : String
    , body : String
    , postId : Int
    , date : Date
    }


type Msg
    = ReceivePosts (Result Http.Error (List Post))
