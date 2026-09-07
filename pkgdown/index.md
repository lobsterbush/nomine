# nomine

<div class="repllm-hero">
<p class="eyebrow">Research software · R package</p>
<p class="hero-title">Start with names.<br>Return probabilities.</p>
<p class="hero-summary">R interfaces to NamePrism and NamSor for probabilistic name classification.</p>
<p class="hero-links"><a class="hero-primary" href="#quick-start">Get started ↗</a><a href="reference/index.html">Explore the reference →</a></p>
<p class="hero-meta">Charles Crabtree, Volha Chykina, Micah Gell-Redman, and Christian Chacua</p>
</div>

[![nomine: Human – AI (editor) 👤✏️🤖](reference/figures/provenance.svg)](https://thelatentreview.com/provenance/)

**Initial versions: entirely human-created.** AI was used only for later updates and code fixes.

## Quick start

```r
install.packages("remotes")
remotes::install_github("lobsterbush/nomine")
library(nomine)

# Store your provider credentials in environment variables.
get_ethnicities(
  c("Charles Crabtree", "Volha Chykina"),
  t = Sys.getenv("NAMEPRISM_TOKEN")
)
```

API examples require your own credentials and a network connection. Obtain
credentials from [NamePrism](https://www.name-prism.com/api) or
[NamSor](https://namsor.app/); consult the provider for current access terms.

## Choose the classifier

| Task | Function | Provider |
| --- | --- | --- |
| Probabilities over six U.S. ethnicity categories | [`get_ethnicities()`](reference/get_ethnicities.html) | NamePrism |
| Probabilities over leaf nationality categories | [`get_nationalities()`](reference/get_nationalities.html) | NamePrism |
| Gender classification from given and family names | [`get_gender()`](reference/get_gender.html) | NamSor |

```r
get_gender(
  given = c("Charles", "Volha"),
  family = c("Crabtree", "Chykina"),
  api_key = Sys.getenv("NAMSOR_API_KEY")
)
```

The results are provider predictions from name strings. They do not measure
self-identification. Function references describe returned columns, missing
results, and request behaviour.


## Provenance

**Human – AI (editor) 👤✏️🤖**

All initial versions were created entirely by the human authors, without AI.
AI was used only for subsequent updates and code fixes. This provenance
declaration is supplied by Charles Crabtree.

The label and mark follow [The Latent Review’s provenance standard](https://thelatentreview.com/provenance/),
shared under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
The software remains MIT licensed.

## Help and development

Report bugs or request features in the [issue tracker](https://github.com/lobsterbush/nomine/issues).
The [source and README](https://github.com/lobsterbush/nomine) include installation
requirements and local documentation build instructions.
