{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}

import Yesod
import Data.Time.Clock
import Data.Text

data Master = Master

mkYesod "Master" [parseRoutes|
/ HomeR GET
|]

instance Yesod Master

getHomeR :: HandlerT Master IO Html
getHomeR = defaultLayout $ do
    theTime <- liftIO getCurrentTime
    let theTimeStr = show theTime
    [whamlet|
        <h1>Welcome to Yesod
        <p>
            The time is: #{theTimeStr}
    |]

main = warp 3000 $ Master
