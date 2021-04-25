// display score
draw_set_font(fontcat);
ccat = make_colour_rgb(80, 85, 105);
draw_set_colour(ccat);
draw_text(90, room_height * 1/5, score_computer);
draw_text(90, room_height * 4/5, score_player);
