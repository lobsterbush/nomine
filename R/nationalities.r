#--- Get name leaf nationalities function ---#
#'@title Request nationality probabilities from NamePrism
#'@description Sends names to NamePrism and returns probabilities for its 39 leaf nationality categories.
#'@author Charles Crabtree \email{ccrabtr@umich.edu} and Christian Chacua \email{christian-mauricio.chacua-delgado@u-bordeaux.fr}
#'@param x A vector of names,  in the form "First_name Last_name". If there are multiple segments separated by white spaces, only the first and the last segments are taken into account.
#'@param t Your NamePrism API token. You must supply one; NULL stops the call. See \url{https://www.name-prism.com/api} for more details.
#'@param warnings If TRUE, warn when a request fails. The default is FALSE.
#'@return A data frame of dimensions length(x)*42, with the probability of belonging to each of the 39 different leaf CEL groups of the Name-Prism taxonomy (see \url{https://www.name-prism.com/about}). Errors (e.g. connection is interrupted, invalid tokens) are handled as NA.
#'@examples
#' # Prepare input vector of names
#' x <- c("Charles Crabtree", "Volha Chykina", "Christian Chacua",
#'        "Christian Mauricio Chacua")
#'
#' # Expected output columns (3 metadata + 39 leaf nationalities)
#' n_output_cols <- 42L
#' print(n_output_cols)
#'
#' \dontrun{
#' # Using the API token (you should get your own token)
#' y <- get_nationalities(x, t = "YOUR_NAMEPRISM_TOKEN", warnings = FALSE)
#' y
#' # "Christian Chacua" and "Christian Mauricio Chacua" have the same
#' # probabilities as "Mauricio" is not taken into account.
#' }
#'@importFrom utils setTxtProgressBar txtProgressBar
#'@export

get_nationalities <- function(x, t=NULL, warnings = FALSE) {
  if(is.null(t)){
    stop("Please set a valid API token (t)")
  }

  t<-as.character(t)
  pb <- txtProgressBar(min = 0, max = length(x), style = 3)
  nationalities <- data.frame(matrix(NA, nrow = length(x), ncol = 42))
  colnames(nationalities) <- c("input", "encoded_name", "url",
                               "European-SouthSlavs","Muslim-Pakistanis-Bangladesh",
                               "European-Italian-Italy","European-Baltics",
                               "African-SouthAfrican","European-Italian-Romania",
                               "Muslim-Nubian","European-French",
                               "EastAsian-Indochina-Thailand","EastAsian-Indochina-Vietnam",
                               "Jewish","Muslim-Turkic-CentralAsian",
                               "EastAsian-Indochina-Cambodia","Nordic-Scandinavian-Denmark",
                               "EastAsian-Indochina-Myanmar","Nordic-Finland",
                               "Muslim-Persian","Nordic-Scandinavian-Sweden",
                               "Muslim-Maghreb","Greek","Muslim-Pakistanis-Pakistan",
                               "Hispanic-Portuguese","European-Russian",
                               "Muslim-ArabianPeninsula","African-WestAfrican",
                               "EastAsian-Japan","European-German",
                               "EastAsian-Chinese","SouthAsian","Hispanic-Spanish",
                               "Nordic-Scandinavian-Norway","Muslim-Turkic-Turkey",
                               "Hispanic-Philippines","CelticEnglish",
                               "EastAsian-Malay-Malaysia","EastAsian-South-Korea",
                               "African-EastAfrican","European-EastEuropean",
                               "EastAsian-Malay-Indonesia")
  for(i in 1:length(x)) {
    encoded_name <- RCurl::curlEscape(x[i])
    address <- paste0("https://www.name-prism.com/api_token/nat/json/",t,"/", encoded_name)
    r <- tryCatch(as.data.frame(jsonlite::fromJSON(address)),
                  error=function(e){
                    if(warnings==TRUE){
                      warning(paste0("Error: the name '", x[i], "' has been handled as NA. \n Please check your internet connection and your Name-Prism API access token" ), call. = FALSE, immediate. = TRUE)
                    }
                    data.frame(matrix(NA, nrow = 1, ncol = 39))
                  })
    nationalities[i, ] <- c(x[i], encoded_name, address, r[1,])
    setTxtProgressBar(pb, i)
  }
  return(nationalities)
}
