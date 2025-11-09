# nomine 1.0.2
- Updated NamePrism API calls to use HTTPS instead of HTTP (HTTP endpoints are no longer functional)
- Updated NamSor API integration to v2 API with new authentication method
- Changed 'get_gender' function signature: now requires single 'api_key' parameter instead of separate 'secret' and 'user' parameters
- Updated API endpoint URLs to current working endpoints
- Updated package maintainer information and GitHub repository links

# nomine 1.0.1
- The 'get_nationalities' and 'get_ethnicities' functions have been updated to include the Name-Prism API access token and to handle errors.

# nomine 1.0.0
- nomine has now been updated to include the functionality from varo. This means that it has a new 'get_gender' function, which can be used to classify names by gender.
