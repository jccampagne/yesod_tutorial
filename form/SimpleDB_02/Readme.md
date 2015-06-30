Compile the project with:
```
yesod devel
```

Go to the URL:
```
http://127.0.0.1:3000/stores
```

The list should be empty.

In another shell, launch:
```
cabal repl
```


and issue some commands like:
```
id1 <- db $ insert $ Store "First store"  Nothing
id2 <- db $ insert $ Store "Second store" (Just "London, UK")
id3 <- db $ insert $ Store "Store 3"      (Just "London, UK")
```


You do not have to use the ids if you do not want to:
```
db $ insert $ Store "Store quatro (Just "Tahiti")
db $ insert $ Store "Store 5"     (Just "Bali")
```

You'll get an error if you try to reissue the same command:
```
db $ insert $ Store "Store 5"     (Just "Bali")
```

Something like:
```
*Application> db $ insert $ Store "Store 5"     (Just "Bali")
29/Jun/2015:16:45:50 +0100 [Debug#SQL] SELECT "id" FROM "store" WHERE _ROWID_=last_insert_rowid(); [] @(<unknown>:<unknown> <unknown>:0:0)
29/Jun/2015:16:45:51 +0100 [Debug#SQL] INSERT INTO "store"("name","location") VALUES(?,?); [PersistText "Store 5",PersistText "Bali"] @(<unknown>:<unknown> <unknown>:0:0)
*** Exception: runFakeHandler issue: InternalError "SQLite3 returned ErrorConstraint while attempting to perform step."
```


If you reload the page http://127.0.0.1:3000/stores
You should see a couple of entries now.
