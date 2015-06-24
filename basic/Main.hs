{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}

import Yesod
import Data.Text

data Master = Master

mkYesod "Master" [parseRoutes|
/ HomeR GET
|]

instance Yesod Master

getHomeR :: HandlerT Master IO Html
getHomeR = defaultLayout $ do
    [whamlet|
        <h1>Welcome to Yesod
        <p>
            This is the homepage
    |]

main = warp 3000 $ Master
