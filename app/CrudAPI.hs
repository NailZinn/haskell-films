{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE KindSignatures #-}

module CrudAPI where

import Servant
import GHC.Base

type CrudAPI (path :: Symbol) getType createType id = path :>
  (    Get '[JSON] [getType]
  :<|> Capture "id" id :> Get '[JSON] (Maybe getType)
  :<|> ReqBody '[JSON] createType :> PostNoContent
  :<|> Capture "id" id :> DeleteNoContent
  )