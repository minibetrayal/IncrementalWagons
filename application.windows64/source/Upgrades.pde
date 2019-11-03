class Upgrade {

  String name;
  String description;
  int buildingIDX;
  float speedBoost;
  float craftBoost;
  boolean obtained;
  long cost;

  int prereq;

  color c;
  boolean visible;

  boolean infinite;

  float costMultiplier = 1.4;

  Upgrade(String name, String description, long cost, int buildingIDX, float speedBoost, float craftBoost, int r, int g, int b, int prereq) {
    this(name, description, cost, buildingIDX, speedBoost, craftBoost, r, g, b);
    this.prereq = prereq;
  }

  Upgrade(String name, String description, long cost, int buildingIDX, float speedBoost, float craftBoost, int r, int g, int b, int prereq, boolean infinite) {
    this(name, description, cost, buildingIDX, speedBoost, craftBoost, r, g, b, prereq);
    this.infinite = infinite;
  }

  Upgrade(String name, String description, long cost, int buildingIDX, float speedBoost, float craftBoost, 
    int r, int g, int b) {
    this.name = name;
    this.description = description;
    this.buildingIDX = buildingIDX;
    this.speedBoost = speedBoost;
    this.craftBoost = craftBoost;
    this.cost = cost;
    c = color(r, g, b);
    this.prereq = -1;
  }

  void apply() {
    if (!obtained && numWagons >= cost) {
      if (buildingIDX == -5) { // applies to all buildings
        globalSpeedMultiplier *= speedBoost;
        globalProductivityMultiplier *= craftBoost;
      } else if (buildingIDX == -4) {// unlock clusterio servers
        clusterioUnlocked = true;
        serverMultiplier *= craftBoost;
      } else if (buildingIDX == -3) {// unlock multiplayer
        multiplayerUnlocked = true;
        friendMultiplier *= speedBoost;
      } else if (buildingIDX == -2) {// unlock building builders
        buildersUnlocked = true;
      } else if (buildingIDX == -1) {
        player.millisPerCycle /= speedBoost;
        player.craftsPerCycle *= craftBoost;
      } else if (buildingIDX < buildings.length) {
        buildings[buildingIDX].millisPerCycle /= speedBoost;
        buildings[buildingIDX].craftsPerCycle *= craftBoost;
      } else {
        int temp = buildingIDX - buildings.length;
        buildingBuilders[temp].millisPerCycle /= speedBoost;
        buildingBuilders[temp].craftsPerCycle *= craftBoost;
      }
      numWagons -= cost;
      if (!infinite) {
        obtained = true;
      } else {
        cost *= costMultiplier;
      }
    }
  }

  void show(int x, int y) {
    if (numWagons > cost/2) visible = true;
    if (buildingIDX >= 0) {
      if (buildingIDX < buildings.length) {
        if (buildings[buildingIDX].numBuildings == 0) visible = false;
      } else {
        if (buildingBuilders[buildingIDX - buildings.length].numBuildings == 0) visible = false;
      }
    }
    if (prereq >= 0) {
      if (!upgrades[prereq].obtained) visible = false;
    }
    if (!visible) return;
    if (infinite || name.equals("Endgame")) {
      for (Upgrade up : upgrades) {
        if (!up.infinite && !up.obtained && !up.name.equals("Endgame")) {
          visible = false;
          return;
        }
      }
    }
    fill(c);
    rect(x, y, 20, 20);
    if (obtained) {
      fill(255, 20);
      rect(x, y, 20, 20);
    } else if (numWagons < cost) {
      fill(0, 40);
      rect(x, y, 20, 20);
    }
    if (mouseX > x && mouseX < x + 20 && mouseY > y && mouseY < y + 20) display();
  }

  void display() {
    if (obtained || infinite) fill(200);
    else if (numWagons < cost) fill(40);
    else fill(150);
    rect(430, 200, 200, 70);
    textSize(15);
    fill(0);
    text(name, 530, 210);
    textSize(12);
    text("₩" + truncateFull(cost), 530, 225);
    if (!obtained) {
      text(description, 430, 215, 200, 70);
    } else {
      text("Purchased", 530, 240);
    }
  }
}
