{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}

module Subsite
    ( module Subsite.Data
    , module Subsite
    ) where

import Subsite.Data
import Yesod



getSubsiteHomeR :: Yesod master => HandlerT Subsite (HandlerT master IO) Html
getSubsiteHomeR = do
    lift $ defaultLayout [whamlet|
        <h1>
            Welcome to the subsite!
        <p>Go back to the #
            <a href="/">
                HOME
    |]

instance Yesod master => YesodSubDispatch Subsite (HandlerT master IO) where
    yesodSubDispatch = $(mkYesodSubDispatch resourcesSubsite)
