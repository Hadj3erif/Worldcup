GUESS_NUMBER() {
  
  #echo $NUMBER
  cnt=0
  while [[ $NUMBER != $GUESS  ]]
  do
  read GUESS 
    if [[  $GUESS =~  ^[0-9]+$ ]]
    then  
      if [[ $GUESS < $NUMBER ]]
      then
        echo -e "\nIt's higher than that, guess again:"
        ((cnt++))
      else
        echo -e "\nIt's lower than that, guess again:"
        ((cnt++))
      fi
    else
      echo -e "\nThat is not an integer, guess again:"
    fi
  done
  echo "You guessed it in $cnt tries. The secret number was $NUMBER. Nice job!"
  return $cnt
}


INSERT_DATA() {
  INSERT_CNT=$($PSQL "INSERT INTO games(user_id,games_played) VALUES($USER_ID,$cnt)" )
  }

USER_CONTROL() {
  #echo USER_ID
  if [[ -z $USER_ID ]]
  then
    echo -e "\nWelcome, $1! It looks like this is your first time here."
    INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
    USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
    echo -e "\nGuess the secret number between 1 and 1000:"
    read GUESS
    GUESS_NUMBER $GUESS 
  else 
    CNT=$($PSQL "SELECT count(games_played) FROM games as g left join users as u using(user_id) where u.user_id='$USER_ID'")
    #echo $USER_ID
    BEST_GAME=$($PSQL "SELECT min(games_played) FROM games as g left join users as u using(user_id) where u.user_id='$USER_ID'")
    echo -e "\nWelcome back, $USERNAME! You have played $CNT games, and your best game took $BEST_GAME guesses."
    echo -e "\nGuess the secret number between 1 and 1000:"
    read GUESS
    GUESS_NUMBER $GUESS 
  fi
  return $cnt
}



USER_CONTROL $USERNAME
INSERT_DATA $USER_ID $cnt
