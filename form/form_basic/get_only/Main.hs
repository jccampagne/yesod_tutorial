{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE MultiParamTypeClasses #-}
import Yesod
import Data.Text

data Master = Master

mkYesod "Master" [parseRoutes|
/ HomeR GET
|]

instance Yesod Master

data Item = Item
    { name  :: Text
    , price :: Double
    }

instance RenderMessage Master FormMessage where
    renderMessage _ _ = defaultFormMessage

itemForm :: Maybe Item -> AForm Handler Item
itemForm maybeItem = Item
    <$> areq textField   "Name"  (name  <$> maybeItem)
    <*> areq doubleField "Price" (price <$> maybeItem)

renderItemForm :: Maybe Item -> Html -> MForm Handler (FormResult Item, Widget)
renderItemForm maybeItem =
    let form = itemForm maybeItem in
    renderDivs form

getHomeR :: HandlerT Master IO Html
getHomeR = do
    (widget, enctype) <- generateFormPost $ renderItemForm Nothing
    defaultLayout $
        [whamlet|
            <h1>Welcome to Yesod
            <form method=post enctype=#{enctype}>
                ^{widget}
                <input type=submit>
        |]

main :: IO ()
main = warp 3000 $ Master
