function getRandomInt(min, max){
  return Math.floor(Math.random() * (max - min)) + min;
}

var num = getRandomInt(1, 10);

var guess = prompt("Guess a number between 1 and 10");

if (guess == num){
  alert("Correct. You win!");
}
else{
  alert("Sorry. You're a loser.");
}
