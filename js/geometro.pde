int numShapes;
int padding = 40;

int minX;
int maxX;
int minY;
int maxY;

int minW;
int maxW;
int minH;
int maxH;

int minA;
int maxA;

var drawBlackLines;
var strokes = false;
Shape button;

void setup() {

	size(700, 700);
	noStroke();
	rectMode(CENTER);
	frameRate(10);
	
	minX = padding;
	minY = padding;
	maxX = width-padding;
	maxY = height-padding;

	drawBlackLines = false;

	getUIVars();
	populateShapes();
	drawShapes();

}

void draw() {
	if (mousePressed) {

	}
	getUIVars();
}

void mouseClicked() {

}

private void getUIVars () {
	
	numShapes = uivars.numShapes;
	minW = uivars.minW;
	minH = uivars.minH;
	maxW = uivars.maxW;
	maxH = uivars.maxH;		
	minA = uivars.minA;
	maxA = uivars.maxA;

}

void eraseShapes () {

	//clear background
	background(0,0);
	
}

void clearShapes () {

	//empty Shapes array
	shapes = [];
}

void populateShapes() {

	//initialize array of Shapes
	shapes = new Shape[numShapes];
	
	//populate shapes
	for (int i = 0; i<shapes.length; i++) {
	
		//produce random shapes
		Shape candidate = new Shape((int)random(minX,maxX),(int)random(minY,maxY),(int)random(minW,maxW),(int)random(minH,maxH));
		
		/*
		if ((int)random(2)==1) { 		
			Shape candidate = new Shape((int)random(minX,maxX),(int)random(minY,maxY), 50, 100);
		}
		else {
			Shape candidate = new Shape((int)random(minX,maxX),(int)random(minY,maxY), 100, 50);
		}
		*/

		/*
		//re-produce if too square
		while (abs(candidate.w-candidate.h) < 40) {
			candidate = new Shape((int)random(minX,maxX),(int)random(minY,maxY),(int)random(minW,maxW),(int)random(minH,maxH));
		}
		*/


		//random Color and opacity
		int r = (int)random (256);
		int g = (int)random (256);
		int b = (int)random (256);
		int a = (int)random (minA,maxA);
		
		//pick one channel and accentuate it
		int pickOne = (int)random (3);
		switch (pickOne) {
			case 0: r = (r + 255)/2;
			break;
			case 1: g = (g + 255)/2;
			break;
			case 2: b = (b + 255)/2;
			break;
			default:
		}

		//chance of black
		if (drawBlackLines) {
			if ((int)random(40)==1) {
				if ((int)random(2)==0) {
					candidate.w = random(minW,maxW);
					candidate.h = 1;
				}
				else {
					candidate.h = random(minH,maxW);
					candidate.w = 1;
				}
				r = 0;
				g = 0;
				b = 0;
				a = random(200,256);
			}
		}
		
		candidate.r=r;
		candidate.g=g;
		candidate.b=b;
		candidate.a=a;
		
		
		//check for canvas bounds		
		if (candidate.x - (candidate.w)/2 < minX) {
			candidate.x = candidate.x + (candidate.w)/2 + padding;
		}
		if (candidate.x + (candidate.w)/2 > maxX) {
			candidate.x = candidate.x - (candidate.w)/2 - padding;
		}
		if (candidate.y - (candidate.h)/2 < minY) {
			candidate.y = candidate.y + (candidate.h)/2 + padding;
		}
		if (candidate.y + (candidate.h)/2 > maxY) {
			candidate.y = candidate.y - (candidate.h)/2 - padding;
		}
	
		//push candidate shape into Shapes
		shapes[i] = candidate;
		
	}
	
}

void drawShapes() {

	//erase previous Shapes
	eraseShapes();
	
	rectMode(CENTER);

	//check if strokes are enabled
	if (strokes) { stroke(1); }
	else { noStroke(); }

	//draw 
	for (int i = 0; i<shapes.length; i++) {	
		
		//get Shape from array
		Shape temp = shapes[i];
		
		
		/*chance of black
		if ((int)random(5)==1 && (temp.w < 10 || temp.h < 10)) {
			r = 0;
			g = 0;
			b = 0;
		}*/
		
	
		/*chance of white
		if ((int)random(40)==1) {
			r = 255;
			g = 255;
			b = 255;
	
		}*/

		//fill the rectangle
		if (temp.invisible) {
			fill(temp.r, temp.g, temp.b, 0);
		}
		else {
			fill(temp.r, temp.g, temp.b, temp.a);
		}
		//rotate(temp.angle);
		rect (temp.x, temp.y, temp.w, temp.h);
		
	}

	

}

function isCollide(Shape a, Shape b) {
    return !(
        (a.y - (a.h)/2 < b.y+(b.h)/2) ||
        (a.y + (a.h)/2 > b.y-(b.h)/2) ||
        (a.x + (a.w)/2 > b.x-(b.w)/2) ||
        (a.x - (a.w)/2 < b.x+(b.w)/2)
    );
}

class Shape {

	//position
	int x;
	int y;
	
	//dimensions
	int w;
	int h;
	
	//color + opacity
	int r;
	int g;
	int b;
	int a;

	int type;
	
	Shape (mx, my, mw, mh) {
		x=mx;
		y=my;
		w=mw;
		h=mh;
		r=0;
		g=0;
		b=0;
		a=255;
		type=0;
	}	

	Shape (mx, my, mw, mh, mtype) {
		x=mx;
		y=my;
		w=mw;
		h=mh;
		a=255;
		type=mtype;
	}
	
}

