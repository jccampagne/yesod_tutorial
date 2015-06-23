{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}

import Subsite
import Yesod


data Master = Master
    { subsite  :: Subsite
    }


instance Yesod Master

mkYesod "Master" [parseRoutes|
/         HomeR GET
/subsite  SubsiteR  Subsite  subsite
|]


getHomeR :: HandlerT Master IO Html
getHomeR = defaultLayout
    [whamlet|
        <h1>Welcome to Yesod
        <p>
            This is the master site.
        <p>
            got to the #
            <a href=@{SubsiteR SubsiteHomeR}>subsite
            \ .
    |]

main =
    let masterSite = Master Subsite in
    warp 3000 masterSite
