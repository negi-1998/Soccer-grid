bool player1Answered = false;
bool player2Answered = false;
//these two variables turn to true when the player does not skip the question and answer it, whether correctly or incorrectly

int playerturn=0; 
// this variable is incremented and divided by 2 at each step which gives 0 and 1 which in turn tells whether it is player 1 or player 2 turn respectively. 

bool clicked = false;
// this variable is set to true when the grid is clicked for the forst time and remains true through then. Used to break the condition for the first click