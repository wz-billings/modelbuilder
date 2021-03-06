############################## 
#R script to generate a modelbuilder model with code, save and export it. 
############################## 
 
 mbmodel = list() #create empty list 
 
 #Model meta-information
 mbmodel$title = 'SEIRSd model'
 mbmodel$description = 'A SEIRS model with 4 compartments'
 mbmodel$author = 'Andreas Handel'
 mbmodel$date = Sys.Date()
 mbmodel$details = 'The model includes susceptible, exposed/asymptomatic, infected/symptomatic, and recovered compartments. The processes that are modeled are infection, progression to infectiousness, recovery and waning immunity. Demographics through natural births and deaths are also included.' 

 #Information for all variables
 var = vector('list',4)
 var[[1]]$varname = 'S'
 var[[1]]$vartext = 'Susceptible'
 var[[1]]$varval = 1000
 var[[1]]$flows = c('-bE*S*E', '-bI*S*I', '+w*R', '+n', '-m*S')
 var[[1]]$flownames = c('infection by exposed', 'infection by symptomatic', 'waning immunity', 'births', 'natural deaths')
 
 var[[2]]$varname = 'E'
 var[[2]]$vartext = 'Exposed'
 var[[2]]$varval = 1
 var[[2]]$flows = c('+bE*S*E', '+bI*S*I', '-gE*E', '-m*E')
 var[[2]]$flownames = c('infection by exposed', 'infection by symptomatic', 'progression to symptoms', 'natural deaths')
 
 var[[3]]$varname = 'I'
 var[[3]]$vartext = 'Infected and Symptomatic'
 var[[3]]$varval = 1
 var[[3]]$flows = c('+gE*E', '-gI*I', '-m*I')
 var[[3]]$flownames = c('progression to symptoms', 'recovery', 'natural deaths')
 
 var[[4]]$varname = 'R'
 var[[4]]$vartext = 'Recovered'
 var[[4]]$varval = 0
 var[[4]]$flows = c('+gI*I', '-w*R', '-m*R')
 var[[4]]$flownames = c('recovery', 'waning immunity', 'natural death')
 
 mbmodel$var = var
 
 #Information for all parameters
 par = vector('list',7)
 par[[1]]$parname = 'bE'
 par[[1]]$partext = 'infection by exposed'
 par[[1]]$parval = 0
 
 par[[2]]$parname = 'bI'
 par[[2]]$partext = 'infection by symptomatic'
 par[[2]]$parval = 0.001
 
 par[[3]]$parname = 'gE'
 par[[3]]$partext = 'progression rate'
 par[[3]]$parval = 1
 
 par[[4]]$parname = 'gI'
 par[[4]]$partext = 'recovery rate'
 par[[4]]$parval = 1
 
 par[[5]]$parname = 'w'
 par[[5]]$partext = 'waning immunity'
 par[[5]]$parval = 1
 
 par[[6]]$parname = 'n'
 par[[6]]$partext = 'births'
 par[[6]]$parval = 0
 
 par[[7]]$parname = 'm'
 par[[7]]$partext = 'deaths'
 par[[7]]$parval = 0
 
 mbmodel$par = par
 
 #Information for time parameters
 time = vector('list',3)
 time[[1]]$timename = 'tstart'
 time[[1]]$timetext = 'Start time of simulation'
 time[[1]]$timeval = 0
 
 time[[2]]$timename = 'tfinal'
 time[[2]]$timetext = 'Final time of simulation'
 time[[2]]$timeval = 100
 
 time[[3]]$timename = 'dt'
 time[[3]]$timetext = 'Time step'
 time[[3]]$timeval = 0.1
 
 mbmodel$time = time