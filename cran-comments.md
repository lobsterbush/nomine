## Resubmission
This is a resubmission of the nomine package which was archived from CRAN on
2018-10-03. The package has been updated to work with current API endpoints:

* Updated NamePrism API calls to use HTTPS (HTTP endpoints no longer work)
* Updated NamSor API integration to v2 with new authentication method
* Updated all URLs to use HTTPS and current domains
* Updated package maintainer information
* Wrapped all API-dependent examples in \dontrun{}
* All functionality has been preserved with only necessary breaking changes to
  API authentication parameters

## Test environments
* local macOS Sonoma 14.6.1, R 4.5.2 (aarch64-apple-darwin20)
* R CMD check --as-cran

## R CMD check results
There were no ERRORs or WARNINGs.

There were 2 NOTEs:

1. New submission / Package was archived on CRAN
   This is expected as we are resubmitting an archived package with updates.

2. Skipping checking HTML validation: 'tidy' doesn't look like recent enough
   HTML Tidy.
   This is a local system configuration note, not a package issue.

## Downstream dependencies
There are no downstream dependencies for this package.
