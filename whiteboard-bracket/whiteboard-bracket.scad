//General
$fn=6;
tolerance = 0.2;

// Door
l_door = 30;
w_door = 35+tolerance;
h_door = 210;

// Bracket
wall_bracket =  3;
l_bracket = l_door;
h_bracket = h_door;
w_bracket = w_door+wall_bracket*2;

// Hook for door
h_backhook = 40;

// Hook for whiteboard
wall_hook = 1;
l_hook = l_bracket;
h_hook = 18;
space_hook = 2; // width of whiteboard's plastic w_doore're hooking into
n_hook_support = 4;

wall_modifier = wall_bracket*2;
l_modifier = l_bracket;

rotate([45,-90,0]){
  // body();
  // mirror([0,1,0])
  // wbHook();
  color("red")
  cornerModifiers();
}

module body(){
  difference(){
    // bracket
    cube([l_bracket, w_bracket, h_bracket]);
    // door (inside space)
    translate([0,wall_bracket,-wall_bracket])
    cube([l_door, w_door, h_door]);
    // hook
    translate([0,wall_bracket*2,-h_backhook])
    cube([l_door, w_door, h_door]);
  }
}

module wbHook(){
  translate([0, space_hook, 0])
  cube([l_hook, wall_hook, h_hook]);
  translate([0,-wall_bracket,(1-n_hook_support)*wall_bracket])
  cube([l_hook,space_hook+wall_bracket+wall_hook, wall_bracket*3]);
}

module cornerModifiers(){
  // WB hook
  translate([0,-wall_bracket*2,-wall_bracket*2])
  cube([l_modifier,  wall_modifier*2, wall_modifier*2]);
  // Door hook corners
  translate([0,-wall_bracket*0.5,h_bracket-wall_bracket*1.5])
  cube([l_modifier,  wall_modifier, wall_modifier]);
  translate([0,w_door+wall_bracket*0.5,h_bracket-wall_bracket*1.5])
  cube([l_modifier,  wall_modifier, wall_modifier]);
}