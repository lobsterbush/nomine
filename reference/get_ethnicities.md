# Request ethnicity probabilities from NamePrism

Sends names to NamePrism and returns probabilities for its six U.S.
ethnicity categories. These are name-based predictions, not
self-reported identities.

## Usage

``` r
get_ethnicities(x, t = NULL, warnings = FALSE)
```

## Arguments

- x:

  A vector of names, in the form "First_name Last_name". If there are
  multiple segments separated by white spaces, only the first and the
  last segments are taken into account.

- t:

  Your NamePrism API token. You must supply one; NULL stops the call.
  See <https://www.name-prism.com/api> for more details.

- warnings:

  If TRUE, warn when a request fails. The default is FALSE.

## Value

A data frame of dimensions length(x)\*9, with the probability of
belonging to each of the 6 different U.S. ethnicities. Errors (e.g.
connection is interrupted, invalid tokens) are handled as NA.

## Author

Charles Crabtree <ccrabtr@umich.edu> and Christian Chacua
<christian-mauricio.chacua-delgado@u-bordeaux.fr>

## Examples

``` r
# Prepare input vector of names
x <- c("Charles Crabtree", "Volha Chykina", "Christian Chacua",
       "Christian Mauricio Chacua")

# Expected output columns
expected_cols <- c("input", "encoded_name", "url",
                   "2PRACE", "Hispanic", "API",
                   "Black", "AIAN", "White")
print(expected_cols)

if (FALSE) { # \dontrun{
# Using the API token (you should get your own token)
y <- get_ethnicities(x, t = "YOUR_NAMEPRISM_TOKEN", warnings = FALSE)
y
# "Christian Chacua" and "Christian Mauricio Chacua" have the same
# probabilities as "Mauricio" is not taken into account.
} # }
```
