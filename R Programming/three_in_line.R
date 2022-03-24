# This is used to hide warnings whose consequences are already
# dealt with in the code (NOT errors)
oldw <- getOption("warn")

library(stringr)

options(warn = -1)

# First we will define a number of functions which shall be used within the
# final tic_tac_toe() function


# This function is  a modded version I made of the sample() function of
# the base package. It avoids certain feature of sample() by virtue of which
# it behaves differently when the length() == 1
sampling <- function(x, size, replace = F, prob = NULL) {
  if (missing(size)) {
    size <- length(x)
  }
  x[sample.int(length(x), size, replace, prob)]
}

# This function returns T if all elements in a vector are equal

allequal <- function(x) {
  length(unique(x)) == 1 && !any(is.na(x)) 
}

# This function checks whether victory has happened. When victory happens,
#T is returned

checkv <- function(matriz) {
  # Checking whether any of the horizontal or vertical vectors has all its
  # elements equal
  matriz_rev <- matriz[ncol(matriz):1, ]
  if (any(apply(matriz, 1, allequal)) || any(apply(matriz, 2, allequal)) ||
    allequal(diag(matriz)) || allequal(diag(matriz_rev))) {
    return(T)
  }else{
    return(F)
  }
}

user_turn <- function(matriz, symbol) {
  # This value will be used to verify whether the input is correct
  verifier <- F
  x <- "A"
  y <- "B"
  while (!verifier) {
    if (interactive()) {
      con <- stdin()
    } else {
      con <- "stdin"
    }
    cat("\nPlease, introduce the row of your move.")
    x <- as.numeric(readLines(con = con, n = 1))
    cat("Please, introduce the col of your move.")
    y <- as.numeric(readLines(con = con, n = 1))

    # This condition ensures that striking the INTRO key twice doesn't
    # result in an error
    if (all(!is.na(c(x, y)))) {
      # This condition ensures both the exclusive validity of integers 
      #and prevents downstream problems
      if (all(nchar(c(x, y) == 1))) {
        verifier <- all(c(x, y) %in% 1:3) && 
          all(is.numeric(c(x, y))) && 
          is.na(matriz[x, y]) 
      }
    }
    if (verifier) {
      matriz[x, y] <- symbol
      return(matriz)
    } else {
      cat("Please, make your move in an empty square.")
    }
  }
}

#EXPLANATION OF HOW THE COMPUTER TURN WORKS.

#EACH OF THE 8 VECTORS (3 HOR + 3 VER + 2DIAG) IS SCANNED FOR OPPORTUNITIES
#THE OPPORTUNITIES OF ALL VECTORS ARE ADDED TO A DATA FRAME AND THE BEST OPPORTUNITY 
#IS SELECTED. THE DATA FRAME HAS 3 COLUMNS: POSITION, DISTANCE TO WIN AND 
#PROSPECTIVE WINNER. THE OPPORTUNITY WITH THE LEAST DISTANCE TO WIN IS 
#SELECTED. AMONG THOSE WITH THE LEAST DISTANCE, THAT WHICH FURTHERS
#OWN VICTORY IS GIVEN PREFERENCE OVER THAT WHICH BLOCKS ENEMY VICTORY

#THE FUNCTION RANKADD JUST TAKES A VECTOR, SCANS IT FOR OPPORTUNITIES
#AND RETURNS A SMALL DATAFRAME WITH THE OPPORTUNITIES, IF ANY, WITHIN
#THAT VECTOR


rankadd <- function(vector,axis,i = 0) {
  #This conditional ensures that there aren't two different symbols
  #in the vector (which renders a victory in that vector impossible)
  if(length(table(vector)) != 2){
    #free positions within the vector are obtained
    positions <- which(is.na(vector))
    #position, distance to winning and prospective winner are obtained
    add <- lapply(1:length(positions),
                  function(y)
                    return(
                      c(switch(axis, #matrix position is obtained according to formulae
                               #for the horizontal vectors, i is the row number and 
                               #y (the position within the vector) is the col number 
                               "hor" = i + 3 * (positions[y] - 1),
                               #for the vertical vectors, y is the row number and 
                               #i (the position within the vector) is the col number
                               "ver" = positions[y] + 3 * (i - 1),
                               #each element in the diag is 4 (nrow + 1) positions further
                               #from the previous one 
                               "diag" = 1 + 4 * (positions[y] - 1),
                               #each element in the rev diag is 2 (nrow - 1) positions further
                               #from the previous one
                               "diag_rev" = 3 + 2 * (positions[y] - 1),
                      ),
                      sum(is.na(vector)), #distance to winning
                      ifelse(all(is.na(vector)), "NA", names(table(vector))[1] #prosp victor
                      ))))
    #the result of lapply is turned into a dataframe and returned
    return(do.call(rbind,add))
  }
}

#THIS FUNCTION WILL ADD UP ALL THE SMALL RANKADD-OBTAINED DATAFRAMES OF THE 8 AXIS
#, SELECT THE BEST ONE AND MAKE THE MOVE IN THAT SELECTED, BEST ONE

computer_turn <- function(matriz, compsymbol) {
  ranker <- c()
  # Both the horizontal and vertical axis are checked and the suitable
  # positions added to the ranker df
  ranker <- rbind(ranker,do.call(rbind,lapply(1:3,function(i) rankadd(matriz[i, ], 
                                                    axis = "hor", ranker, i))))
  ranker <- rbind(ranker,do.call(rbind,lapply(1:3,function(i) rankadd(matriz[,i ], 
                                                    axis = "ver", ranker, i))))
  # The diag is checked and idem
  ranker <- rbind(ranker,rankadd(diag(matriz), axis = "diag", ranker = ranker,i =0))
  # The rev matrix is created to check the rev diag and idem
  matriz_rev <- matriz[nrow(matriz):1, ]
  ranker <- rbind(ranker,rankadd(diag(matriz_rev), axis = "diag_rev",
                                 ranker = ranker, i =0))
  #now we have the complete df with all the opportunities
  if (length(ranker > 0)) {
    colnames(ranker) <- c("Pos", "Pr", "Sy")
    ranker <- as.data.frame(ranker)
    ranker$Pos <- as.numeric(ranker$Pos)
    ranker$Pr <- as.numeric(ranker$Pr)
    #print(ranker)
    # only the rows corresponding to the nearest to victory position are
    # kept
    ranker <- subset(ranker, ranker$Pr == min(ranker$Pr))
    # precedence is given to the computer's team position and a random
    # position from the top positions is chosen
    #print(ranker)
    if (compsymbol %in% ranker$Sy) {
      matriz[sampling(ranker$Pos[ranker$Sy == compsymbol], 1)] <- compsymbol
    } else {
      matriz[sampling(ranker$Pos, 1)] <- compsymbol
    }
  } else { #if the dataframe is EMPTY (which means that victory is no longer
    #possible in any of the 8 axis, a random move is made)
    matriz[sampling(which(is.na(matriz)),1)] <- compsymbol
  }
  print(matriz)
  return(matriz)
}

# This is the main function

tic_tac_toe <- function() {
  # The matrix is defined
  matriz <- matrix(nrow = 3, ncol = 3)
  # symbol is defined just so it can be used in the next while loop
  symbol <- "Y"
  # this loop checks that the selected symbol is either X or O
  while ((!str_detect(symbol, regex("x", ignore_case = T)) && !str_detect(symbol,
                          regex("o", ignore_case = T))) || nchar(symbol) > 1) {
    if (interactive()) {
      con <- stdin()
    } else {
      con <- "stdin"
    }
    cat("X or O?")
    symbol <- toupper(readLines(con = con, n = 1))
    if (str_detect(symbol, regex("o", ignore_case = T))) {
      compsymbol <- "X"
    } else {
      compsymbol <- "O"
    }
  }
  # victory variable is defined so it can be used in the next while loop
  victory <- F
  if (symbol == "X") {
    print(matriz)
  }
  # main play loop.
  while (!victory && any(is.na(matriz))) {
    # If the user has chosen to begin
    if (symbol == "X") {
      # User plays first
      matriz <- user_turn(matriz, symbol)
      victory <- checkv(matriz)
      if (victory) {
        cat("You won\n\n")
      }
      # Computer plays second
      if (!victory && any(is.na(matriz))) {
        matriz <- computer_turn(matriz, compsymbol)
        victory <- checkv(matriz)
        if (victory) {
          cat("You lost\n\n")
        }
      } else { # if there is victory or stalemate the while loop is broken and 
        #the final board is printed
        print(matriz)
        break
      }
    } else { # If the user has chosen to be second
      # Computer plays first
      matriz <- computer_turn(matriz, compsymbol)
      victory <- checkv(matriz)
      if (victory) {
        cat("You lost")
      }
      # User plays second
      if (!victory && any(is.na(matriz))) {
        matriz <- user_turn(matriz, symbol)
        victory <- checkv(matriz)
        if (victory) {
          cat("You won")
        }
      } else { # if there is victory or stalemate the while loop is broken and 
        #the final board is printed
        print(matriz)
        break
      }
    }
  }
  # If the loop is broken (which means victory or stalemate has hapened)
  # a message is chosen in accordance to each of both circumstances
  if (!victory) {
    cat("Stalemate")
  }
}

tic_tac_toe()

options(warn = oldw)
