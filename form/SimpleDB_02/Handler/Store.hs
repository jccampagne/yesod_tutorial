module Handler.Store where

import Import
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3,
                              withSmallInput)

getStoreR :: Handler Html
getStoreR = do
    stores <- runDB $ selectList [] [Asc StoreName]
    defaultLayout $ do
        setTitle "Welcome To Yesod!"
        $(widgetFile "store_list")

