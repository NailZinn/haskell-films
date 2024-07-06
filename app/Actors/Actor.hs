{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Actors.Actor where

import GHC.Generics
import Data.Aeson
import Database.SQLite.Simple

data Actor = Actor
  { id :: ActorId
  , name :: String
  , age :: Int
  } deriving (Eq, Show, Generic, FromRow)

instance ToJSON Actor

data CreateActor = CreateActor
  { name' :: String
  , age' :: Int
  } deriving (Generic, ToRow)

instance FromJSON CreateActor

type ActorId = Int