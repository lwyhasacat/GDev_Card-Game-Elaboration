// set movement of the card; visual effect
if (x != xpos) {
	x = lerp(x, xpos, move_speed);	
}

if (y != ypos) {
	y = lerp(y, ypos, move_speed);
	
	if(global.selected_card == id && owner == "player" && !has_been_used && global.current_phase == global.phase_player_chooses){
		y = lerp(y, ypos - 30, move_speed);
	}
}

// set depth of each card; visual effect
if (card_dep != depth){
	depth = card_dep;	
}

// make sure the card pops up when my mouse is placed on it
if (position_meeting(mouse_x, mouse_y, id)){
	global.selected_card = id;
}
else if (global.selected_card == id){ 
	global.selected_card = noone;
}

// set sprite_index to the cards according to their card_type
// I tried to write this part of the code using switch/case/break, but it didn't work...
// maybe I'll try again later
if (is_face_up){
	
	if(card_type = spr_index_eat){
		sprite_index = spr_eat;
	}
	else if(card_type = spr_index_defend){
		sprite_index = spr_defend;
	}
	else if(card_type = spr_index_attack){
		sprite_index = spr_attack;
	}
}

else{
	sprite_index = spr_back;
}
