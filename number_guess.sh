#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USERNAME
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")
 if [[ ! -z $USER_ID ]]
  then
   CNT=$($PSQL "SELECT count(games_played) FROM games as g left join users as u using(user_id) where u.username='$USERNAME'")
   BEST_GAME=$($PSQL "SELECT min(games_played) FROM games as g left join users as u using(user_id) where u.username='$USERNAME'")
   echo -e "\nWelcome back, $USERNAME! You have played $CNT games, and your best game took $BEST_GAME guesses."
  else
   echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
   INSERT_USER=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
 fi

echo -e "\nGuess the secret number between 1 and 1000:"

NUMBER=$(( RANDOM % 1000 + 1 )) 
cnt=0

 while [[ $NUMBER != $GUESS  ]]
  do
    read GUESS 
    ((cnt++))
    if [[  $GUESS =~  ^[0-9]+$ ]]
    then  
      if [[ $GUESS < $NUMBER ]]
      then
        echo -e "\nIt's higher than that, guess again:"
      elif [[ $GUESS > $NUMBER ]]
      then
        echo -e "\nIt's lower than that, guess again:"
      else
        echo "You guessed it in $cnt tries. The secret number was $NUMBER. Nice job!"
      fi
    else
      echo -e "\nThat is not an integer, guess again:"
    fi
  done
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

  INSERT_CNT=$($PSQL "INSERT INTO games(user_id,games_played) VALUES($USER_ID,$cnt)" )



