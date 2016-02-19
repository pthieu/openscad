$fn = 6;

// garbage: 180x180x

l = 60;
d = 60;
h = 40;

w_wall = 2;
l_wall = l-w_wall;
d_wall = d-w_wall;
h_wall = h-w_wall;

w_pillar = 5;
l_pillar = l-w_pillar;
d_pillar = d-w_pillar;
h_pillar = h-w_pillar;

difference(){
  cube([l,d,h],center=true);
  cube([l_wall,d_wall,h_wall],center=true);
  cube([l_pillar*2,d_pillar,h_pillar],center=true);
  cube([l_pillar,d_pillar*2,h_pillar],center=true);
  cube([l_pillar,d_pillar,h_pillar*2],center=true);
}