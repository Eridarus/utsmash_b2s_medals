base_side_length=25;

module ut_logo(height) { color("#ff00ff")
    translate([-34.3,-36.8,0]) linear_extrude(height=height,scale=(1)) import("C:\\Users\\reece\\Downloads\\utsmash_medals\\logo_circle_print.dxf");
}

module trophy_base(height, length){
    linear_extrude(height=3*height) square(size = 0.7*length, center=true);
    linear_extrude(height=2*height) square(size = 0.85*length, center=true);
    linear_extrude(height=height) square(length, center=true);
}

module spiral(){
    linear_extrude(height=20, twist=100) polygon(base_side_length/2);
    
}

/*module spiral(){
    intersection(){
	translate([0,0,75])  //reposition to match spiral
		scale([.5,.5,1.5]){ //scale to match spiral
			difference(){ 
				//creates the hollow bounding shape
				#sphere(d=100);
					sphere(d=80);}}
linear_extrude(150,twist=360,slices=300) //spiral
	square([60,20],center=true);}
cylinder(d1=60,d2=35,h=20); //base
}*/

trophy_base(1, base_side_length);
spiral();