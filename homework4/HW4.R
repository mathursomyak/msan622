require(tm)        # corpus
require(SnowballC) # stemming

# Explore Sources #####
# getSources()
# getReaders()

# Create Corpus #####
# Many of these options are not required, but
# I want to show them to you.

sotu_source <- DirSource(
    # indicate directory
    directory = file.path("sotu"),
    encoding = "UTF-8",     # encoding
    pattern = "*.txt",      # filename pattern
    recursive = FALSE,      # visit subdirectories?
    ignore.case = FALSE)    # ignore case in pattern?

sotu_corpus <- Corpus(
    sotu_source, 
    readerControl = list(
        reader = readPlain, # read as plain text
        language = "en"))   # language is english
