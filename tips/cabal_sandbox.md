Creating Cabal sandboxes can be long.
Here is a tip to make it faster, by copying bits of if from a previous project.

In new project directory:

```
cd $NEWPROJECT
cabal sandbox init
cp $OLDPROJECT/.cabal-sandbox/x86_64-osx-ghc-7.10.1-packages.conf.d/* $NEWPROJECT/.cabal-sandbox/x86_64-osx-ghc-7.10.1-packages.conf.d/
cabal sandbox hc-pkg recache

if missing new dependencies:

```
cabal install --only-dependencies
```

Sources and useful links:
```
http://www.edsko.net/2015/03/09/sandboxes-revisited/ [see Copying sandboxes sections]
http://www.reddit.com/r/haskell/comments/2ynzen/copying_cabal_sandboxes/
```
