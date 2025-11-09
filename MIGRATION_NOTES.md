# nomine Package - Migration Notes

## What was fixed

The `nomine` package stopped working due to API endpoint changes:

### 1. NamePrism API (get_ethnicities, get_nationalities)
- **Issue**: HTTP endpoints (`http://www.name-prism.com/...`) stopped working
- **Fix**: Updated to HTTPS endpoints (`https://www.name-prism.com/...`)
- **Files changed**: `R/ethnicites.R`, `R/nationalities.r`

### 2. NamSor API (get_gender)
- **Issue**: Old NamSor v1 API was deprecated and no longer accessible
- **Fix**: Updated to NamSor v2 API with new authentication method
- **API endpoint changed**: 
  - Old: `https://api.namsor.com/onomastics/api/json/gender/...`
  - New: `https://v2.namsor.com/NamSorAPIv2/api2/json/gender/...`
- **Authentication changed**: 
  - Old: Query parameters `key1` (secret) and `key2` (user)
  - New: HTTP header `X-API-KEY` with single API key
- **Function signature changed**:
  - Old: `get_gender(given, family, secret, user)`
  - New: `get_gender(given, family, api_key)`
- **Response field changed**: `r$gender` → `r$genderScale`
- **Files changed**: `R/gender.r`

### 3. Package metadata
- Updated version: 1.0.1 → 1.0.2
- Updated maintainer email: ccrabtr@umich.edu → crabtreedcharles@gmail.com
- Updated GitHub repository: cdcrabtree/nomine → lobsterbush/nomine
- Updated RoxygenNote: 6.1.0 → 7.2.3
- Updated documentation and README with new API information

## Testing

The package passes all R CMD check tests:
```bash
R CMD build .
R CMD check nomine_1.0.2.tar.gz
# Status: OK
```

## Next Steps to Publish

1. **Create GitHub repository**:
   ```bash
   # Create a new repository on GitHub named 'nomine'
   # Then run:
   cd /Users/f00421k/Documents/GitHub/nomine
   git remote add origin https://github.com/lobsterbush/nomine.git
   git push -u origin master
   ```

2. **Get API Keys**:
   - NamePrism: http://www.name-prism.com/api
   - NamSor v2: https://v2.namsor.com/NamSorAPIv2/sign-in.html

3. **Test with real API calls** (optional):
   ```R
   # Install the package
   devtools::install_github("lobsterbush/nomine")
   
   # Test get_ethnicities
   names <- c("Charles Crabtree", "Volha Chykina")
   ethnicities <- get_ethnicities(names, t="YOUR_NAMEPRISM_TOKEN")
   
   # Test get_gender
   first <- c("Charles", "Volha")
   last <- c("Crabtree", "Chykina")
   genders <- get_gender(first, last, api_key="YOUR_NAMSOR_KEY")
   ```

4. **Consider submitting to CRAN** (optional):
   - Review CRAN policies: https://cran.r-project.org/web/packages/policies.html
   - Submit via: https://cran.r-project.org/submit.html

## Files Modified

- `R/ethnicites.R` - Updated to HTTPS
- `R/gender.r` - Updated to NamSor v2 API
- `R/nationalities.r` - Updated to HTTPS
- `DESCRIPTION` - Version bump, maintainer info, GitHub links
- `README.md` - Updated installation instructions and API info
- `NEWS.md` - Added version 1.0.2 changelog
- `man/get_gender.Rd` - Auto-regenerated documentation

## Repository Structure

```
nomine/
├── R/                      # Source code
│   ├── ethnicites.R
│   ├── gender.r
│   └── nationalities.r
├── man/                    # Documentation
├── paper/                  # Academic paper
├── DESCRIPTION            # Package metadata
├── NAMESPACE              # Exported functions
├── README.md              # Main documentation
├── NEWS.md                # Changelog
└── LICENSE                # MIT License
```
