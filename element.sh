#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

GET_ELEMENT_INFO() {

  NAME_ELEMENT=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
    SYMBOL_ELEMENT=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
    TYPE_ELEMENT=$($PSQL "select type_name FROM properties WHERE atomic_number=$1")
    MASS_ELEMENT=$($PSQL "select atomic_mass FROM properties WHERE atomic_number=$1")
    MELTING_ELEMENT=$($PSQL "select melting_point_celsius FROM properties WHERE atomic_number=$1")
    BOILING_ELEMENT=$($PSQL "select boiling_point_celsius FROM properties WHERE atomic_number=$1")
    
    echo "The element with atomic number $1 is $(echo $NAME_ELEMENT |  sed -r 's/^ *| *$//g') ($(echo $SYMBOL_ELEMENT |  sed -r 's/^ *| *$//g')). It's a $(echo $TYPE_ELEMENT |  sed -r 's/^ *| *$//g'), with a mass of $(echo $MASS_ELEMENT |  sed -r 's/^ *| *$//g') amu. $(echo $NAME_ELEMENT |  sed -r 's/^ *| *$//g') has a melting point of $(echo $MELTING_ELEMENT |  sed -r 's/^ *| *$//g') celsius and a boiling point of $(echo $BOILING_ELEMENT |  sed -r 's/^ *| *$//g') celsius."

}  


GET_ATOMIC_NUMBER_WITH_SYBMOL() {
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
  echo $ATOMIC_NUMBER
}
GET_ATOMIC_NUMBER_WITH_NAME() {
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
  echo $ATOMIC_NUMBER
}


if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~  ^[0-9]+$ ]]
  then
    GET_ELEMENT_INFO  $1
  else 
    if [[ $1 =~ ^[A-Z]{1}+[a-z]{1}$|^[A-Z]{1}$ ]]
    then
    ATOMIC_NUMBER=$(GET_ATOMIC_NUMBER_WITH_SYBMOL $1)
    GET_ELEMENT_INFO $ATOMIC_NUMBER
    else 
    ATOMIC_NUMBER=$(GET_ATOMIC_NUMBER_WITH_NAME $1)
    if [[ ! -z $ATOMIC_NUMBER ]]
    then
    GET_ELEMENT_INFO $ATOMIC_NUMBER
    else
    echo "I could not find that element in the database."
    fi
    fi
  fi 
fi
