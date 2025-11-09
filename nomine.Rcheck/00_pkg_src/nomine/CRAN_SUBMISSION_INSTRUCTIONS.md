# CRAN Submission Instructions for nomine v1.0.2

## Package is Ready! ✅

Your package has been thoroughly tested and is ready for CRAN submission.

### What's been done:
- ✅ Package passes R CMD check --as-cran with only acceptable NOTEs
- ✅ All documentation is properly formatted
- ✅ cran-comments.md is updated with submission notes
- ✅ Package tarball created: `nomine_1.0.2.tar.gz`
- ✅ Code pushed to GitHub: https://github.com/lobsterbush/nomine

## Option 1: Submit via CRAN Web Form (RECOMMENDED)

This is the easiest and most reliable method:

1. **Go to the CRAN submission page:**
   https://cran.r-project.org/submit.html

2. **Fill out the form:**
   - Upload file: `nomine_1.0.2.tar.gz` (in your current directory)
   - Maintainer email: `crabtreedcharles@gmail.com`
   - Package name: `nomine`
   - Version: `1.0.2`

3. **In the comment field, paste this:**
   ```
   This is a resubmission of the nomine package which was archived from CRAN in 2018.
   The package has been updated to work with current API endpoints:
   
   - Updated NamePrism API calls to use HTTPS (HTTP endpoints no longer work)
   - Updated NamSor API integration to v2 with new authentication method
   - Updated package maintainer information
   
   The package passes R CMD check --as-cran with only expected NOTEs (archived package
   resubmission, file timestamps, API call timing, and standard HTML validation).
   
   Full details are in cran-comments.md included in the package.
   ```

4. **Submit and confirm:**
   - Click "Submit"
   - You'll receive a confirmation email at crabtreedcharles@gmail.com
   - Click the confirmation link in the email within 24 hours

5. **Wait for review:**
   - CRAN will review your submission (typically 1-7 days)
   - They may ask questions or request changes
   - Once approved, the package will appear on CRAN

## Option 2: Submit via R Command (Interactive)

If you prefer to use R:

```r
# In R console (requires interaction)
devtools::submit_cran()
```

This will:
1. Ask you to confirm your email
2. Automatically upload the package to CRAN
3. You'll still need to confirm via email

## Option 3: Manual Email Submission (NOT RECOMMENDED)

You can also email CRAN-submissions@R-project.org with the tarball attached, but the web form is preferred.

## After Submission

### What to expect:
1. **Immediate:** Confirmation email - CLICK THE LINK within 24 hours
2. **Within 24-48 hours:** Automated checks run
3. **Within 1-7 days:** Manual review by CRAN team
4. **Possible outcomes:**
   - **Approved:** Package published to CRAN automatically
   - **Request for changes:** Make changes and resubmit
   - **Questions:** Respond promptly to any queries

### Common CRAN responses for resubmissions:
- They may ask about why it was archived (answer: API endpoints changed)
- They may ask about breaking changes (answer: minimal, only API key parameter)
- They may request additional testing

### Tips:
- Respond to CRAN emails within 48 hours
- Be polite and professional
- Make requested changes quickly
- Don't resubmit unless asked or >2 weeks have passed

## Testing Your Submitted Package

After CRAN approval, test installation:

```r
# Install from CRAN
install.packages("nomine")

# Test basic functionality
library(nomine)

# You'll need API keys to test fully:
# - NamePrism: http://www.name-prism.com/api
# - NamSor: https://v2.namsor.com/NamSorAPIv2/sign-in.html
```

## Files Included in Submission

The tarball `nomine_1.0.2.tar.gz` contains:
- All R source code (R/)
- Documentation (man/)
- DESCRIPTION file with package metadata
- README.md with usage instructions
- NEWS.md with version history
- LICENSE file
- cran-comments.md explaining submission

## Support After Publication

Update the GitHub README to mention CRAN:

```r
# Install from CRAN
install.packages("nomine")

# Or install development version from GitHub
devtools::install_github("lobsterbush/nomine")
```

Good luck with your submission! 🚀
