#--- Get name ethnicities function ---#
#'@title Request ethnicity probabilities from NamePrism
#'@description Sends names to NamePrism and returns probabilities for its six U.S. ethnicity categories. These are name-based predictions, not self-reported identities.
#'@author Charles Crabtree \email{ccrabtr@umich.edu} and Christian Chacua \email{christian-mauricio.chacua-delgado@u-bordeaux.fr}
#'@param x A vector of names,  in the form "First_name Last_name". If there are multiple segments separated by white spaces, only the first and the last segments are taken into account.
#'@param t Your NamePrism API token. You must supply one; NULL stops the call. See \url{https://www.name-prism.com/api} for more details.
#'@param warnings If TRUE, warn when a request fails. The default is FALSE.
#'@return A data frame of dimensions length(x)*9, with the probability of belonging to each of the 6 different U.S. ethnicities. Errors (e.g. connection is interrupted, invalid tokens) are handled as NA.
#'@examples
#' # Prepare input vector of names
#' x <- c("Charles Crabtree", "Volha Chykina", "Christian Chacua",
#'        "Christian Mauricio Chacua")
#'
#' # Expected output columns
#' expected_cols <- c("input", "encoded_name", "url",
#'                    "2PRACE", "Hispanic", "API",
#'                    "Black", "AIAN", "White")
#' print(expected_cols)
#'
#' \dontrun{
#' # Using the API token (you should get your own token)
#' y <- get_ethnicities(x, t = "YOUR_NAMEPRISM_TOKEN", warnings = FALSE)
#' y
#' # "Christian Chacua" and "Christian Mauricio Chacua" have the same
#' # probabilities as "Mauricio" is not taken into account.
#' }
#'@importFrom utils setTxtProgressBar txtProgressBar
#'@export

get_ethnicities <- function(x, t=NULL, warnings = FALSE) {
  if(is.null(t)){
  stop("Please set a valid API token (t)")
  }

  t<-as.character(t)
  pb <- txtProgressBar(min = 0, max = length(x), style = 3)
  ethnicities <- data.frame(matrix(NA, nrow = length(x), ncol = 9))
  colnames(ethnicities) <- c("input", "encoded_name", "url",
                             "2PRACE", "Hispanic", "API",
                             "Black", "AIAN", "White")
  for(i in 1:length(x)) {
    encoded_name <- RCurl::curlEscape(x[i])
    address <- paste0("https://www.name-prism.com/api_token/eth/json/",t,"/", encoded_name)
    r <- tryCatch(as.data.frame(jsonlite::fromJSON(address)),
                  error=function(e){
                    if(warnings==TRUE){
                    warning(paste0("Error: the name '", x[i], "' has been handled as NA. \n Please check your internet connection and your Name-Prism API access token" ), call. = FALSE, immediate. = TRUE)
                    }
                    data.frame(matrix(NA, nrow = 1, ncol = 6))
                  })
    ethnicities[i, ] <- c(x[i], encoded_name, address, r[1,])
    setTxtProgressBar(pb, i)
  }
  return(ethnicities)
}
