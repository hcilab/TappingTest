//
// Tapping Test
// 
// How many times can you click the mouse in a 10 second interval?
//


int testDuration = 10000;

boolean isFirstClick = true;
int lastClickTime = 0;
int testStartTime = 0;
int testEndTime = 0;

Table clicks;
String filename;


void setup() {
	size(800, 600);

	stroke(0);
	fill(0);
	rectMode(CORNER);

	clicks = new Table();
  clicks.addColumn("sincestart");
	clicks.addColumn("sinceprev");

	filename = "clicks-" + System.currentTimeMillis() + ".csv";
}

void draw() {
	background(255);

	if (isFirstClick) {
		drawWelcomeMessage();
	} else if (withinTestDuration()) {
		drawCountdownBar();
	} else {
		drawCompletionMessage();
	}
}

void drawWelcomeMessage() {
	text("Click as fast as you can!", 0.5*width, 0.5*height);
}

void drawCountdownBar() {
	float percentRemaining = float(testEndTime-millis()) / float(testDuration);
	rect(0, 0, percentRemaining*width, 0.05*height);
}

void drawCompletionMessage() {
	text("Complete :)", 0.5*width, 0.5*height);
}


void mouseClicked() {
	if (isFirstClick) {
		testStartTime = millis();
		testEndTime = testStartTime + testDuration;
		lastClickTime = testStartTime;
		isFirstClick = false;
	} else if (withinTestDuration()) {
		int clickTime = millis();
		TableRow r = clicks.addRow();
    r.setInt("sincestart", clickTime - testStartTime);
		r.setInt("sinceprev", clickTime - lastClickTime);
		saveTable(clicks, filename);
		lastClickTime = clickTime;
	}
}


private boolean withinTestDuration() {
	return !isFirstClick && millis() < testEndTime;
}