library(tools)
library(RCurl)
library(XML)

# In R sourcing other files is not trivial, unfortunately.
# WARNING:
# This method ONLY works for project files in depth one sub dirs!
project.file.path <- function(...) {
  initial.options <- commandArgs(trailingOnly = FALSE)
  file.arg.name <- "--file="
  script.name <- sub(file.arg.name, "", initial.options[grep(file.arg.name, initial.options)])
  script.dir <- dirname(file_path_as_absolute(script.name))
  project.dir <- sub(basename(script.dir),'',script.dir)
  normalizePath(file.path(project.dir,...))
}
src.project.file <- function(...) {
  source(project.file.path(...))
}
src.project.file( 'src','loadUniprotKBEntries.R' )

input.args <- commandArgs( trailingOnly = TRUE )

print("Usage: Rscript downloadUniprotSeqs.R path/2/accession_per_line.txt path/2/output.fasta")

# Read input
accs <- scan( input.args[[ 1 ]], what=character(), sep="\n" )

# Download:
downloadSequences( accs, input.args[[ 2 ]] )