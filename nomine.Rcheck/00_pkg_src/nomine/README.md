![](http://www.r-pkg.org/badges/version/nomine) ![](http://cranlogs.r-pkg.org/badges/grand-total/nomine) ![](http://cranlogs.r-pkg.org/badges/nomine)
[![DOI](https://zenodo.org/badge/105415000.svg)](https://zenodo.org/badge/latestdoi/105415000)[![Rdoc](http://www.rdocumentation.org/badges/version/nomine)](http://www.rdocumentation.org/packages/nomine)

# nomine: Functions to classify names based on gender, 6 U.S. ethnicities, or 39 leaf nationalities.

Large social science literatures are devoted to examining the role of an individual's gender, ethnicity, or nationality on a host of behaviors and circumstances. This means that researchers often want to know these characteristics of individuals. Not all pre-existing datasets contain this information, though, and it can be difficult for scholars to locate, particularly if they work with exotic samples. 

Even if reseachers do not have data on these theoretically important covariates for individuals, though, there in many cases in which they know individual names. Thanks to recent developments in machine learning, these names can be used to probabilistically identify the gender, ethnicity, leaf nationality, or origin of their bearers. These exciting advancements can potentially catalyze existing research programs on gender, race, ethnicity, coethnicity, and national origins.

Unfortunately, most of the available name classifiers are very expensive to use. Thankfully, there are two free or cheap-to-use tools that this package leverages:

### APIs Used

**[NamePrism](http://name-prism.com/)** - A non-commercial program for academic research
- **Cost:** Free with API token (60 requests/minute rate limit)
- **Get token:** [http://www.name-prism.com/api](http://www.name-prism.com/api)
- **Used for:** Ethnicity and nationality classification
- **Reference:** [Ye et al 2017](https://arxiv.org/abs/1708.07903)

**[NamSor v2](https://v2.namsor.com/)** - Commercial API with free tier
- **Cost:** 5,000 units/month free (gender = 1 unit/name)
- **Get API key:** [https://v2.namsor.com/NamSorAPIv2/sign-in.html](https://v2.namsor.com/NamSorAPIv2/sign-in.html)
- **Used for:** Gender classification
- **Info:** [https://github.com/namsor/namsor-api](https://github.com/namsor/namsor-api)

The `nomine` package provides simple R functions to query these APIs without needing to write custom code.

## Functions

### `get_ethnicities(names, t, warnings = FALSE)`
Classify names by **6 U.S. ethnicities** using NamePrism.
- **Input:** Vector of full names ("First Last")
- **Returns:** Probabilities for: 2PRACE, Hispanic, API, Black, AIAN, White
- **Cost:** Free (rate-limited)

### `get_nationalities(names, t, warnings = FALSE)`
Classify names by **39 leaf nationalities** using NamePrism.
- **Input:** Vector of full names ("First Last")
- **Returns:** Probabilities for 39 cultural/national origin categories
- **Cost:** Free (rate-limited)
- **Categories:** See [http://name-prism.com/about](http://name-prism.com/about)

### `get_gender(given, family, api_key)`
Classify names by **gender** using NamSor v2.
- **Input:** Vectors of first and last names
- **Returns:** Gender classification ("male"/"female") and scale (-1 to +1)
- **Cost:** 1 unit per name (5,000 free/month)

## Package Installation
The latest development version (1.0.2) is on GitHub and can be installed using devtools.

```r
if(!require("devtools")){
    install.packages("devtools")
}
devtools::install_github("lobsterbush/nomine")
```

## Usage Examples

### Get API Keys First
```r
# Get your NamePrism token: http://www.name-prism.com/api
# Get your NamSor API key: https://v2.namsor.com/NamSorAPIv2/sign-in.html
```

### Classify Ethnicities
```r
library(nomine)

# Example names
names <- c("Charles Crabtree", "Volha Chykina", "Maria Garcia")

# Get ethnicity probabilities
results <- get_ethnicities(names, t = "YOUR_NAMEPRISM_TOKEN")

# View results
print(results[, c("input", "White", "Hispanic", "Black")])
#                 input     White  Hispanic     Black
# 1 Charles Crabtree      0.85      0.03      0.05
# 2    Volha Chykina      0.72      0.02      0.01
# 3     Maria Garcia      0.15      0.78      0.02
```

### Classify Nationalities
```r
# Get nationality probabilities
results <- get_nationalities(names, t = "YOUR_NAMEPRISM_TOKEN")

# View top nationality for each name
print(results[, c("input", "CelticEnglish", "European-Russian", "Hispanic-Spanish")])
#                 input CelticEnglish European-Russian Hispanic-Spanish
# 1 Charles Crabtree          0.82             0.03             0.02
# 2    Volha Chykina          0.05             0.68             0.01
# 3     Maria Garcia          0.03             0.01             0.75
```

### Classify Gender
```r
# Example names (first and last separate)
first_names <- c("Volha", "Charles", "Maria")
last_names <- c("Chykina", "Crabtree", "Garcia")

# Get gender classifications
results <- get_gender(first_names, last_names, api_key = "YOUR_NAMSOR_KEY")

# View results
print(results[, c("first_name", "last_name", "gender", "scale")])
#   first_name last_name gender scale
# 1      Volha  Chykina female  0.95
# 2    Charles Crabtree   male -0.99
# 3      Maria   Garcia female  0.89
```

### Cost Comparison

**For 1,000 names:**

| Function | API | Cost | Notes |
|----------|-----|------|---------|
| `get_ethnicities()` | NamePrism | **Free** | Rate-limited to 60/min (~17 min total) |
| `get_nationalities()` | NamePrism | **Free** | Rate-limited to 60/min (~17 min total) |
| `get_gender()` | NamSor v2 | **Free** | Uses 1,000 of 5,000 free units/month |

**For 10,000 names:**
- Ethnicities/Nationalities: Still **free** with NamePrism (takes ~3 hours)
- Gender: 10,000 units = **$10** with NamSor (5,000 free + 5,000 paid)

### Why This Combination?

The package uses **NamePrism** for ethnicity/nationality because it's free and designed for academic research, while using **NamSor v2** for gender because:
- Gender classification is computationally simpler (1 unit vs 10 units)
- 5,000 free gender classifications per month covers most research needs
- NamSor's gender classifier is highly accurate and well-maintained

## Changes in Version 1.0.2
- Updated NamePrism API calls to use HTTPS (the HTTP endpoints no longer work)
- Updated NamSor API to v2 with new authentication method
- The `get_gender()` function now requires only a single `api_key` parameter instead of separate `secret` and `user` parameters
- Get your NamSor API key at: https://v2.namsor.com/NamSorAPIv2/sign-in.html

## Support or Contact
Please use the issue tracker for problems, questions, or feature requests. If you would rather email with questions or comments, you can contact [Charles Crabtree](mailto:crabtreedcharles@gmail.com) or [Christian Chacua](mailto:christian-mauricio.chacua-delgado@u-bordeaux.fr) and they will try to address the issue.

If you would like to contribute to the package, that is great! We welcome pull requests and new developers.

## Tests
Users and potential contributors can test the software with the example code provided in the documentation for each function.

## Thanks
Thanks to [Karl Broman](https://github.com/kbroman) and [Hadley Wickham](http://hadley.nz/) for providing excellent free guies to building R packages.
