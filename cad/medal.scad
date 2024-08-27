scale_factor = (75/50);
image_radius=26;
margin=2;
logo_height=1;
medal_height=2;
tsize=6;
translate_param = 2*0.72*tsize;
text_depth=medal_height*0.25;
ribbon_width=(image_radius+margin)*0.5*2;
ribbon_height=(image_radius+margin)*0.35;

//current_color="medal";
//current_color="logo";
current_color="ALL";

medal_depth=10;
module ut_logo(height) { color("#ff00ff")
    translate([-34.3,-36.8,0]) linear_extrude(height=height+medal_height,scale=(1)) import("logo_circle_print.dxf");
}

module player_text(t) {
    // translate by 0.72 x text size parameter to have multiline text
    color("#00ff00") text(t,size = tsize, halign="center");
}

module medal_base(){
    union(){ 
    multicolor("logo") ut_logo(logo_height);
    multicolor("medal") cylinder(h = medal_height, r=image_radius+margin);
}
}

module text_full() {
    translate([0,0,text_depth]) scale([-1,1,1]) linear_extrude(height=0.125*medal_depth,scale=1, center=true){
   translate([0,translate_param,0])player_text("UofT BTSB");
    player_text("Singles");
translate([0,-translate_param,0]) player_text("2nd Place");
    translate([0,-2*translate_param,0]) player_text("31/08/2024");
}
}

module handle(){
difference(){
translate([0,image_radius+margin,0])linear_extrude(height=medal_height, scale=1) square([ribbon_width,ribbon_height],center=true);
    translate([0,image_radius+margin,-1])linear_extrude(height=medal_height*200, scale=1) square([ribbon_width*0.8,ribbon_height*0.5],center=true);
}}

module multicolor(color) {
    if (current_color != "ALL" && current_color != color) { 
        // ignore our children.
        // (I originally used "scale([0,0,0])" which also works but isn't needed.) 
    } else {
        color(color)
        children();
    }        
}
scale([scale_factor, scale_factor, 1]){
union(){
difference() {
    medal_base();
    multicolor("medal") text_full();
}
multicolor("medal") handle();
}
}