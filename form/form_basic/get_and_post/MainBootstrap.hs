{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
{-# LANGUAGE MultiParamTypeClasses #-}
import Yesod
import Data.Text
import Yesod.Form.Bootstrap3 (BootstrapFormLayout (..), renderBootstrap3,
                              withSmallInput)

data Master = Master

mkYesod "Master" [parseRoutes|
/ HomeR GET POST
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
    renderBootstrap3 BootstrapBasicForm form

getHomeR :: HandlerT Master IO Html
getHomeR = do
    (widget, enctype) <- generateFormPost $ renderItemForm Nothing
    defaultLayout $
        [whamlet|
            <h1>Welcome to Yesod
            <form method=post action=@{HomeR} enctype=#{enctype}>
                ^{widget}
                <input type=submit>
        |]

postHomeR :: Handler Html
postHomeR = do
    ((result, widget), enctype) <- runFormPost $ renderItemForm Nothing
    case result of
        FormSuccess item -> do
            defaultLayout $ [whamlet|
             <h1>Form success
             <form method=post action=@{HomeR} enctype=#{enctype}>
                 ^{widget}
                 <input type=submit>
         |]

        FormFailure messages ->
            defaultLayout $ [whamlet|
             <h1>Form failure
             <p>Messages: #{show messages}
             <form method=post action=@{HomeR} enctype=#{enctype}>
                 ^{widget}
                 <input type=submit>
         |]

        FormMissing ->
            defaultLayout $ [whamlet|
             <h1>Form missing
                 <form method=post action=@{HomeR} enctype=#{enctype}>
                 ^{widget}
                 <input type=submit>
         |]



main :: IO ()
main = warp 3000 $ Master
