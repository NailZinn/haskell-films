{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}

module Films.Film where

import Data.Aeson
import GHC.Generics
import Database.SQLite.Simple

data Film = Film 
  { id :: FilmId
  , name :: String
  , year :: Int 
  } deriving (Eq, Show, Generic, FromRow)
  
instance ToJSON Film

data CreateFilm = CreateFilm
  { name' :: String
  , year' :: Int
  } deriving (Generic, ToRow)

instance FromJSON CreateFilm

type FilmId = Int