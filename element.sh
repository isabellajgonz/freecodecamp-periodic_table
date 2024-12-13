PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
 
if [[ -z $1 ]]
then
	echo "Please provide an element as an argument."
#check if number
elif [[ $1 =~ ^[0-9]+$ ]]; then
  element_query=$($PSQL "SELECT * FROM properties JOIN types USING(type_id) JOIN elements USING(atomic_number) WHERE atomic_number = '$1'")
  #if no match
  if [[ -z $element_query ]]; then
    echo "I could not find that element in the database."
  else
	#message
    echo "$element_query" | while IFS='|' read NUMBER ID MASS MPC BPC TYPE SYMBOL NAME
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
    done
  fi
# if name or symbol
elif [[ $1 =~ ^[a-zA-Z]+$ ]]; then
  element_query=$($PSQL "SELECT * FROM properties JOIN types USING(type_id) JOIN elements USING(atomic_number) WHERE name ILIKE '$1' OR symbol = '$1'")
  #if no match
  if [[ -z $element_query ]]; then
    echo "I could not find that element in the database."
  else
		#message
    echo "$element_query" | while IFS='|' read NUMBER ID MASS MPC BPC TYPE SYMBOL NAME
    do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MPC celsius and a boiling point of $BPC celsius."
    done
  fi
else
  echo "I could not find that element in the database."
fi
