{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Servant
import Network.Wai.Handler.Warp
import Data.Function
import Films.FilmAPI
import Actors.ActorAPI

type API = FilmAPI :<|> ActorAPI

server :: Server API
server = filmAPI :<|> actorAPI

api :: Proxy API
api = Proxy

app :: Application
app = serve api server

main :: IO ()
main = do
  putStrLn "Server started"
  app & run 8000