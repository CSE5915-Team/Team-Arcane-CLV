app <- ShinyDriver$new("../../", loadTimeout = 100000)
app$snapshotInit("testKMeansLoading")

app$snapshot()
