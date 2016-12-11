module Handler.PersonEdit where

import Import

getPersonEditR :: PersonId -> Handler Html
getPersonEditR personId = do
    person <- runDB $ get404 personId
    defaultLayout $ do
        $(widgetFile "people/edit")

postPersonEditR :: PersonId -> Handler Html
postPersonEditR personId = error "Not yet implemented: postPersonEditR"
