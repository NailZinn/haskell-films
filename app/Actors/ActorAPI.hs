{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module Actors.ActorAPI
  ( ActorAPI
  , actorAPI
  ) where

import Servant
import Actors.Actor
import CrudAPI
import Database.SQLite.Simple
import Control.Monad.IO.Class
import Data.Function

type ActorAPI = CrudAPI "actors" Actor CreateActor ActorId

actorAPI :: Server ActorAPI
actorAPI = getAllActors :<|> getActorById :<|> createActor :<|> deleteActor

getAllActors :: Handler [Actor]
getAllActors =
  withConnection "db/app.db" (`query_` "select * from Actors") & liftIO

getActorById :: ActorId -> Handler (Maybe Actor)
getActorById x = do
  actors <- withConnection "db/app.db"
    (\c -> query c "select * from Actors where id = (?)" (Only x) :: IO [Actor]) & liftIO
  return $ case actors of
    [actor] -> Just actor
    _ -> Nothing

createActor :: CreateActor -> Handler NoContent
createActor createModel = do
  withConnection "db/app.db" (\c -> execute c "insert into Actors(name, age) values(?, ?)" createModel) & liftIO
  return NoContent

deleteActor :: ActorId -> Handler NoContent
deleteActor actorId = do
  withConnection "db/app.db" (\c -> execute c "delete from Actors where id = (?)" (Only actorId)) & liftIO
  return NoContent