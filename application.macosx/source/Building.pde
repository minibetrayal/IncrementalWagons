class Building {
  double costMultiplier = 1.4;

  String name;
  long craftsPerCycle = 1;
  double millisPerCycle;
  double cycleBegin;
  long cost;

  double proportion;

  int numBuildings;

  boolean invisible = true;
  boolean ghost = true;

  Building(String name, float millisPerCycle, long cost) {
    this.name = name;
    this.millisPerCycle = millisPerCycle;
    this.cost = cost;
  }

  long buy() { // returns the amount spent
    if (invisible) return 0;
    if (numWagons < Math.floor(cost)) return 0;
    numBuildings++;
    if (numBuildings == 1) cycleBegin = millis();
    long temp = cost;
    cost *= costMultiplier;
    return (long) Math.floor(temp);
  }

  void tick() {
    if (numBuildings == 0) return;
    double time = millis();
    proportion = (time - cycleBegin) / (millisPerCycle / (globalSpeedMultiplier * Math.pow(friendMultiplier, numFriends)));
    if (proportion >= 1) {
      numWagons += craftsPerCycle * globalProductivityMultiplier * Math.pow(serverMultiplier, numServers) * Math.floor(proportion) * numBuildings;
      while (proportion >= 1) proportion--;
      cycleBegin = time - proportion * millisPerCycle;
    }
  }

  void show(float x, float y) {
    if (numWagons >= cost / 4) invisible = false;
    if (numWagons >= cost / 2) ghost = false;

    if (invisible) return;
    if (ghost) {
      fill(50);
      rect(x, y, 200, 50);
      return;
    }
    if (numWagons < Math.floor(cost)) fill(50);
    else fill(150);
    rect(x, y, 200, 50);
    tick();
    fill(200);
    rect(x, y, 200 * (float) proportion, 50);
    fill(255, 100);
    textSize(40);
    text(numBuildings, x + 100, y + 20);
    fill(0);
    textSize(12);
    text(name, x + 100, y + 10);
    text("₩" + floor(cost), x + 100, y + 30);
    if (mouseX > x && mouseX < x + 200 && mouseY > y && mouseY < y + 50) display();
  }

  void display() {
    if (numBuildings == 0) {
      if (numWagons < cost) fill(40);
      else fill(150);
    } else {
      fill(200);
    }
    rect(430, 200, 200, 70);
    textSize(15);
    fill(0);
    text(name, 530, 210);
    double perSecond = (numBuildings==0?1:numBuildings) * craftsPerCycle * globalProductivityMultiplier * Math.pow(serverMultiplier, numServers) / (millisPerCycle / (globalSpeedMultiplier * Math.pow(friendMultiplier, numFriends))) * 1000;
    textSize(12);
    text("₩" + truncate(perSecond) + "/s", 530, 225);
    text("Crafts new Cargo wagons automatically", 430, 215, 200, 70);
  }
}

class Player {
  boolean isCrafting = false;
  float craftBegin;
  float millisPerCycle = 2000;
  double craftsPerCycle = 1;

  float proportion;

  void craftWagon() {
    if (isCrafting) return;
    craftBegin = millis();
    isCrafting = true;
  }

  void checkCraft() {
    if (!isCrafting) {
      proportion = 0;
      return;
    }
    proportion = (millis() - craftBegin) / millisPerCycle;
    if (proportion >= 1) {
      isCrafting = false;
    }
  }
}

class BuildingBuilder {
  double costMultiplier = 1.4;

  String name;
  int buildingIndex;
  long craftsPerCycle = 1;
  double millisPerCycle;
  double cycleBegin;
  long cost;

  double proportion;

  int numBuildings;

  boolean invisible = true;
  boolean ghost = true;
  boolean hidden = true;

  BuildingBuilder(String name, int buildingIndex, double millisPerCycle, long cost) {
    this.name = name;
    this.buildingIndex = buildingIndex;
    this.millisPerCycle = millisPerCycle;
    this.cost = cost;
  }

  long buy() { // returns the amount spent
    if (invisible) return 0;
    if (numWagons < Math.floor(cost)) return 0;
    numBuildings++;
    if (numBuildings == 1) cycleBegin = millis();
    double temp = cost;
    cost *= costMultiplier;
    return (long) Math.floor(temp);
  }

  void tick() {
    if (numBuildings == 0) return;
    double time = millis();
    proportion = (time - cycleBegin) / (millisPerCycle / (globalSpeedMultiplier * Math.pow(friendMultiplier, numFriends)));
    if (proportion >= 1) {
      buildings[buildingIndex].numBuildings += craftsPerCycle * globalProductivityMultiplier * Math.pow(serverMultiplier, numServers) * Math.floor(proportion) * numBuildings;
      while (proportion >= 1) proportion--;
      cycleBegin = time - proportion * millisPerCycle;
    }
  }

  void show(float x, float y) {
    if (numWagons >= cost / 4) invisible = false;
    if (!buildersUnlocked) invisible = true;
    if (numWagons >= cost / 2) ghost = false;

    if (invisible) return;
    if (ghost) {
      fill(50);
      rect(x, y, 200, 50);
      return;
    }
    if (numWagons < Math.floor(cost)) fill(50);
    else fill(150);
    rect(x, y, 200, 50);
    tick();
    fill(200);
    rect(x, y, 200 * (float) proportion, 50);
    fill(255, 100);
    textSize(40);
    text(numBuildings, x + 100, y + 20);
    fill(0);
    textSize(12);
    text(name, x + 100, y + 10);
    text("₩" + floor(cost), x + 100, y + 30);
    if (mouseX > x && mouseX < x + 200 && mouseY > y && mouseY < y + 50) display();
  }

  void display() {
    if (numBuildings == 0) {
      if (numWagons < cost) fill(40);
      else fill(150);
    } else {
      fill(200);
    }
    rect(430, 200, 200, 70);
    textSize(12);
    fill(0);
    text(name, 530, 210);
    double perSecond = (numBuildings==0?1:numBuildings) * craftsPerCycle * globalProductivityMultiplier * Math.pow(serverMultiplier, numServers) / ((double) millisPerCycle / (globalSpeedMultiplier * Math.pow(friendMultiplier, numFriends))) * 1000;
    textSize(10);
    text(truncate(perSecond) + "/s", 530, 225);
    text("Crafts new Assembling Machines automatically without spending Wagons", 430, 215, 200, 70);
  }
}
