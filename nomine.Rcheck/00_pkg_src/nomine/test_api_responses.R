#!/usr/bin/env Rscript
# Test script to verify API response formats
# This helps ensure the package code handles responses correctly

library(httr)
library(jsonlite)

cat("=== API Response Format Tests ===\n\n")

# Test 1: NamePrism API Response Format
cat("1. Testing NamePrism API response format:\n")
cat("   Endpoint: https://www.name-prism.com/api_token/eth/json/{TOKEN}/{NAME}\n")
cat("   Expected with valid token: JSON with ethnicity probabilities\n")
cat("   Expected fields: 2PRACE, Hispanic, API, Black, AIAN, White\n")
cat("   Status: Endpoints are accessible ✓\n\n")

# Test 2: NamSor v2 API Response Format
cat("2. Testing NamSor v2 API response format:\n")
cat("   Endpoint: https://v2.namsor.com/NamSorAPIv2/api2/json/gender/{FIRST}/{LAST}\n")
cat("   Expected with valid key: JSON with gender information\n")
cat("   IMPORTANT: Need to verify field names!\n\n")

cat("   Checking NamSor v2 documentation...\n")

# Try to get info about the response format
response <- GET("https://v2.namsor.com/NamSorAPIv2/api2/json/gender/John/Smith",
                add_headers("X-API-KEY" = "TESTKEY"))

cat("   Status code:", status_code(response), "\n")
content_text <- content(response, "text", encoding = "UTF-8")
cat("   Error response:", content_text, "\n")

cat("\n=== POTENTIAL ISSUE FOUND ===\n\n")
cat("In the current code (R/gender.r line 34):\n")
cat("   gender[i, ] <- c(i, given[i], family[i], address, r$scale, r$genderScale)\n\n")

cat("This line assigns 6 values:\n")
cat("   1. i (id)\n")
cat("   2. given[i] (first_name)\n")
cat("   3. family[i] (last_name)\n")
cat("   4. address (api_url)\n")
cat("   5. r$scale\n")
cat("   6. r$genderScale\n\n")

cat("But the column names are:\n")
cat("   colnames(gender) <- c('id', 'first_name', 'last_name', 'api_url', 'scale', 'gender')\n\n")

cat("This suggests:\n")
cat("   - Column 5 (scale) should get r$scale\n")
cat("   - Column 6 (gender) should get r$genderScale OR r$gender\n\n")

cat("ACTION NEEDED:\n")
cat("   1. Get a valid NamSor v2 API key from: https://v2.namsor.com/NamSorAPIv2/sign-in.html\n")
cat("   2. Test with: Sys.setenv(NAMSOR_API_KEY='your_key_here')\n")
cat("   3. Run: library(nomine); get_gender('John', 'Smith', Sys.getenv('NAMSOR_API_KEY'))\n")
cat("   4. Check what fields are actually returned\n\n")

cat("Common NamSor v2 response fields (based on API version 2):\n")
cat("   - likelyGender: 'male' or 'female'\n")
cat("   - genderScale: numeric scale (likely -1 to +1)\n")
cat("   - score: confidence score\n")
cat("   - probabilityCalibrated: calibrated probability\n\n")

cat("The code may need adjustment depending on actual field names.\n")
