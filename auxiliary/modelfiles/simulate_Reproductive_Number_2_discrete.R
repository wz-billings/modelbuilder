#' Reproductive Number 2
#' 
#' @description A reproductive number model built from expanding the basic SIR model. 
#' 
#' @details The model includes susceptible, infected, and recovered compartments. The processes that are modeled are infection, recovery, birth, death, and immunity.
#' 
#' This code is was generated by the modelbuilder package R.  
#' The model is implemented as a set of discrete time equations using a for loop. 
 
#' The following R packages need to be loaded for the function to work: none 
#' 
#' Starting conditions for model variables 
#' @param S : starting value for Susceptible : numeric
#' @param I : starting value for Infected : numeric
#' @param R : starting value for Recovered : numeric
#' Values for model parameters : numeric 
#' @param b : infection rate : numeric
#' @param g : recovery rate : numeric
#' @param m : birth rate : numeric
#' @param n : death rate : numeric
#' @param w : lose immunity : numeric
#' Values for model times : numeric 
#' @param tstart : Start time of simulation : numeric
#' @param tfinal : Final time of simulation : numeric
#' @param dt : Time step : numeric
#' @return The function returns the output as a list. 
#' The time-series from the simulation is returned as a dataframe saved as list element \code{ts}. 
#' The \code{ts} dataframe has one column per compartment/variable. The first column is time.   
#' @examples  
#' # To run the simulation with default parameters:  
#' result <- simulate_Reproductive_Number_2_discrete() 
#' # To choose values other than the standard one, specify them like this:  
#' result <- simulate_Reproductive_Number_2_discrete(S = 2000,I = 2,R = 0) 
#' # You can display or further process the result, like this:  
#' plot(result$ts[,'time'],result$ts[,'S'],xlab='Time',ylab='Numbers',type='l') 
#' print(paste('Max number of S: ',max(result$ts[,'S']))) 
#' @section Warning: This function does not perform any error checking. So if you try to do something nonsensical (e.g. have negative values for parameters), the code will likely abort with an error message.
#' @section Model Author: Alexis Vittengl 
#' @section Model creation date: 2020-06-26
#' @section Code Author: generated by the \code{modelbuilder} R package 
#' @section Code creation date: 2020-06-26
#' @export 
 
simulate_Reproductive_Number_2_discrete <- function(S = 1000, I = 1, R = 0, b = 0.002, g = 0.1, m = 1.2, n = 0.05, w = 0.02, tstart = 0, tfinal = 100, dt = 0.1) 
{ 
  #Function that encodes simulation loop 
  Reproductive_Number_2_fct <- function(vars, pars, times) 
  {
    with( as.list(c(vars,pars)), {  
      ts = data.frame(cbind(times, matrix(0,nrow=length(times),ncol=length(vars)))) 
      colnames(ts) = c('time','S','I','R') 
      ct=1 #a counter to index array 
      for (t in times) 
      {
        ts[ct,] = c(t,S,I,R) 
        Sp = S + dt*(-b*S*I +m -n*S +w*R) 
        Ip = I + dt*(+b*S*I -g*I -n*I) 
        Rp = R + dt*(+g*I -n*R -w*R) 
        S = Sp 
        I = Ip 
        R = Rp 
        ct = ct + 1 
      } #finish loop 
      return(ts) 
    }) #close with statement 
 } #end function encoding loop 
 
  ############################## 
  #Main function code block 
  ############################## 
  #Creating named vectors 
  varvec = c(S = S, I = I, R = R) 
  parvec = c(b = b, g = g, m = m, n = n, w = w) 
  timevec = seq(tstart, tfinal,by = dt) 
  #Running the model 
  simout <- Reproductive_Number_2_fct(vars = varvec, pars = parvec, times = timevec) 
  #Setting up empty list and returning result as data frame called ts 
  result <- list() 
  result$ts <- simout 
  return(result) 
} 
