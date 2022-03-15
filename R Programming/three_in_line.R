#This is used to hide warnings whose consequences are already
#dealt with in the code (NOT errors)
oldw <- getOption("warn")

library(stringr)

options(warn = -1)

#First we will define a number of functions which shall be used within the
#final tic_tac_toe() function


#This function is  a modded version I made of the sample() function of
#the base package. It avoids certain feature of sample() by virtue of which
#it behaves differently when the length() == 1
sampling <- function(x,size,replace = F,prob = NULL){
  if (missing(size)) 
    size <- length(x)
  x[sample.int(length(x), size, replace, prob)]
}

#This function returns T if all elements in a vector are equal

allequal <- function(x){
  if (length(unique(x)) == 1 && !any(is.na(x))){
    return(T)
  }else{
    return(F)
  }
}

#This function checks whether victory has happened. When victory happens,
#victory is set to T.

checkv <- function(matriz){
  #Checking whether any of the horizontal or vertical vectors has all its
  #elements equal
  matriz_rev <- matriz[ncol(matriz):1,]
  if (TRUE %in% apply(matriz,1,allequal) || TRUE %in% apply(matriz,2,allequal)
      || allequal(diag(matriz)) || allequal(diag(matriz_rev))){
    assign("victory",T,pos = parent.frame())
  }
}

#This function creates a vector with the matrix index of a position,
#its distance to victory and the prospective winner in the evaled axis
#victory and prospective winner
rankadd <- function(ranker,positions,vector,axis,i,y){
  #The following code represents the different formulas of conversion 
  #from column and row/diagonal position to matrix index. For the meaning
  #of "x" and "y", check the computer_turn() function
  index <- switch(axis,
                  "hor" = i+3*(positions[y] - 1),
                  "ver" = positions[y] + 3*(i - 1),
                  "diag" = 1 + 4*(positions[y] - 1),
                  "diag_rev" = 3 + 2*(positions[y] - 1))
  #The different values are added as a row in the ranker dataframe
  return(rbind(ranker,c(index,sum(is.na(vector)),
                        ifelse(all(is.na(vector)),"NA",names(table(vector))[1]))))
}

#This function adds up the different rankadd vectors of an axis to the
#ranker data frame
pr_pos <- function(vector,axis,ranker,i =0){
  if (length(table(vector)) != 2){
    positions <- which(is.na(vector))
    for (y in 1:length(positions)){
      ranker <- rankadd(ranker,positions,vector,axis,i,y)
    }
  }
  return(ranker)
}

#This function contains the user turn
user_turn <- function(matriz,symbol){
  #This value will be used to verify whether the input is correct
verifier <- F 
x <- "A"
y <- "B"
while(!verifier){
  if (interactive()) {
    con <- stdin()
  } else {
    con <- "stdin"
  }
  #User input
  cat("Please, introduce the row of your move")
  x <- as.numeric(readLines(con = con, n = 1))
  cat("Please, introduce the col of your move")
  y <- as.numeric(readLines(con = con, n = 1))
  #Different conditions are verified, if all of them are verified,
  #verified turns to T
  
  #This condition ensures that striking the INTRO key twice doesn't 
  #result in an error (since it sends an NA downstream resulting in
  #errors)
  if(all(!is.na(c(x,y)))){
    #This condition ensures that only length 1 values are valid (ensuring
    #both the exclusive validity of integers and preventing other downst-
    #ream problems)
    if (all(nchar(c(x,y) == 1))){
      verifier <- all(c(x,y) >= 1) && #This ensures that only values in the
        all(c(x,y) <=3) && #1-3 range are valid
        all(is.numeric(c(x,y))) && #This ensures that only numbers are valid
        is.na(matriz[x,y]) #This ensures that the selected position is free
    }
  }
  if (verifier){
    #if the conditions are fulfilled the position is filled
    matriz[x,y] <- symbol
    #the matrix is returned for further usage
    return(matriz)
  }else{
    cat("Please, make your move in an empty square. ")
  }
}
}

#This functions codes computer behaviour
computer_turn <- function(matriz,compsymbol) {
  #An empty object which will contain the ranker df is created
  ranker <- c()
  #Both the horizontal and vertical axis are checked and the suitable
  #positions added to the ranker df
  for (i in 1:3){
    ranker <- pr_pos(matriz[i,],axis = "hor",ranker,i)
    ranker <- pr_pos(matriz[,i],axis = "ver",ranker,i)
  }
  #The diag is checked and idem
  ranker <- pr_pos(diag(matriz),axis = "diag",ranker)
  #The rev matrix is created to check the rev diag and idem
  matriz_rev <- matriz[nrow(matriz):1,]
  ranker <- pr_pos(diag(matriz_rev),axis = "diag_rev",ranker)
  colnames(ranker) <- c("Pos","Pr","Sy")
  ranker <- as.data.frame(ranker)
  ranker$Pos <- as.numeric(ranker$Pos)
  ranker$Pr <- as.numeric(ranker$Pr)
  #only the rows corresponding to the nearest to victory position are 
  #kept
  ranker <- subset(ranker,ranker$Pr == min(ranker$Pr))
  #precedence is given to the computer's team position and a random 
  #position from the top positions is chosen
  if (compsymbol %in% ranker$Sy){
    matriz[sampling(ranker$Pos[ranker$Sy == compsymbol],1)] <- compsymbol
  }else{
    matriz[sampling(ranker$Pos,1)] <- compsymbol
  }
  print(matriz)
  return(matriz)
  #If the length of the ranker df is 0 (i.e. there are no routes towards
  #victory, break happens)
  if(is.null(ranker)){
    break
  }
}

#This is the main function

tic_tac_toe <- function() {
  #The matrix is defined
  matriz <- matrix(nrow = 3,ncol = 3)
  #symbol is defined just so it can be used in the next while loop
  symbol <- "Y"
  #this loop checks that the selected symbol is either X or O
  while(!str_detect(symbol,regex("x",ignore_case = T)) &&  !str_detect(symbol,regex("o",ignore_case = T))){
    if (interactive()) {
      con <- stdin()
    } else {
      con <- "stdin"
    }
    cat("X or O?")
    symbol <- readLines(con = con, n = 1)
    if (str_detect(symbol,regex("o",ignore_case = T))){
      assign("compsymbol","X")
    }else{
      assign("compsymbol","O")
    }
  }
  #victory variable is defined so it can be used in the next while loop
  victory <- F
  #main play loop. 
  while(!victory && any(is.na(matriz))){
    #If the user has chosen to begin
    if (str_detect(symbol,regex("x",ignore_case = T))) {
    #User plays first
    matriz <- user_turn(matriz,symbol)
    checkv(matriz)
    #Computer plays second
    if (!victory && any(is.na(matriz))){
    matriz <- computer_turn(matriz,compsymbol)
    checkv(matriz)
    }else{ #if there is victory or stalemate the while loop is broken and the final board is printed
      print(matriz)
      break 
     }
    }else{ #If the user has chosen to be second
      #Computer plays first
      matriz <- computer_turn(matriz,compsymbol)
      checkv(matriz)
      #User plays second
      if (!victory && any(is.na(matriz))){
        matriz <- user_turn(matriz,symbol)
        checkv(matriz)
      }else{ #if there is victory or stalemate the while loop is broken and the final board is printed
        print(matriz)
        break 
      }
    }
  }
  #If the loop is broken (which means victory or stalemate has hapened)
  #a message is chosen in accordance to each of both circumstances
  if (victory){
  cat("End of game.")
  }else{
    cat("Stalemate")
  }
}

tic_tac_toe()

options(warn = oldw)