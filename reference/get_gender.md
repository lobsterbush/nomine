# Request gender predictions from NamSor

Sends given and family names to NamSor and returns its gender prediction
and scale.

## Usage

``` r
get_gender(given, family, api_key)
```

## Arguments

- given:

  A vector of given names (i.e. first names).

- family:

  A vector of family names (i.e. surnames or last names).

- api_key:

  Your NamSor API key. Get one at <https://namsor.app/>

## Value

A data frame with the input names, API URL, predicted gender and scale.

## Author

Charles Crabtree <ccrabtr@umich.edu>

## Examples

``` r
# Prepare input vectors
first_name <- c("Volha", "Charles", "Donald")
last_name <- c("Chykina", "Crabtree", "Duck")

# Expected output columns
expected_cols <- c("id", "first_name", "last_name", "api_url", "scale", "gender")
print(expected_cols)

if (FALSE) { # \dontrun{
# Note: the vectors of first and last names should be the same length.
key <- "YOUR_NAMSOR_API_KEY"
y <- get_gender(first_name, last_name, key)
y
} # }
```
