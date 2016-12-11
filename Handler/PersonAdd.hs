module Handler.PersonAdd where

import Import
import Yesod.Form.Bootstrap3

-- data Person = Person
--     { email :: Text
--     , password :: Text
--     }
--   deriving Show

addPersonForm :: AForm Handler Person
addPersonForm = Person
            <$> areq textField (bfs ("Email" :: Text)) Nothing
            <*> areq textField (bfs ("Password" :: Text)) Nothing

getPersonAddR :: Handler Html
getPersonAddR = do
    (widget, enctype) <- generateFormPost $ renderBootstrap3 BootstrapBasicForm addPersonForm
    defaultLayout $ do
        $(widgetFile "people/add")

postPersonAddR :: Handler Html
postPersonAddR = do
    ((res, widget), enctype) <- runFormPost $ renderBootstrap3 BootstrapBasicForm addPersonForm
    case res of
        FormSuccess newPerson -> do
            personId <- runDB $ insert newPerson
            redirect $ PersonEditR personId
        _ -> defaultLayout $(widgetFile "people/add")