int defaultYear = 2018;
int defaultMonth = 7;
int rectRX, rectRY;
int rectLX, rectLY;
int rectSize = 20;
boolean leftButtonOver = false;
boolean rightButtonOver = false;
color currentColor = 200;
String data[];
int sub;
void setup() {
  size(800, 700);
  background(currentColor);
  rectLX = width/2-50;
  rectLY = 50;
  rectRX = width/2+50;
  rectRY = 50;
  data = loadStrings("subject.txt");
}

void draw() {
  //データの読み込み//int i;
  //for(i=0;i<data.length;i++){
  //print(data[i]);
 //}
  update();
  drawCalendar(defaultYear, defaultMonth);
textSize(20);
text(year()+","+month()+","+day(),20,20);
textSize(10);
  if (rightButtonOver) {
    fill(255);
  } else {
    fill(0);
  }
  rect(rectRX, rectRY, rectSize, rectSize);
  
  
  
  if (leftButtonOver) {
    fill(255);
  } else {
    fill(0);
  }
  rect(rectLX, rectLY, rectSize, rectSize);
}

void update() {
  if (overLeftButton(rectLX, rectLY, rectSize, rectSize)) {
    leftButtonOver = true;
    rightButtonOver = false;
  } else if (overRightButton(rectRX, rectRY, rectSize, rectSize)) {
    leftButtonOver = false;
    rightButtonOver = true;
  } else {
    leftButtonOver = false;
    rightButtonOver = false;
  }
}

void mousePressed() {
// subject// int days = daysOfMonth(year, month);
  //for (int day = 1; day <= days; day++)
  //int x = dayOfWeek(year, month, day);
  // int y = weekOfMonth(year, month, day);
  //if((mouseX<=x*100+40&&mouseY<=y*100-20){
  //text(data[i],x*100+50,y*100-10);
  
  if (leftButtonOver) {
    background(currentColor);

    if (defaultMonth == 1) {
      defaultMonth = 12;
      defaultYear -= 1;
    } else {
      defaultMonth -= 1;
    }
  }
  if (rightButtonOver) {
    background(currentColor);

    if (defaultMonth == 12) {
      defaultMonth = 1;
      defaultYear += 1;
    } else {
      defaultMonth += 1;
    }
  }
}

boolean overRightButton(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overLeftButton(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void drawCalendar(int year, int month) {
  fill(0);
  text(year, width/2-20, 30);
  text(month, width/2+20, 30);

  int days = daysOfMonth(year, month);

  // draw days of the Month
  for (int day = 1; day <= days; day++) {
    fill(50);

    int x = dayOfWeek(year, month, day);
    int y = weekOfMonth(year, month, day);

    fill(0);
    noFill();
    rect(x*100+40, y*100-20, 100, 100);

    color z = setColor(x);
    fill(z);
    text(day, x*100+50, y*100);
  }
}

color setColor(int day) {
  if (day == 0) {
    return #FF0000;
  } else if (day == 6) {
    return #0008FF;
  } else {
    return #000000;
  }
}

int weekOfMonth(int year, int month, int date) {
  return (date - dayOfWeek(year, month, date) + 12) / 7;
}

int daysSum(int year, int month, int date) {
  // 2000,1,1
  int daysSum = 1;
  for (int y = year-1; y >= 2000; y--) {
    if (isLeapYear(y)) {
      daysSum += 366;
    } else {
      daysSum += 365;
    }
  }

  for (int m = month-1; m >= 1; m--) {
    daysSum += daysOfMonth(year, m);
  }

  daysSum += date;
  return daysSum;
}

int dayOfWeek(int year, int month, int date) {
  int daysSum = daysSum(year, month, date);
  // 0 - Sun / 6 - Sat
  return daysSum % 7;
}

boolean isLeapYear(int year) {
  if (year % 4 == 0 && year % 100 != 0) {
    return true;
  } else {
    return false;
  }
}

// 4,6,9,11 has 30 days.
int daysOfMonth(int year, int month) {
  if (month == 4 || month == 6 || month == 9 || month == 11) {
    return 30;
  } else if (month == 2) {
    if (isLeapYear(year)) {
      return 29;
    } else {
      return 28;
    }
  } else {
    return 31;
  }
}
