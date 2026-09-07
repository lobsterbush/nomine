# nomine

Research software · R package

Get name-based predictions in R.

We built nomine to call NamePrism and NamSor from R and bring their
predictions back into a data frame.

[Get started ↗](#quick-start)[See the functions
→](https://lobsterbush.github.io/nomine/reference/index.md)

Charles Crabtree, Volha Chykina, Micah Gell-Redman, and Christian Chacua

[![nomine: Human – AI (editor)
👤✏️🤖](reference/figures/provenance.svg)](https://thelatentreview.com/provenance/)

**Initial versions: entirely human-created.** AI was used only for later
updates and code fixes.

## Quick start

``` r
install.packages("remotes")
remotes::install_github("lobsterbush/nomine")
library(nomine)

# Store your provider credentials in environment variables.
get_ethnicities(
  c("Charles Crabtree", "Volha Chykina"),
  t = Sys.getenv("NAMEPRISM_TOKEN")
)
```

API examples require your own credentials and a network connection.
Obtain credentials from [NamePrism](https://www.name-prism.com/api) or
[NamSor](https://namsor.app/); consult the provider for current access
terms.

## Choose the classifier

| Task | Function | Provider |
|----|----|----|
| Probabilities over six U.S. ethnicity categories | [`get_ethnicities()`](https://lobsterbush.github.io/nomine/reference/get_ethnicities.md) | NamePrism |
| Probabilities over leaf nationality categories | [`get_nationalities()`](https://lobsterbush.github.io/nomine/reference/get_nationalities.md) | NamePrism |
| Gender classification from given and family names | [`get_gender()`](https://lobsterbush.github.io/nomine/reference/get_gender.md) | NamSor |

``` r
get_gender(
  given = c("Charles", "Volha"),
  family = c("Crabtree", "Chykina"),
  api_key = Sys.getenv("NAMSOR_API_KEY")
)
```

These are predictions based on names. A person’s own account of their
identity can differ. I’d read the returned probabilities alongside the
provider’s categories before deciding how to use them. The function help
explains the columns and what happens when a request fails.

## Provenance

**Human – AI (editor) 👤✏️🤖**

We wrote every initial version ourselves, without AI. We’ve used AI only
for later updates and code fixes. I’m Charles Crabtree, and this is my
account of how the package was made.

The label and mark follow [The Latent Review’s provenance
standard](https://thelatentreview.com/provenance/), shared under [CC BY
4.0](https://creativecommons.org/licenses/by/4.0/). The software remains
MIT licensed.

## Help and development

If something isn’t working, please tell us in the [issue
tracker](https://github.com/lobsterbush/nomine/issues). The [source and
README](https://github.com/lobsterbush/nomine) include installation
requirements and local documentation build instructions.
