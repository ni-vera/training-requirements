#This is used to hide warnings whose consequences are already
#dealt with in the code (NOT errors)
oldw <- getOption("warn")

options(warn = -1)

#First we will define three functions which shall be used within the
#final tic_tac_toe() function

#This function returns T if all elements in a vector are equal

allequal <- function(x){
  if (length(unique(x)) == 1 && is.na(x) == c(F,F,F)){
    return(T)
  }else{
    return(F)
  }
}

#This function checks whether victory has happened. When victory happens,
#victory is set to T.

checkv <- function(a,b){
  #Checking whether any of the horizontal or vertical vectors has all its
  #elements equal
  if (TRUE %in% apply(b,1,allequal) || TRUE %in% apply(b,2,allequal)){
    assign("victory","T",pos = parent.frame())
  }
  #Checking whether any of the two diagonals has all its elements equal
  if (allequal(diag(b)) == T || allequal(diag(a)) == T){
    assign("victory","T",pos = parent.frame())
  }
}

#This function checks whether a vector is in an "about to win" situation,
#i.e. with one NA and the other two elements being equal
sums <- function(x,symb){
  sum <- sum(x == symb,na.rm = T)
  if (sum == 2 && any(is.na(x)) == T){
    return(T)
  }else{
    return(F)
  }
}

tic_tac_toe <- function() {
  #Two matrices are defined. The reason for there being two is that input is 
  #made through the numpad, and due to how input is converted to a position 
  #in the matrix using remainders, there is a need to permutate the first and
  #third row. We will use matrix 1 all the time in code but it is matrix 2 
  #(the permutated one) which will be shown to the player
  matrix1 <- matrix(nrow = 3,ncol = 3)
  matrix2 <- matrix(nrow = 3,ncol = 3)
  #symbol is defined just so it can be used in the next while loop
  symbol <- "Y"
  #this loop checks that the selected symbol is either X or O
  while(symbol != "X" && symbol != "O"){
    if (interactive()) {
      con <- stdin()
    } else {
      con <- "stdin"
    }
    cat("X or O?")
    symbol <- readLines(con = con, n = 1)
    if (symbol == "O"){
      assign("compsymbol","X")
    }else{
      assign("compsymbol","O")
    }
  }
  #victory variable is defined so it can be used in the next while loop
  victory <- F
  
  #main play loop. 
  while(victory == F){
    #User turn
    #move and verifier is defined so it can be used in the next while loop.
    move <- "s" #this variable will later register player input
    verifier <- F #this variable will later verify that the selected position is unused (NA)
    #a while loop is used to check that the input is valid (a single numpad stroke representing an empty position)
    while(is.numeric(move) == F || nchar(move) > 1 || is.na(move) == T || verifier == F ){
      if (interactive()) {
        con <- stdin()
      } else {
        con <- "stdin"
      }
      cat("Please, make your move with the numerical keyboard.")
      move <- as.numeric(readLines(con = con, n = 1))
      if (is.numeric(move) == T && nchar(move) == 1 && is.na(move) == F){
        #modular arithmetic is used to convert numpad input to matrix position
        if (move %% 3 == 0){
          x <- move/3
          y <- 3
        }else{
          x <- move/3 + 1
          y <- move %% 3 
        }
        #this variable verifies that the chosen position is empty
        verifier <- is.na(matrix1[x,y])
        if (verifier){
          #if it is empty the input is registered
          matrix1[x,y] <- symbol
          #the permutated matrix is produced
          matrix2 <- matrix1[nrow(matrix1):1,]
        }else{
          cat("Please, make your move in an empty square. ")
        }
        #it is checked whether victory has happened. this intermediate check-
        #point is necessary to prevent the computer from playing after the player
        #has won
        checkv(matrix1,matrix2)
      }
    }
    
    #Computer turn
    
    #This conditional ensures that the computer doesn't play after we won
    #or after all positions have been filled without a victor (stalemate)
    if (victory == F && any(is.na(matrix1))){
      #In the first place the computer will check whether a winning move
      #is possible
      
      #horizontal vectors are scanned
      if (T %in% apply(matrix1,1,sums,symb = compsymbol)){
        cat("Victoria ordenador filas")
        if (length(which(apply(matrix1,1,sums,symb = compsymbol) == T)) >1){
          row <- sample(which(apply(matrix1,1,sums,symb = compsymbol) == T),1)
        }else{
          row <- row <- which(apply(matrix1,1,sums,symb = compsymbol) == T)
        }
        matrix1[row,which(is.na(matrix1[row,]))] <- compsymbol
      }else{
        #vertical vectors are scanned
        if (T %in% apply(matrix1,2,sums,symb = compsymbol)){
          if (length(which(apply(matrix1,2,sums,symb = compsymbol) == T))>1){
            column <- sample(which(apply(matrix1,2,sums,symb = compsymbol) == T),1)
          }else{
            column <- which(apply(matrix1,2,sums,symb = compsymbol) == T)
          }
          matrix1[which(is.na(matrix1[,column])),column] <- compsymbol
        }else{
          #diagonals are scanned
          if (T %in% sums(diag(matrix1),symb = compsymbol)){
            line <- (which(is.na(diag(matrix1))))
            diag(matrix1)[line] <- compsymbol
          }else{
            if (T %in% sums(diag(matrix2),symb = compsymbol)){
              line <- which(is.na(diag(matrix2)))
              diag(matrix2)[line] <- compsymbol
              matrix1 <- matrix2[nrow(matrix1):1,]
            }else{
              #now the computer checks whether the player is about to win
              #and blocks it
              
              #horizontal vectors are scanned
              if (T %in% apply(matrix1,1,sums,symb = symbol)){
                if (length(which(apply(matrix1,1,sums,symb = symbol) == T)) > 1){
                  row <- sample(which(apply(matrix1,1,sums,symb = symbol) == T),1)
                }else{
                  row <- which(apply(matrix1,1,sums,symb = symbol) == T)
                }
                cat(row)
                cat(which(is.na(matrix1[row,])))
                matrix1[row,which(is.na(matrix1[row,]))] <- compsymbol
              }else{
                #vertical vectors are scanned
                if (T %in% apply(matrix1,2,sums,symb = symbol)){
                  if (length(which(apply(matrix1,2,sums,symb = symbol) == T)) > 1){
                    column <- sample(which(apply(matrix1,2,sums,symb = symbol) == T),1)
                  }else{
                    column <- which(apply(matrix1,2,sums,symb = symbol) == T)
                  }
                  cat(column)
                  matrix1[which(is.na(matrix1[,column])),column] <- compsymbol
                }else{
                  #diagonals are scanned
                  if (T %in% sums(diag(matrix1),symb = symbol)){
                    line <- (which(is.na(diag(matrix1))))
                    diag(matrix1)[line] <- compsymbol
                  }else{
                    if (T %in% sums(diag(matrix2),symb = symbol)){
                      line <- which(is.na(diag(matrix2)))
                      diag(matrix2)[line] <- compsymbol
                      matrix1 <- matrix2[nrow(matrix1):1,]
                    }else{
                      freespots <- which(is.na(matrix1))
                      matrix1[sample(freespots,1)] <- compsymbol
                    }
                  }
                }
              }
            }
          }
        }
      }
      #the permutated matrix for player view is generated and printed
      matrix2 <- matrix1[nrow(matrix1):1,]
      print(matrix2)
      #victory is checked for 
      checkv(matrix1,matrix2)
      if (victory){
        cat("The computer is victorious. ")
      }
    }else{ #if there is victory or stalemate the while loop is broken and the final board is printed
      print(matrix2)
      if (victory == F){
        cat("Stalemate")
      }
      break 
    }
  }
  cat("End of game.")
}

tic_tac_toe()

options(warn = oldw)