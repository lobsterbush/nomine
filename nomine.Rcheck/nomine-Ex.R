pkgname <- "nomine"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
base::assign(".ExTimings", "nomine-Ex.timings", pos = 'CheckExEnv')
base::cat("name\tuser\tsystem\telapsed\n", file=base::get(".ExTimings", pos = 'CheckExEnv'))
base::assign(".format_ptime",
function(x) {
  if(!is.na(x[4L])) x[1L] <- x[1L] + x[4L]
  if(!is.na(x[5L])) x[2L] <- x[2L] + x[5L]
  options(OutDec = '.')
  format(x[1L:3L], digits = 7L)
},
pos = 'CheckExEnv')

### * </HEADER>
library('nomine')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("get_ethnicities")
### * get_ethnicities

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: get_ethnicities
### Title: Classifies names based on 6 U.S. ethnicities
### Aliases: get_ethnicities

### ** Examples

# Vector of names.
x <- c("Charles Crabtree", "Volha Chykina", "Christian Chacua",
       "Christian Mauricio Chacua")
# Using the API token a1a2a34aa56789aa (you should get your own token)
y <- get_ethnicities(x, t="a1a2a34aa56789aa", warnings=FALSE)
y
# "Christian Chacua" and "Christian Mauricio Chacua" have the same
# probabilities as "Mauricio" is not taken into account.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("get_ethnicities", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("get_gender")
### * get_gender

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: get_gender
### Title: Classifies names based on gender
### Aliases: get_gender

### ** Examples

## Not run: 
##D first_name <- c("Volha", "Charles", "Donald")
##D last_name <- c("Chykina", "Crabtree", "Duck")
##D 
##D Note that the vectors of first and last names should be the same length.
##D Future versions of the package will deal with differing lengths.
##D 
##D key <- "45b2kjsskd2335435kkmfdksmfkko"
##D y <- get_gender(first_name, last_name, key)
##D y
## End(Not run)



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("get_gender", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
cleanEx()
nameEx("get_nationalities")
### * get_nationalities

flush(stderr()); flush(stdout())

base::assign(".ptime", proc.time(), pos = "CheckExEnv")
### Name: get_nationalities
### Title: Classifies names based on 39 leaf nationalities
### Aliases: get_nationalities

### ** Examples

# Vector of names.
x <- c("Charles Crabtree", "Volha Chykina", "Christian Chacua",
       "Christian Mauricio Chacua")
# Using the API token a1a2a34aa56789aa (you should get your own token)
y <- get_nationalities(x, t="a1a2a34aa56789aa", warnings=FALSE)
y
# "Christian Chacua" and "Christian Mauricio Chacua" have the same
# probabilities as "Mauricio" is not taken into account.



base::assign(".dptime", (proc.time() - get(".ptime", pos = "CheckExEnv")), pos = "CheckExEnv")
base::cat("get_nationalities", base::get(".format_ptime", pos = 'CheckExEnv')(get(".dptime", pos = "CheckExEnv")), "\n", file=base::get(".ExTimings", pos = 'CheckExEnv'), append=TRUE, sep="\t")
### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
