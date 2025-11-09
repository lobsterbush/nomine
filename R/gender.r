#--- Get gender function ---#
#'@title Classifies names based on gender
#'@description Returns an object that classifies inputted names according to gender.
#'@author Charles Crabtree \email{ccrabtr@umich.edu}
#'@param given A vector of given names (i.e. first names).
#'@param family A vector of family names (i.e. surnames or last names).
#'@param api_key A NameSor API Key. This is typically a long string of mixed-case letters and numbers. Get yours at https://v2.namsor.com/NamSorAPIv2/sign-in.html
#'@return An object that classifies inputted names according to gender.
#'@examples
#' \dontrun{
#' first_name <- c("Volha", "Charles", "Donald")
#' last_name <- c("Chykina", "Crabtree", "Duck")
#'
#' Note that the vectors of first and last names should be the same length.
#' Future versions of the package will deal with differing lengths.
#'
#' key <- "45b2kjsskd2335435kkmfdksmfkko"
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
    gender[i, ] <- c(i, given[i], family[i], address, r$scale, r$genderScale)
    setTxtProgressBar(pb, i)
  }
  return(gender)
}
