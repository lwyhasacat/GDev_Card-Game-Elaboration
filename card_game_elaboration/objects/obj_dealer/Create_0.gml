//setting up an enumerator for our card types
global.eat = 0;
global.defend = 1;
global.attack = 2;

//setting up an enumerator for game states
global.phase_dealing = 0; //set up the board
global.phase_computer_chooses = 1; //computer chooses
global.phase_player_chooses = 2; //player chooses
global.phase_result = 3; //add to score

global.current_phase = global.phase_dealing;

//move mouse to card; select card; computer's card
global.selected_card = noone;
global.player_card = noone;
global.computer_card = noone;

//modify size
deck_size = 48;
hand_size = 3;

//score
score_player = 0;
score_computer = 0;

//create deck, player/computer hand, create discard pile, store info in array list
deck = ds_list_create(); //ds_list_create() means to create an arraylist called __*name*__
player_hand = ds_list_create();
computer_hand = ds_list_create();
discard_pile = ds_list_create();


// set positiion
deck_xpos = x; // position for the draw deck
deck_ypos = y;

discard_xpos = room_width - x - 80; // adjust the position of discard pile
discard_ypos = y;
discard_dep = depth;

position_on_board = 10;

// parameters for visual effect
time_delay = 0; // used room_speed later in the code; set time_delay related to room_speed
space_between_cards = 4; // y position difference between cards while in a pile

//setup our deck of cards, of size deck_size
for(i = 0; i < deck_size; i++)
{
	var newcard = instance_create_layer(x, y, "Instances", obj_card); // create a new card as i increases, 0-23 which is 24 total
	
	newcard.has_been_dealt = false; // object.property - means this new card that should be added to the deck has not been dealt
	newcard.is_face_up = false;
	
	if(i % 3 = 0){
		newcard.card_type = global.eat;
	}
	
	else if (i % 3 = 1){
		newcard.card_type = global.defend;	
	}
	
	else if (i % 3 = 2){
		newcard.card_type = global.attack;	
	}
	
	//add the newcard to the deck list
	ds_list_add(deck, newcard);
}

// shuffle the arraylist named deck
// I searched online and found that gamemaker randomizes this deck everytime I restart the game
// not sure if there's another way to randomize the deck
// ds_list_shuffle(deck);

//the placement of each card
for (var i = 0; i < deck_size; i++) {
	deck[|i].x = deck_xpos;
	deck[|i].y = deck_ypos - space_between_cards * i;
	deck[|i].xpos = deck[|i].x;
	deck[|i].ypos = deck[|i].y;
	deck[|i].card_dep = deck_size - i;
}
