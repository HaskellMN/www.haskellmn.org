--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
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

    match "templates/*" $ compile templateCompiler


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
