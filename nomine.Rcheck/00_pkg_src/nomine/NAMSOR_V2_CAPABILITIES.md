# NamSor v2 API Capabilities Analysis

## Overview

NamSor v2 API offers **much more** than just gender classification. It could potentially replace both NamePrism functions (ethnicities and nationalities) and add new capabilities.

## Current Package Functions

| Function | API Used | Cost per Name |
|----------|----------|---------------|
| `get_gender()` | NamSor v2 | 1 unit |
| `get_ethnicities()` | NamePrism | Free (60/min with token) |
| `get_nationalities()` | NamePrism | Free (60/min with token) |

## NamSor v2 Capabilities

### ✅ Currently Implemented

#### 1. Gender Classification
- **Endpoint:** `GET /api2/json/gender/{firstName}/{lastName}`
- **Cost:** 1 unit per name
- **Response fields:**
  - `likelyGender`: "male" or "female"
  - `genderScale`: -1 (male) to +1 (female)
  - `score`: confidence score
  - `probabilityCalibrated`: probability value

### 🔄 Potential Additions (Could Replace NamePrism)

#### 2. Origin/Nationality Classification
- **Endpoint:** `GET /api2/json/origin/{firstName}/{lastName}`
- **Cost:** 10 units per name
- **Response fields:**
  - `countryOrigin`: Most likely country (ISO2 code)
  - `countryOriginAlt`: Second best alternative
  - `countriesOriginTop`: Top 10 countries (array)
  - `regionOrigin`: Geographic region
  - `subRegionOrigin`: Sub-region
  - `probabilityCalibrated`: probability
  - `score`: confidence score

**Comparison to NamePrism `get_nationalities()`:**
- ✅ Provides country-level classification (similar to NamePrism's 39 leaf nationalities)
- ✅ Returns top alternatives
- ✅ Includes geographic region information
- ❌ Costs 10 units per name (vs NamePrism free with token)
- ❌ Returns ISO2 codes not ethnic/cultural categories

#### 3. US Race/Ethnicity Classification
- **Endpoint:** `GET /api2/json/usRaceEthnicity/{firstName}/{lastName}`
- **Cost:** 10 units per name
- **Response fields:**
  - `raceEthnicity`: Most likely category
  - `raceEthnicityAlt`: Second alternative
  - `raceEthnicitiesTop`: List of race/ethnicities (array)
  - `score`: confidence score
  - `probabilityCalibrated`: probability

**Categories (US Census taxonomy):**
- `W_NL`: White, non-Latino
- `HL`: Hispanic/Latino
- `A`: Asian, non-Latino
- `B_NL`: Black, non-Latino

**Comparison to NamePrism `get_ethnicities()`:**
- ✅ Provides US race/ethnicity (similar to NamePrism's 6 categories)
- ✅ Uses standard US Census categories
- ✅ Returns alternatives with probabilities
- ❌ Costs 10 units per name (vs NamePrism free with token)
- ❌ Only 4 categories (NamePrism has 6: 2PRACE, Hispanic, API, Black, AIAN, White)
- ⚠️ Different categorization scheme

### 💡 Other Interesting Capabilities

#### 4. Diaspora (Ethnicity given Country of Residence)
- **Endpoint:** `GET /api2/json/diaspora/{countryIso2}/{firstName}/{lastName}`
- **Cost:** 20 units per name
- **Use case:** For melting-pot countries (US, CA, AU, NZ)
- **Better for:** Inferring ethnicity of people living in a specific country

#### 5. Gender with Geographic Context
- **Endpoint:** `GET /api2/json/genderGeo/{firstName}/{lastName}/{countryIso2}`
- **Cost:** 1 unit per name
- **Benefit:** More accurate gender inference with country context
- **Example:** "Andrea" is male in Italy, female in US

#### 6. ZIP Code Enhanced (US only)
- **Endpoint:** `GET /api2/json/usRaceEthnicityZIP5/{firstName}/{lastName}/{zip5Code}`
- **Cost:** 10 units per name
- **Benefit:** More accurate ethnicity inference using ZIP code demographics

## Cost Analysis

### NamSor v2 Pricing (Free Tier)
- **Free:** 5,000 units/month
- **Gender:** 1 unit per name = 5,000 names/month
- **Origin:** 10 units per name = 500 names/month
- **US Ethnicity:** 10 units per name = 500 names/month
- **Diaspora:** 20 units per name = 250 names/month

### NamePrism Pricing (Current)
- **Free:** 60 requests/minute with API token
- **Ethnicities:** Free (rate-limited)
- **Nationalities:** Free (rate-limited)

## Recommendations

### For Current Release (v1.0.2)
✅ **Keep as-is**
- Continue using NamePrism for ethnicities and nationalities (free, established)
- Use NamSor v2 only for gender (cost-effective at 1 unit)
- This maintains backward compatibility and low cost

### For Future Release (v1.1.0 or v2.0.0)

#### Option A: Add NamSor alternatives as separate functions
```r
# New functions alongside existing ones
get_origin_namsor(first, last, api_key)        # 10 units
get_ethnicity_namsor(first, last, api_key)     # 10 units
get_diaspora_namsor(first, last, country, api_key)  # 20 units
get_gender_geo(first, last, country, api_key)  # 1 unit (more accurate)
```

**Pros:**
- Users can choose based on budget and needs
- Backward compatible
- More features available

**Cons:**
- More functions to maintain
- Users need to understand differences

#### Option B: Unified API with provider selection
```r
# Flexible provider selection
get_ethnicities(names, provider="nameprism", token=NULL, api_key=NULL)
get_nationalities(names, provider="nameprism", token=NULL, api_key=NULL)

# Or with NamSor
get_ethnicities(names, provider="namsor", api_key=key)  # Uses usRaceEthnicity
get_nationalities(names, provider="namsor", api_key=key)  # Uses origin
```

**Pros:**
- Clean API
- Easy to switch providers
- Backward compatible (default to NamePrism)

**Cons:**
- More complex implementation
- Different response formats need harmonization

#### Option C: Create a companion package
```r
# Install both
install.packages("nomine")          # Current package (NamePrism + NamSor gender)
install.packages("nomine.namsor")   # Extended NamSor v2 functionality
```

**Pros:**
- Keeps current package simple
- Advanced users can opt-in
- Independent versioning

**Cons:**
- Package fragmentation
- More maintenance burden

## Implementation Priority

If adding NamSor v2 features, suggested priority:

1. **High Priority:** `get_origin()` - Country of origin classification
   - Most similar to existing `get_nationalities()`
   - 10 units is reasonable for many use cases
   - Provides valuable geographic information

2. **Medium Priority:** `get_gender_geo()` - Context-aware gender
   - Same 1-unit cost as current `get_gender()`
   - More accurate for ambiguous names
   - Easy addition to existing function (add optional country parameter)

3. **Low Priority:** `get_ethnicity_us_namsor()` - US-specific ethnicity
   - More expensive (10 units)
   - Limited to US context
   - Different categories than NamePrism
   - NamePrism free alternative works well

4. **Optional:** `get_diaspora()` - Ethnicity in country context
   - Most expensive (20 units)
   - Very specialized use case
   - Best for melting-pot countries

## Code Examples for Future Implementation

### Enhanced Gender with Geography
```r
get_gender <- function(given, family, api_key, country_iso2 = NULL) {
  if (is.null(country_iso2)) {
    # Current implementation
    endpoint <- paste0("gender/", given, "/", family)
  } else {
    # Enhanced with geography (same cost!)
    endpoint <- paste0("genderGeo/", given, "/", family, "/", country_iso2)
  }
  # ... rest of implementation
}
```

### Origin Classification
```r
get_origin <- function(given, family, api_key, top_n = 10) {
  # Returns country of origin with alternatives
  # Cost: 10 units per name
  endpoint <- paste0("origin/", given, "/", family)
  # ... implementation
  # Returns: countryOrigin, alternatives, regions, probabilities
}
```

## Conclusion

**For v1.0.2 (Current):** No changes needed. Current approach is optimal.

**For Future:** NamSor v2 offers compelling alternatives, but the cost difference (10x more expensive) means NamePrism remains the better default. Consider adding NamSor options as premium alternatives for users who need:
- Better accuracy
- More detailed results
- Geographic context
- Single API provider

The most valuable addition would be **geographic-context gender classification** since it's the same cost (1 unit) but more accurate.
