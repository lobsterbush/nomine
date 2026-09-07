# Warp AI Rules for nomine

## Project Overview
This is an R package that provides functions to classify names based on gender, 6 U.S. ethnicities, or 39 leaf nationalities using the NamePrism and NamSor v2 APIs.

## Development Guidelines

### Package Structure
- Standard R package structure with DESCRIPTION, NAMESPACE, R/, man/ directories
- Current version: 1.0.2
- License: MIT
- Maintainer: Charles Crabtree (crabtreedcharles@gmail.com)

### API Integration
- **NamePrism**: Used for ethnicity and nationality classification (free, rate-limited to 60/min)
  - Token required: http://www.name-prism.com/api
  - Always use HTTPS endpoints (HTTP endpoints no longer work)
- **NamSor v2**: Used for gender classification (5,000 units/month free)
  - API key required: https://v2.namsor.com/NamSorAPIv2/sign-in.html
  - Uses single `api_key` parameter (not separate `secret` and `user`)

### Dependencies
- Core imports: httr, RCurl, jsonlite, utils
- Suggested: knitr, rmarkdown
- Never add unnecessary dependencies

### Documentation
- Use roxygen2 (version 7.2.3) for documentation
- All exported functions must have complete documentation with examples
- Examples should use placeholder text for API keys (e.g., "YOUR_NAMEPRISM_TOKEN")
- Include cost and rate-limit information in documentation

### Testing
- Test API responses with test_api_responses.R
- Use the example code provided in function documentation
- Verify both free and paid tier functionality

### Code Style
- Follow standard R package conventions
- Function names use snake_case: `get_ethnicities()`, `get_nationalities()`, `get_gender()`
- Include `warnings` parameter for optional warning suppression where appropriate
- Return data frames with clear column names

### Key Functions
1. `get_ethnicities(names, t, warnings = FALSE)` - 6 U.S. ethnicities via NamePrism
2. `get_nationalities(names, t, warnings = FALSE)` - 39 leaf nationalities via NamePrism  
3. `get_gender(given, family, api_key)` - Gender classification via NamSor v2

### Version Control
- Git repository at: http://github.com/lobsterbush/nomine
- Use NEWS.md to document changes between versions
- Follow semantic versioning

### Distribution
- Available on CRAN
- Development version on GitHub
- Zenodo DOI for citation: https://zenodo.org/badge/latestdoi/105415000
- See CRAN_SUBMISSION_INSTRUCTIONS.md and cran-comments.md for submission process

### Error Handling
- Handle API rate limits gracefully
- Provide informative error messages for API failures
- Validate input data before making API calls

### Performance Considerations
- NamePrism rate limit: 60 requests/minute
- Batch API calls appropriately to respect rate limits
- Include timing estimates in documentation for large batches


## Documentation

Build locally with `source(here::here("data-raw", "01_build_site.R"))`.
GitHub Pages serves `gh-pages`. Declared provenance: Human – AI (editor) 👤✏️🤖.
