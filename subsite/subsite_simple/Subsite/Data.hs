{-# LANGUAGE QuasiQuotes     #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies    #-}

module Subsite.Data where

import Yesod

data Subsite = Subsite

mkYesodSubData "Subsite" [parseRoutes|
/ SubsiteHomeR GET
|]
