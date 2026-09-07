#--- Get gender function ---#
#'@title Request gender predictions from NamSor
#'@description Sends given and family names to NamSor and returns its gender prediction and scale.
#'@author Charles Crabtree \email{ccrabtr@umich.edu}
#'@param given A vector of given names (i.e. first names).
#'@param family A vector of family names (i.e. surnames or last names).
#'@param api_key Your NamSor API key. Get one at \url{https://namsor.app/}
#'@return A data frame with the input names, API URL, predicted gender and scale.
#'@examples
#' # Prepare input vectors
#' first_name <- c("Volha", "Charles", "Donald")
#' last_name <- c("Chykina", "Crabtree", "Duck")
#'
#' # Expected output columns
#' expected_cols <- c("id", "first_name", "last_name", "api_url", "scale", "gender")
#' print(expected_cols)
#'
#' \dontrun{
#' # Note: the vectors of first and last names should be the same length.
#' key <- "YOUR_NAMSOR_API_KEY"
#' y <- get_gender(first_name, last_name, key)
#' y
#' }
#'@importFrom utils setTxtProgressBar txtProgressBar
#'@export

get_gender <- function(given, family, api_key) {
  pb <- txtProgressBar(min = 0, max = length(given), style = 3)
  gender <- data.frame(matrix(NA, nrow = length(given), ncol = 6))
  colnames(gender) <- c("id", "first_name", "last_name", "api_url",
                        "scale", "gender")
  for(i in 1:length(given)) {
    address <- paste0("https://v2.namsor.com/NamSorAPIv2/api2/json/gender/",
                      given[i], "/", family[i])
    r <- httr::GET(address, httr::add_headers(`X-API-KEY` = api_key))
    r <- httr::content(r, "parse")
    gender[i, ] <- c(i, given[i], family[i], address, r$genderScale, r$likelyGender)
    setTxtProgressBar(pb, i)
  }
  return(gender)
}
