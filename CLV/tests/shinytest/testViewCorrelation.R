app <- ShinyDriver$new("../../", loadTimeout = 100000)
app$snapshotInit("testViewCorrelation")

app$snapshot()
