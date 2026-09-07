[![nomine: Human – AI (editor) 👤✏️🤖](man/figures/provenance.svg)](https://thelatentreview.com/provenance/)

![](https://www.r-pkg.org/badges/version/nomine) ![](https://cranlogs.r-pkg.org/badges/grand-total/nomine) ![](https://cranlogs.r-pkg.org/badges/nomine)
[![DOI](https://zenodo.org/badge/105415000.svg)](https://zenodo.org/badge/latestdoi/105415000)[![Rdoc](https://www.rdocumentation.org/badges/version/nomine)](https://www.rdocumentation.org/packages/nomine)

# nomine: Name-based predictions in R <a href="https://lobsterbush.github.io/nomine/"><img src="man/figures/logo.png" align="right" width="140" alt="nomine hex sticker" /></a>

[Package documentation](https://lobsterbush.github.io/nomine/) · [Function reference](https://lobsterbush.github.io/nomine/reference/index.html)

We built `nomine` to request name-based predictions from NamePrism and NamSor
without writing a separate API client. The functions return the provider's
results in a data frame, with the input names alongside them.

These predictions can help with a research task when names are the information
we have. They don't tell us how a person identifies. I'd start by checking
whether the provider's categories fit the question I'm asking.

Authors: Charles Crabtree, Volha Chykina, Micah Gell-Redman, and Christian Chacua.

## Installation

Install the development version from GitHub:

```r
# install.packages("remotes")
remotes::install_github("lobsterbush/nomine")
```

You'll need R and the dependencies listed in `DESCRIPTION`. API calls also need
a network connection and your own provider credentials.

## Providers

[NamePrism](https://name-prism.com/) supplies probabilities over six U.S.
ethnicity categories and 39 leaf nationality categories. Get a token through
[its API page](https://www.name-prism.com/api).

- **Reference:** [Ye et al 2017](https://arxiv.org/abs/1708.07903)

[NamSor](https://namsor.app/) supplies gender predictions from given and family
names. Get an API key from [NamSor](https://namsor.app/). Its
[API documentation](https://github.com/namsor/namsor-api) describes the service.

Check the providers' current access terms and charges before running a batch.
The package doesn't set those terms.

## Request ethnicity probabilities

Store your token in `NAMEPRISM_TOKEN`, then pass a vector of full names:

```r
library(nomine)

names <- c("Charles Crabtree", "Volha Chykina", "Maria Garcia")
ethnicity <- get_ethnicities(names, t = Sys.getenv("NAMEPRISM_TOKEN"))
ethnicity[, c("input", "White", "Hispanic", "Black")]
```

The six prediction columns are `2PRACE`, `Hispanic`, `API`, `Black`, `AIAN`,
and `White`. Those labels come from NamePrism. The values depend on the service's response.

## Request nationality probabilities

```r
nationality <- get_nationalities(names, t = Sys.getenv("NAMEPRISM_TOKEN"))
names(nationality)
head(nationality)
```

The output includes 39 leaf categories. See
[NamePrism's category descriptions](https://name-prism.com/about) before
interpreting them as a measure of national origin.

## Request gender predictions

NamSor takes given and family names separately. Store the key in
`NAMSOR_API_KEY`:

```r
gender <- get_gender(
  given = c("Volha", "Charles", "Maria"),
  family = c("Chykina", "Crabtree", "Garcia"),
  api_key = Sys.getenv("NAMSOR_API_KEY")
)
gender[, c("first_name", "last_name", "gender", "scale")]
```

Read `gender` and `scale` as outputs of the provider's classifier. The function
help lists the returned columns.

## Failed requests

NamePrism requests that fail are recorded with missing prediction values.
Set `warnings = TRUE` if you'd like a warning for each failed name. Inspect
missing results before analysing a batch; a missing prediction isn't a zero.

The package sends names to the provider when you call these functions. The
examples in the function help show their inputs without making a request;
the live examples are marked separately.

## Help and contributions

Please use the [issue tracker](https://github.com/lobsterbush/nomine/issues)
for bugs or questions. You can also email
[Charles Crabtree](mailto:charles.crabtree@monash.edu) or
[Christian Chacua](mailto:christian-mauricio.chacua-delgado@u-bordeaux.fr).
We welcome pull requests.

## Thanks
Thanks to [Karl Broman](https://github.com/kbroman) and [Hadley Wickham](https://hadley.nz/) for providing excellent free guides to building R packages.


## Documentation and provenance

Browse the [documentation and function reference](https://lobsterbush.github.io/nomine/).

**Human – AI (editor) 👤✏️🤖**

We wrote every initial version ourselves, without AI. We've used AI only for
later updates and code fixes. I'm Charles Crabtree, and this is my account of
how the package was made.

The label follows [The Latent Review’s provenance standard](https://thelatentreview.com/provenance/),
shared under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
The software remains MIT licensed.

## Build the documentation

Install R and the package dependencies listed in `DESCRIPTION`, then install
`pkgdown` and `here`. From the repository root, run:

```r
source(here::here("data-raw", "01_build_site.R"))
```

The site is built locally in `docs/`. Publish the rendered contents to the
`gh-pages` branch; GitHub Pages serves that branch.
