--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}

module Main (feedFromCtx, main) where


import           Data.Monoid (mappend)
import           Hakyll
import           Data.List        (isPrefixOf, isSuffixOf)
import           System.FilePath  (takeFileName)


--------------------------------------------------------------------------------
main :: IO ()
main = hakyllWith config $ do
    match ("favicon.ico"
           .||. "404.html"
           .||. "images/*"
           .||. "robots.txt"
           .||. "presentations/*"
           .||. "papers/*"
           .||. (fromRegex "\\.widely.*")) $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "*.md" $ do
        route   $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/default.html" defaultContext
            >>= relativizeUrls

    match "posts/*" $ do
        route $ setExtension "html"
        compile $ pandocCompiler
            >>= loadAndApplyTemplate "templates/post.html"    postCtx
            >>= saveSnapshot "content"
            >>= loadAndApplyTemplate "templates/default.html" postCtx
            >>= relativizeUrls

    create ["archive.html"] $ do
        route idRoute
        compile $ do
            posts <- recentFirst =<< loadAll "posts/*"
            let archiveCtx =
                    listField "posts" postCtx (return posts) `mappend`
                    constField "title" "Archives"            `mappend`
                    defaultContext

            makeItem ""
                >>= loadAndApplyTemplate "templates/archive.html" archiveCtx
                >>= loadAndApplyTemplate "templates/default.html" archiveCtx
                >>= relativizeUrls

    create ["atom.xml"] $ do
        route idRoute
        compile $ feedFromCtx $ bodyField "description" `mappend` postCtx


    create ["tweets.xml"] $ do
        route idRoute
        compile $ feedFromCtx $ postCtx

    match "templates/*" $ compile templateCompiler


feedFromCtx :: Context String -> Compiler (Item String)
feedFromCtx feedCtx = do
    posts <- fmap (take 10) . recentFirst =<<
        loadAllSnapshots "posts/*" "content"
    renderAtom myFeedConfiguration feedCtx posts


--------------------------------------------------------------------------------

config = defaultConfiguration
         { ignoreFile = ignoreFile'
         , deployCommand = "pushd _site && widely push && popd"
         }
  where
    ignoreFile' path
        | ".widely"    `isPrefixOf` fileName = False
        | "."    `isPrefixOf` fileName = True
        | "#"    `isPrefixOf` fileName = True
        | "~"    `isSuffixOf` fileName = True
        | ".swp" `isSuffixOf` fileName = True
        | otherwise                    = False
      where
        fileName = takeFileName path

--------------------------------------------------------------------------------
postCtx :: Context String
postCtx =
    dateField "date" "%B %e, %Y" `mappend`
    defaultContext



myFeedConfiguration :: FeedConfiguration
myFeedConfiguration = FeedConfiguration
    { feedTitle       = "HaskellMN"
    , feedDescription = "Announcments and information about the Minnesota Haskell users group"
    , feedAuthorName  = "HaskellMN"
    , feedAuthorEmail = "haskellmn@googlegroups.com"
    , feedRoot        = "http://www.haskell.mn"
    }
