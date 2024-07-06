{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}

module Films.FilmAPI 
  ( FilmAPI
  , filmAPI
  ) where

import Servant
import Films.Film
import CrudAPI
import Database.SQLite.Simple
import Control.Monad.IO.Class
import Data.Function

type FilmAPI = CrudAPI "films" Film CreateFilm FilmId

filmAPI :: Server FilmAPI
filmAPI = getAllFilms :<|> getFilmById :<|> createFilm :<|> deleteFilm

getAllFilms :: Handler [Film]
getAllFilms =
  withConnection "db/app.db" (`query_` "select * from Films") & liftIO

getFilmById :: FilmId -> Handler (Maybe Film)
getFilmById x = do
  films <- withConnection "db/app.db" 
    (\c -> query c "select * from Films where id = (?)" (Only x) :: IO [Film]) & liftIO
  return $ case films of
    [film] -> Just film
    _ -> Nothing

createFilm :: CreateFilm -> Handler NoContent
createFilm createModel = do
  withConnection "db/app.db" (\c -> execute c "insert into Films(name, year) values (?, ?)" createModel) & liftIO 
  return NoContent

deleteFilm :: FilmId -> Handler NoContent
deleteFilm filmId = do
  withConnection "db/app.db" (\c -> execute c "delete from Films where id = (?)" (Only filmId)) & liftIO
  return NoContent