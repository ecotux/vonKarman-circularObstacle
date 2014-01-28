
scale = 0.001;

lc1 = 20 ; // mesh ai bordi del windtunnel
lc2 = 5 ; // mesh ai bordi del volume interno
lc = 2 ; // mesh ai punti dell'ostacolo

diam = 100 ; // diametro del tubolare


// Ostacolo interno

rad = diam/2;

Point (1) = {0 * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (2) = {-rad * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (3) = {rad * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (4) = {0 * scale, -rad * scale, 0 * scale, lc * scale} ;
Point (5) = {0 * scale, rad * scale, 0 * scale, lc * scale} ;

Circle (1) = {3, 1, 5} ;
Circle (2) = {5, 1, 2} ;
Circle (3) = {2, 1, 4} ;
Circle (4) = {4, 1, 3} ;

Line Loop(1) = {4, 1, 2, 3};


// Wind Tunnel

p10 = newp;

H2 = 12 * diam /2;
W1 = 10 * diam /2;
W2 = 60 * diam /2;

Point(p10+1) = {-W1 * scale,  H2 * scale, 0 * scale, lc1 * scale};
Point(p10+2) = { W2 * scale,  H2 * scale, 0 * scale, lc1 * scale};
Point(p10+3) = { W2 * scale, -H2 * scale, 0 * scale, lc1 * scale};
Point(p10+4) = {-W1 * scale, -H2 * scale, 0 * scale, lc1 * scale};

Line(1200) = {p10+1, p10+2};
Line(1201) = {p10+2, p10+3};
Line(1202) = {p10+3, p10+4};
Line(1203) = {p10+4, p10+1};

Line Loop(2) = {1201, 1202, 1203, 1200};


// Definisco una curva per avere una mesh piu' strutturata

radint = 4*diam/2;

p11 = newp;

Point (p11+1) = {radint * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (p11+2) = {-radint * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (p11+3) = {3.5*radint * scale, 0 * scale, 0 * scale, lc * scale} ;
Point (p11+4) = {radint * scale, -1.5*radint * scale, 0 * scale, lc * scale} ;
Point (p11+5) = {radint * scale, 1.5*radint * scale, 0 * scale, lc * scale} ;

Ellipse (201) = {p11+3, p11+1, p11+2, p11+5} ;
Ellipse (202) = {p11+5, p11+1, p11+2, p11+2} ;
Ellipse (203) = {p11+2, p11+1, p11+2, p11+4} ;
Ellipse (204) = {p11+4, p11+1, p11+2, p11+3} ;

Line Loop(3) = {204, 201, 202, 203};

// Definisco lo spazio interno

Plane Surface(1204) = {2, 3};
Plane Surface(1205) = {1, 3};

Extrude {0, 0, 1000*scale } {
  Surface{1204};
  Layers{1};
  Recombine;
}
Extrude {0, 0, 1000*scale } {
  Surface{1205};
  Layers{1};
  Recombine;
}

Physical Volume("internal") = {1, 2};

Physical Surface("obstacle") = {1272, 1260, 1264, 1268};
Physical Surface("inlet") = {1226};
Physical Surface("outlet") = {1218};
Physical Surface("upperWall") = {1230};
Physical Surface("lowerWall") = {1222};

