# haskell-films

Simple web API for films and actors written in Haskell using Cabal, Servant and SQLite.

To start application run following commands from root directory:
* `db/init.sh` to create database and tables
* `cabal build` to build application
* `cabal run` to run application

You can test API with `app/test.http` file.