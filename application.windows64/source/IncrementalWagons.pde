long numWagons;
float lastFrame;
Player player;
Building[] buildings;
BuildingBuilder[] buildingBuilders;
Upgrade[] upgrades;
Upgrade currentUpgradeDisplay;

boolean clusterioUnlocked, multiplayerUnlocked, buildersUnlocked;
int numFriends, numServers;
long friendCost = 100000000, serverCost = 100000000;
double friendCostMultiplier = 1.4, serverCostMultiplier = 1.4;
double friendMultiplier = 1.05, serverMultiplier = 1.05;

double globalSpeedMultiplier = 1;
double globalProductivityMultiplier = 1;

void setup() {
  size(640, 400);
  player = new Player();
  buildings = new Building[] {
    new Building("Assembling Machine 1", 2000, 10), 
    new Building("Assembling Machine 2", 200, 200), 
    new Building("Assembling Machine 3", 20, 4000)
  };
  buildingBuilders = new BuildingBuilder[] {
    new BuildingBuilder("Assembling Machine 1 Assembler", 0, 10000, 100000), 
    new BuildingBuilder("Assembling Machine 2 Assembler", 1, 10000, 1000000), 
    new BuildingBuilder("Assembling Machine 3 Assembler", 2, 10000, 10000000)
  };
  upgrades = new Upgrade[] {
    new Upgrade("Faster Fingers", "x2 Speed to Hand Crafts", 15, -1, 2, 1, 77, 77, 200), 
    new Upgrade("Dynamic Digits", "x2 Productivity to Hand Crafts", 25, -1, 1, 2, 255, 184, 112, 0), 
    new Upgrade("Faster Fingers 2", "x2 Speed to Hand Crafts", 50, -1, 2, 1, 77, 77, 200, 0), 
    new Upgrade("Iron Axe", "x2 Speed to Assembling Machine 1", 100, 0, 2, 1, 30, 30, 240), 
    new Upgrade("Dynamic Digits 2", "x2 Productivity to Hand Crafts", 400, -1, 1, 2, 255, 184, 112, 1), 
    new Upgrade("Automation Science", "x2 Productivity to Assembling Machine 1", 700, 0, 1, 2, 255, 170, 70), 
    new Upgrade("Faster Fingers 3", "x2 Speed to Hand Crafts", 1000, -1, 2, 1, 77, 77, 200, 2), 
    new Upgrade("Steel Axe", "x2 Speed to Assembling Machine 1", 1400, 0, 2, 1, 30, 30, 240, 3), 
    new Upgrade("Transport Belt", "x2 Speed to Assembling Machine 2", 1800, 1, 2, 1, 30, 30, 240), 
    new Upgrade("Dynamic Digits 3", "x2 Productivity to Hand Crafts", 2200, -1, 1, 2, 255, 184, 112, 4), 
    new Upgrade("Logistic Science", "x2 Productivity to Assembling Machine 1", 2600, 0, 1, 2, 255, 170, 70, 5), 
    new Upgrade("Military Science", "x2 Productivity to Assembling Machine 2", 3000, 1, 1, 2, 255, 170, 70), 
    new Upgrade("Faster Fingers 4", "x2 Speed to Hand Crafts", 3500, -1, 2, 1, 77, 77, 200, 6), 
    new Upgrade("Burner Mining Drill", "x2 Speed to Assembling Machine 1", 4000, 0, 2, 1, 30, 30, 240, 7), 
    new Upgrade("Fast Transport Belt", "x2 Speed to Assembling Machine 2", 4500, 1, 2, 1, 30, 30, 240, 8), 
    new Upgrade("Burner Inserters", "x2 Speed to Assembling Machine 3", 5000, 2, 2, 1, 30, 30, 240), 
    new Upgrade("Dynamic Digits 4", "x2 Productivity to Hand Crafts", 6000, -1, 1, 2, 255, 184, 112, 9), 
    new Upgrade("Chemical Science", "x2 Productivity to Assembling Machine 1", 7000, 0, 1, 2, 255, 170, 70, 10), 
    new Upgrade("Production Science", "x2 Productivity to Assembling Machine 2", 8000, 1, 1, 2, 255, 170, 70, 11), 
    new Upgrade("Utility Science", "x2 Productivity to Assembling Machine 3", 9000, 2, 1, 2, 255, 170, 70), 
    new Upgrade("Speed Module 1", "x2 Speed to all Buildings", 10000, -5, 2, 1, 0, 0, 255, 15), 
    new Upgrade("Productivity Module 1", "x2 Productivity to all Buildings", 10000, -5, 1, 2, 255, 150, 0, 19), 
    new Upgrade("Faster Fingers 5", "x2 Speed to Hand Crafts", 20000, -1, 2, 1, 77, 77, 200, 12), 
    new Upgrade("Electric Mining Drill", "x2 Speed to Assembling Machine 1", 25000, 0, 2, 1, 30, 30, 240, 13), 
    new Upgrade("Express Transport Belt", "x2 Speed to Assembling Machine 2", 30000, 1, 2, 1, 30, 30, 240, 14), 
    new Upgrade("Electric Inserters", "x2 Speed to Assembling Machine 3", 40000, 2, 2, 1, 30, 30, 240, 15), 
    new Upgrade("Dynamic Digits 5", "x2 Productivity to Hand Crafts", 50000, -1, 1, 2, 255, 184, 112, 16), 
    new Upgrade("Space Science", "x2 Productivity to Assembling Machine 1", 60000, 0, 1, 2, 255, 170, 70, 17), 
    new Upgrade("Lab", "x2 Productivity to Assembling Machine 2", 70000, 1, 1, 2, 255, 170, 70, 18), 
    new Upgrade("Mining Productivity", "x2 Productivity to Assembling Machine 3", 80000, 2, 1, 2, 255, 170, 70, 19), 
    new Upgrade("Speed Module 2", "x2 Speed to all Buildings", 100000, -5, 2, 1, 0, 0, 255, 25), 
    new Upgrade("Recursion", "Buildings that build buildings", 100000, -2, 1, 1, 0, 255, 0, 30), 
    new Upgrade("Productivity Module 2", "x2 Productivity to all Buildings", 100000, -5, 1, 2, 255, 150, 0, 29), 
    new Upgrade("Faster Fingers 6", "x2 Speed to Hand Crafts", 200000, -1, 2, 1, 77, 77, 200, 22), 
    new Upgrade("Extra Speed 1", "x2 Speed to Assembling Machine 1", 250000, 0, 2, 1, 30, 30, 240, 23), 
    new Upgrade("Loaders", "x2 Speed to Assembling Machine 2", 300000, 1, 2, 1, 30, 30, 240, 24), 
    new Upgrade("Fast Inserters", "x2 Speed to Assembling Machine 3", 350000, 2, 2, 1, 30, 30, 240, 25), 
    new Upgrade("Mall", "x2 Speed to Assembling Machine 1 Assembler", 400000, 3, 2, 1, 30, 30, 240), 
    new Upgrade("Dynamic Digits 6", "x2 Productivity to Hand Crafts", 500000, -1, 1, 2, 255, 184, 112, 26), 
    new Upgrade("Extra Productivity 1", "x2 Productivity to Assembling Machine 1", 600000, 0, 1, 2, 255, 170, 70, 27), 
    new Upgrade("Construction Robotics", "x2 Productivity to Assembling Machine 2", 700000, 1, 1, 2, 255, 170, 70, 28), 
    new Upgrade("Logistic Robotics", "x2 Productivity to Assembling Machine 3", 800000, 2, 1, 2, 255, 170, 70, 29), 
    new Upgrade("Main Bus", "x2 Productivity to Assembling Machine 1 Assembler", 900000, 3, 1, 2, 255, 170, 70), 
    new Upgrade("Speed Module 3", "x2 Speed to all Buildings", 1000000, -5, 2, 1, 0, 0, 255, 37), 
    new Upgrade("Productivity Module 3", "x2 Productivity to all Buildings", 1000000, -5, 1, 2, 255, 150, 0, 42), 
    new Upgrade("Faster Fingers 7", "x2 Speed to Hand Crafts", 1300000, -1, 2, 1, 77, 77, 200, 33), 
    new Upgrade("Extra Speed 2", "x2 Speed to Assembling Machine 1", 1500000, 0, 2, 1, 30, 30, 240, 34), 
    new Upgrade("Extra Speed 3", "x2 Speed to Assembling Machine 2", 1700000, 1, 2, 1, 30, 30, 240, 35), 
    new Upgrade("Stack Inserters", "x2 Speed to Assembling Machine 3", 2000000, 2, 2, 1, 30, 30, 240, 36), 
    new Upgrade("Mall 2", "x2 Speed to Assembling Machine 1 Assembler", 2400000, 3, 2, 1, 30, 30, 240, 37), 
    new Upgrade("Blueprints", "x2 Speed to Assembling Machine 2 Assembler", 2800000, 4, 2, 1, 30, 30, 240), 
    new Upgrade("Dynamic Digits 7", "x2 Productivity to Hand Crafts", 3200000, -1, 1, 2, 255, 184, 112, 38), 
    new Upgrade("Extra Productivity 2", "x2 Productivity to Assembling Machine 1", 3600000, 0, 1, 2, 255, 170, 70, 39), 
    new Upgrade("Extra Productivity 3", "x2 Productivity to Assembling Machine 2", 4000000, 1, 1, 2, 255, 170, 70, 40), 
    new Upgrade("Combat Robotics", "x2 Productivity to Assembling Machine 3", 4500000, 2, 1, 2, 255, 170, 70, 41), 
    new Upgrade("Main Bus 2", "x2 Productivity to Assembling Machine 1 Assembler", 5000000, 3, 1, 2, 255, 170, 70, 42), 
    new Upgrade("Upgrade Planner", "x2 Productivity to Assembling Machine 2 Assembler", 5500000, 4, 1, 2, 255, 170, 70), 
    new Upgrade("Beacons", "x2 Speed and Productivity to all Buildings", 7000000, -5, 2, 2, 255, 0, 255, 56), 
    new Upgrade("Faster Fingers 8", "x2 Speed to Hand Crafts", 8000000, -1, 2, 1, 77, 77, 200, 45), 
    new Upgrade("Extra Speed 4", "x2 Speed to Assembling Machine 1", 9000000, 0, 2, 1, 30, 30, 240, 46), 
    new Upgrade("Extra Speed 5", "x2 Speed to Assembling Machine 2", 10000000, 1, 2, 1, 30, 30, 240, 47), 
    new Upgrade("Extra Speed 6", "x2 Speed to Assembling Machine 3", 12000000, 2, 2, 1, 30, 30, 240, 48), 
    new Upgrade("Mall 3", "x2 Speed to Assembling Machine 1 Assembler", 14000000, 3, 2, 1, 30, 30, 240, 49), 
    new Upgrade("Blueprints 2", "x2 Speed to Assembling Machine 2 Assembler", 16000000, 4, 2, 1, 30, 30, 240, 50), 
    new Upgrade("Blueprint book", "x2 Speed to Assembling Machine 3 Assembler", 18000000, 5, 2, 1, 30, 30, 240), 
    new Upgrade("Dynamic Digits 8", "x2 Productivity to Hand Crafts", 20000000, -1, 1, 2, 255, 184, 112, 51), 
    new Upgrade("Extra Productivity 4", "x2 Productivity to Assembling Machine 1", 25000000, 0, 1, 2, 255, 170, 70, 52), 
    new Upgrade("Extra Productivity 5", "x2 Productivity to Assembling Machine 2", 30000000, 1, 1, 2, 255, 170, 70, 53), 
    new Upgrade("Extra Productivity 6", "x2 Productivity to Assembling Machine 3", 35000000, 2, 1, 2, 255, 170, 70, 54), 
    new Upgrade("Main bus 3", "x2 Productivity to Assembling Machine 1 Assembler", 40000000, 3, 1, 2, 255, 170, 70, 55), 
    new Upgrade("Upgrade Planner 2", "x2 Productivity to Assembling Machine 2 Assembler", 45000000, 4, 1, 2, 255, 170, 70, 56), 
    new Upgrade("Deconstruction Planner", "x2 Productivity to Assembling Machine 3 Assembler", 50000000, 5, 1, 2, 255, 170, 70), 
    new Upgrade("Multiplayer", "Pay your friends to help out", 100000000, -3, 1, 1, 0, 255, 0, 64), 
    new Upgrade("Clusterio", "Get entire servers to join the cause", 100000000, -4, 1, 1, 0, 255, 0, 71), 
    new Upgrade("Infinite Hand Crafting", "x1.5 Speed and Productivity to Hand Crafts", 1000000000, -1, 1.5, 1.5, 255, 70, 255, 71, true), 
    new Upgrade("Infinite Speed 1", "x1.5 Speed to Assembling Machine 1", 1000000000, 0, 1.5, 1, 30, 30, 240, 71, true), 
    new Upgrade("Infinite Speed 2", "x1.5 Speed to Assembling Machine 2", 1000000000, 1, 1.5, 1, 30, 30, 240, 71, true), 
    new Upgrade("Infinite Speed 3", "x1.5 Speed to Assembling Machine 3", 1000000000, 2, 1.5, 1, 30, 30, 240, 71, true), 
    new Upgrade("Infinite Speed 4", "x1.5 Speed to Assembling Machine 1 Assembler", 1000000000, 3, 1.5, 1, 30, 30, 240, 71, true), 
    new Upgrade("Infinite Speed 5", "x1.5 Speed to Assembling Machine 2 Assembler", 1000000000, 4, 1.5, 1, 30, 30, 240, 71, true), 
    new Upgrade("Infinite Speed 6", "x1.5 Speed to Assembling Machine 3 Assembler", 1000000000, 5, 1.5, 1, 30, 30, 240, 71, true), 
    new Upgrade("Infinite Productivity 1", "x1.5 Productivity to Assembling Machine 1", 1000000000, 0, 1, 1.5, 255, 170, 70, 71, true), 
    new Upgrade("Infinite Productivity 2", "x1.5 Productivity to Assembling Machine 2", 1000000000, 1, 1, 1.5, 255, 170, 70, 71, true), 
    new Upgrade("Infinite Productivity 3", "x1.5 Productivity to Assembling Machine 3", 1000000000, 2, 1, 1.5, 255, 170, 70, 71, true), 
    new Upgrade("Infinite Productivity 4", "x1.5 Productivity to Assembling Machine 1 Assembler", 1000000000, 3, 1, 1.5, 255, 170, 70, 71, true), 
    new Upgrade("Infinite Productivity 5", "x1.5 Productivity to Assembling Machine 2 Assembler", 1000000000, 4, 1, 1.5, 255, 170, 70, 71, true), 
    new Upgrade("Infinite Productivity 6", "x1.5 Productivity to Assembling Machine 3 Assembler", 1000000000, 5, 1, 1.5, 255, 170, 70, 71, true), 
    new Upgrade("Better Friends", "Friends are 1.1x faster", 1000000000, -3, 1.1, 1, 70, 70, 255, 71, true), 
    new Upgrade("Better Computers", "Computers are 1.1x more efficient", 1000000000, -4, 1, 1.1, 255, 150, 70, 71, true), 
    new Upgrade("Endgame", "This is the last thing to get", 1000000000000l, -5, 100, 100, 255, 255, 255, 71) 
  };

  textAlign(CENTER, CENTER);
  //numWagons = 10000000000000l;
}

void draw() {
  background(80);

  // wagon area
  fill(150);
  noStroke();
  rect(0, height*0.7, width, height * 0.3);
  fill(200);
  player.checkCraft();
  rect(0, height * 0.7, width * player.proportion, height * 0.3);
  if (player.proportion >= 1) numWagons += player.craftsPerCycle;
  fill(0);
  textSize(30);
  text("Wagons: " + numWagons, width/2, height * 0.85);

  // buildings area
  int y = 10;
  for (int i = 0; i < buildings.length; i++) {
    buildings[i].show(10, y);
    y += 60;
  }

  // building builders
  y = 10;
  for (int i = 0; i < buildingBuilders.length; i++) {
    buildingBuilders[i].show(220, y);
    y += 60;
  }

  // upgrades
  y = 10;
  for (int i = 0; i < upgrades.length; i++) {
    int x = (i % 10) * 20 + 430;
    upgrades[i].show(x, y);
    if ((i+1) % 10 == 0) y += 20;
  }

  // friends
  if (multiplayerUnlocked) {
    fill(150);
    rect(10, 200, 200, 70);
    textSize(40);
    fill(200);
    text(numFriends, 110, 230);
    fill(0);
    textSize(15);
    text("Friends", 110, 210);
    textSize(12);
    text("₩" + floor(friendCost), 110, 255);
    if (mouseX > 10 && mouseX < 210 && mouseY > 200 && mouseY < 270) displayFriends();
  }

  // servers
  if (clusterioUnlocked) {
    fill(150);
    rect(220, 200, 200, 70);
    textSize(40);
    fill(200);
    text(numServers, 320, 230);
    fill(0);
    textSize(15);
    text("Servers", 320, 210);
    textSize(12);
    text("₩" + floor(serverCost), 320, 255);
    if (mouseX > 220 && mouseX < 420 && mouseY > 200 && mouseY < 270) displayServers();
  }
}

void displayFriends() {
  fill(150);
  rect(430, 200, 200, 70);
  textSize(15);
  fill(0);
  text("Friends", 530, 210);
  textSize(12);
  double amt = truncate(Math.pow(friendMultiplier, numFriends) * 100);
  text(amt + "% Speed", 530, 225);
  textSize(10);
  text("Each friend provides a global speed boost to all structures", 430, 215, 200, 70);
}

void displayServers() {
  fill(150);
  rect(430, 200, 200, 70);
  textSize(15);
  fill(0);
  text("Servers", 530, 210);
  textSize(12);
  double amt = truncate(Math.pow(serverMultiplier, numServers) * 100);
  text(amt + "% Productivity", 530, 225);
  textSize(10);
  text("Each server provides a global productivity boost to all structures", 430, 215, 200, 70);
}

void mouseClicked() {
  // manual crafting
  if (mouseY > height * 0.7) {
    player.craftWagon();
  }
  // building purchase
  if (mouseX > 10 && mouseX < 210) {
    if (mouseY > 10 && mouseY < 60) {
      numWagons -= buildings[0].buy();
    } else if (mouseY > 70 && mouseY < 120) {
      numWagons -= buildings[1].buy();
    } else if (mouseY > 130 && mouseY < 180) {
      numWagons -= buildings[2].buy();
    }
  }
  // building builders
  if (mouseX > 220 && mouseX < 420) {
    if (mouseY > 10 && mouseY < 60) {
      numWagons -= buildingBuilders[0].buy();
    } else if (mouseY > 70 && mouseY < 120) {
      numWagons -= buildingBuilders[1].buy();
    } else if (mouseY > 130 && mouseY < 180) {
      numWagons -= buildingBuilders[2].buy();
    }
  }

  // upgrades
  if (mouseX > 430 && mouseX < 630) {
    float x = (mouseX - 430) / 20;
    float y = (mouseY - 10) / 20;
    int idx = floor(x) + floor(y) * 10;
    if (idx < upgrades.length) {
      upgrades[idx].apply();
    }
  }

  // friends
  if (multiplayerUnlocked) {
    if (mouseX > 10 && mouseX < 210 && mouseY > 200 && mouseY < 270) {
      if (numWagons >= friendCost) {
        numWagons -= friendCost;
        friendCost *= friendCostMultiplier;
        numFriends++;
      }
    }
  }

  // servers
  if (clusterioUnlocked) {
    if (mouseX > 220 && mouseX < 420 && mouseY > 200 && mouseY < 270) {
      if (numWagons >= serverCost) {
        numWagons -= serverCost;
        serverCost *= serverCostMultiplier;
        numServers++;
      }
    }
  }
}

//String stringifyDouble(double number) {
//  return split("" + number, ".")[0];
//}

double truncate(double d) {
  String s = "" + d;
  int idx = s.indexOf(".");
  s = s.substring(0, idx + 2);
  return Double.valueOf(s);
}
