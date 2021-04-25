// CREDIT TO RPG MAKER AUDIO FILE - BOOK (called Book1)

// switch(){ case: break; }
// switch (a variable)
// case ___ : check if this variable is the same as ___
// break seems to me stops the code running in this case section...? and check the next state...??
	// or maybe it's just how switch works...???

switch(global.current_phase){
	
	//when cards are being dealt into hands
	case global.phase_dealing:
		
		//two variable that stores the number of cards in player/computer's hand
		var player_card_num = ds_list_size(player_hand);
		var comp_card_num = ds_list_size(computer_hand);
		time_delay --; // set time_delay variable
		
		if(time_delay <= 0){
			if(comp_card_num < hand_size){ // check if computer has enough cards
				audio_play_sound(sd_book,0,false); // lower priority
				var card = deck[|ds_list_size(deck) - 1]; // each object in an arraylist is labelled from 0 to (size-1)
				ds_list_add(computer_hand, card); // add the card to computer hand
				ds_list_delete(deck, ds_list_size(deck) - 1); // delete the card from main pile

				// setting position for cards
				card.xpos = room_width / 3 + comp_card_num * 160 - position_on_board; // adjust position
				card.ypos = room_height * 0.2;
				card.owner = "computer"; // set the card's owner to be computer
				
				time_delay = 0.2 * room_speed; // reset time_delay!!
			}
	
			else if (player_card_num < hand_size){
				audio_play_sound(sd_book,0,false);
				var card = deck[|ds_list_size(deck) - 1];
				ds_list_add(player_hand, card);
				ds_list_delete(deck, ds_list_size(deck) - 1);
			
				// setting position for cards
				card.xpos = room_width / 3 + player_card_num * 160 - position_on_board;
				card.ypos = room_height * 0.8;
				card.owner = "player";
				
				time_delay = 0.2 * room_speed;
			}

			else{
				// turn cards face up
				for(i = 0; i < hand_size; i++){
					player_hand[|i].is_face_up = true;
				}
				//reset time_delay and go to next phase
				time_delay = room_speed;
				global.current_phase = global.phase_computer_chooses;
			}
		}
		
	break;
	
	
	case global.phase_computer_chooses:
	//when the computer is choosing a card
		var comp_card = computer_hand[|irandom(2)];
		comp_card.xpos = room_width / 2 - 50;
		comp_card.ypos = room_height * 0.4;
		
		// set computer's card to be selected card
		global.computer_card = comp_card;
		global.current_phase = global.phase_player_chooses;
		time_delay = 0.2 * room_speed;
	
	break;
	
	
	case global.phase_player_chooses:
	//already set cards visible; selection chosen in card-step
		if (global.selected_card != noone && mouse_check_button_pressed(mb_left) && global.selected_card.owner == "player"){
			// set the card to be used; change position
			global.selected_card.has_been_used = true;
			global.selected_card.xpos = room_width / 2 - 50;
			global.selected_card.ypos = room_height * 0.6;

			// set player's card to be selected card
			global.player_card = global.selected_card;	

			//move to the next phase
			global.current_phase = global.phase_result;
			time_delay = 0.6 * room_speed;
		}
		
	break;
	
	
	case global.phase_result:
		time_delay --;
		
		if (time_delay <= 0) {	
			//check if computer has chosen a card
			if(global.computer_card != noone){
				global.computer_card.is_face_up = true;
				
				//check the winner for each possible card the player chooses
				if(global.player_card.card_type = global.eat){
						if(global.computer_card.card_type == global.eat){
							audio_play_sound(sd_score, 1, false);
							score_computer ++;
							score_player ++;
						}
						else if(global.computer_card.card_type == global.defend){
							audio_play_sound(sd_score, 1, false);
							score_player ++;
						}
						else if(global.computer_card.card_type == global.attack){
							audio_play_sound(sd_scoredown, 1, false);
							score_computer += 2;
						}
				}
				
				if(global.player_card.card_type = global.defend){
						// defend - defend = nothing happens
						if(global.computer_card.card_type == global.attack){
							audio_play_sound(sd_score, 1, false);
							score_player ++;
						}
						else if(global.computer_card.card_type == global.eat){
							audio_play_sound(sd_scoredown, 1, false);
							score_computer ++;
						}
				}
				
				if(global.player_card.card_type = global.attack){
						if(global.computer_card.card_type == global.attack){
							audio_play_sound(sd_scoredown, 1, false);
							score_computer ++;
							score_player ++;
						}
						if(global.computer_card.card_type == global.eat){
							audio_play_sound(sd_score, 1, false);
							score_player += 2;
						}
						else if(global.computer_card.card_type == global.defend){
							audio_play_sound(sd_score, 1, false);
							score_player ++;
						}
				}
				//reset since scores are added
				time_delay = 2 * room_speed;
				global.computer_card = noone;
				break;
			}
				
			var numcards_player = ds_list_size(player_hand);
			var numcards_comp = ds_list_size(computer_hand);
			
			if(numcards_comp > 0){
				// sound effect
				audio_play_sound(sd_book,1,false);
				// discard cards; visual effect
				computer_hand[|numcards_comp-1].xpos = discard_xpos;
				computer_hand[|numcards_comp-1].ypos = discard_ypos - space_between_cards; // set position for each card with space between current card and the prior one
				computer_hand[|numcards_comp-1].card_dep = discard_dep - 1;
				computer_hand[|numcards_comp-1].owner = "NA"; // reset owner
				computer_hand[|numcards_comp-1].has_been_used = false; // reset whether has been used
				computer_hand[|numcards_comp-1].is_face_up = true;
				
				// discard the card; delete from hand
				ds_list_insert(discard_pile, 0, computer_hand[|numcards_comp - 1]);
				var index_for_delete = ds_list_find_index(computer_hand, computer_hand[|numcards_comp - 1]); // store index variable
				ds_list_delete(computer_hand, index_for_delete); // delete the object labelled this index variable

				global.computer_card = noone; // reset the card computer has selected
				
				time_delay = 0.2 * room_speed;
				discard_ypos -= space_between_cards;
				discard_dep --;
			}
			
			else if(numcards_player > 0){
				//sound effect
				audio_play_sound(sd_book,1,false);
				player_hand[|numcards_player - 1].xpos = discard_xpos;
				player_hand[|numcards_player - 1].ypos = discard_ypos - space_between_cards;
				player_hand[|numcards_player - 1].card_dep = discard_dep - 1;
				player_hand[|numcards_player - 1].owner = "NA";
				player_hand[|numcards_player - 1].has_been_used = false;
				player_hand[|numcards_player - 1].is_face_up = true;
				
				ds_list_insert(discard_pile, 0, player_hand[|numcards_player - 1]);
				var index_for_delete_player = ds_list_find_index(player_hand, player_hand[|numcards_player - 1]);
				ds_list_delete(player_hand, index_for_delete_player);	
				
				global.player_card = noone;
				
				time_delay = 0.2 * room_speed;
				discard_ypos -= space_between_cards;
				discard_dep --;
			}
			
			//check if the deck is emptied (is this a word??
			else{
				time_delay = 0.5 * room_speed;
				// if there are cards remaining in the deck
				if(ds_list_size(deck) > 0){
					global.current_phase = global.phase_dealing;
				}
				// if there's no more card in the deck
				else{
					if(score_player > score_computer){
						room_goto(end_screen_win);
					}
					else if(score_player = score_computer){
						room_goto(end_screen_tie);
					}
					else if(score_player < score_computer){
						room_goto(end_screen_lose);
					}
				}

			}
			
		}
	break;
		
}
