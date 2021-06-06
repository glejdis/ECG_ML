#' Extends the input to length dividible by 2^number
#'
#' @param input A list.
#' @param number An integer > 0.
#' @return The last element of input is repeated to
#' the length input2n.
#'
#' @examples
#' extend(c(1,2,3), 2)
#' extend(seq(1,11), 3)
#'
extend<-function(input, number=1){
  input_length <- length(input)
  input2n <- (2^number)*ceiling(input_length/(2^number))
  if(input_length<input2n){
    for (k in (input_length+1) : input2n){
      input[k] <- input[input_length]
    }
  }
  return(input)
}
#' Dynamic Wavelet Transform, number*Haar transform
#'
#' @param input A list.
#' @param number An integer represents the number of DTW,
#'                zero for all iterations.
#' @return DTW applyed number times.
#'
#' Raises an exception if the length is not dividible by 2^number.
#'
#' @examples
#' fwt(c(1,2,3,4), 2)
#' fwt(seq(1,320), 6)
#'
fwt <- function(input, number = 0)
{
  output=c()
  input_length <- length(input)

  if(number == 0) { number = ceiling(log(input_length,2))}
  input=extend(input,number)
  input_length <- length(input)
  for (j in 0:log(input_length, 2)){
    if(input_length %% 2 !=0)
      warning('FWT: Use extend to proper input length.')
    input_length <- floor((input_length)/2)
    for (i in 0:(input_length-1))
    {
      output[i+1] <- (input[i*2+1] + input[i*2+2])/2
      output[input_length + i+1] <- (input[i*2+1] - input[i*2+2])/2
    }
    input=output
    number = number - 1

    if(input_length <= 1 || number == 0) { return(output) }
  }
  return(output)
}

#' Inverse Dynamic Wavelet Transform
#'
#' @param input A list.
#' @param number An integer represents the number of DTW,
#'                zero for all iterations.
#' @return Inverse DTW applyed number times.
#'
#'
#' @examples
#' iwt(c(5,-2,-1,-1), 2)
#' > 2 4 6 8
#' fwt(seq(1,320), 6)
#'

iwt <- function(input, number = 0)
{
  output=c()
  if(number == 0) { number = ceiling(log(length(input),2))}
  input_length <- length(input)

  #print(input)

  for (j in number:1)
  {
    s_input_length=input_length/(2**j)
    for (i in 0: (s_input_length-1))
    {
      output[i*2+1] <- (input[i+1] + input[s_input_length+i+1])
      output[2*i+2] <- (input[i+1] - input[s_input_length+i+1])
    }
    if(2*s_input_length+1<input_length)
    {
      for (k in (2*s_input_length+1) : (input_length))
      { output[k] <- input[k] }
    }

    input=output
    number = number - 1

    if(s_input_length == input_length || number == 0) { return(output) }
  }
  return(output)
}

