import java.util.*; 
import java.util.Random;
import java.util.LinkedList;
import java.util.Comparator;
import java.util.PriorityQueue;

private int rnd = 0;
private Random rand = new Random();
boolean startIsSet = false;
boolean finishIsSet = false;
int iterations = 20;
int iterationsStartVal = iterations;
int finishX;
int finishY;
int arrayWidth;
int arrayHeight;
int cellSize = 10;
// algos
AStar aStar;
Dijakstra dijakstra;
BFS bfs;
DFS dfs;

void setup () {
  size(1300, 1300);
  arrayWidth = (width/cellSize)/2;
  arrayHeight = (height/cellSize)/2;
  strokeWeight(1);
  frameRate(60);
  // creating objects
  aStar = new AStar();
  dijakstra = new Dijakstra();
  bfs = new BFS();
  dfs = new DFS();
  // creating random maze
  for (int i = 0; i < (height/cellSize)/2; i++) {
    for (int j = 0; j < (height/cellSize)/2; j++) {
      rnd = rand.nextInt(4);
      if (rnd == 0) {
        aStar.maze[i][j] = new Node(0, i, j, width * height, width * height, null, null);
        dijakstra.maze[i][j] = new Node(0, i, j, width * height, width * height, null, null);
        bfs.maze[i][j] = new Node(0, i, j, width * height, width * height, null, null);
        dfs.maze[i][j] = new Node(0, i, j, width * height, width * height, null, null);
      } else {
        aStar.maze[i][j] = new Node(1, i, j, width * height, width * height, null, null);
        dijakstra.maze[i][j] = new Node(1, i, j, width * height, width * height, null, null);
        bfs.maze[i][j] = new Node(1, i, j, width * height, width * height, null, null);
        dfs.maze[i][j] = new Node(1, i, j, width * height, width * height, null, null);
      }
    }
  }
}

void draw () {
  background(0);
  // rendering maps and text
  aStar.render();
  dijakstra.render();
  bfs.render();
  dfs.render();
  renderText();
  // calling search
  if (startIsSet && finishIsSet && (!aStar.queue.isEmpty() || aStar.started)) {
    aStar.started = false;
    aStar.search(aStar.currentNode);
  }
  if (startIsSet && finishIsSet && (!dijakstra.queue.isEmpty() || dijakstra.started)) {
    dijakstra.started = false;
    dijakstra.search(dijakstra.currentNode);
  }
  if (startIsSet && finishIsSet && (!bfs.queue.isEmpty() || bfs.started)) {
    bfs.started = false;
    bfs.search(bfs.currentNode);
  }
  if (startIsSet && finishIsSet && (!dfs.stack.isEmpty() || dfs.started)) {
    dfs.started = false;
    dfs.search(dfs.currentNode);
  }
  push();
  strokeWeight(3);
  stroke(255, 0, 0);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  pop();
}

private int getValue (int parentVal, int childVal) {
  int newVal;
  if (childVal > parentVal + 1) {
    newVal = parentVal + 1;
  } else {
    newVal = childVal;
  }
  return newVal;
}

private int getAStarValue (int x, int y) {
  return Math.abs(x - finishX)*1 + Math.abs(y - finishY)*1;
}

public ArrayList<Node> getChildren (int x, int y, Node maze[][]) {
  ArrayList<Node> result = new ArrayList<Node>();
  if (x == 0 && y == 0) {
    if (maze[x+1][y].type != 2) {
      result.add(maze[x+1][y]);
    }
    if (maze[x][y+1].type != 2) {
      result.add(maze[x][y+1]);
    }
  } else if (x == 0 && y == (height/cellSize)/2-1) {
    if (maze[x+1][y].type != 0) {
      result.add(maze[x+1][y]);
    }
    if (maze[x][y-1].type != 0) {
      result.add(maze[x][y-1]);
    }
  } else if (x == (height/cellSize)/2-1 && y == 0) {
    if (maze[x-1][y].type != 0) {
      result.add(maze[x-1][y]);
    }
    if (maze[x][y+1].type != 0) {
      result.add(maze[x][y+1]);
    }
  } else if (x == (height/cellSize)/2-1 && y == (height/cellSize)/2-1) {
    if (maze[x-1][y].type != 0) {
      result.add(maze[x-1][y]);
    }
    if (maze[x][y-1].type != 0) {
      result.add(maze[x][y-1]);
    }
  } else if (x == 0) {
    if (maze[x+1][y].type != 0) {
      result.add(maze[x+1][y]);
    }
    if (maze[x][y+1].type != 0) {
      result.add(maze[x][y+1]);
    }
    if (maze[x][y-1].type != 0) {
      result.add(maze[x][y-1]);
    }
  } else if (x == (height/cellSize)/2-1) {
    if (maze[x-1][y].type != 0) {
      result.add(maze[x-1][y]);
    }
    if (maze[x][y+1].type != 0) {
      result.add(maze[x][y+1]);
    }
    if (maze[x][y-1].type != 0) {
      result.add(maze[x][y-1]);
    }
  } else if (y == 0) {
    if (maze[x+1][y].type != 0) {
      result.add(maze[x+1][y]);
    }
    if (maze[x-1][y].type != 0) {
      result.add(maze[x-1][y]);
    }
    if (maze[x][y+1].type != 0) {
      result.add(maze[x][y+1]);
    }
  } else if (y == (height/cellSize)/2-1) {
    if (maze[x+1][y].type != 0) {
      result.add(maze[x+1][y]);
    }
    if (maze[x-1][y].type != 0) {
      result.add(maze[x-1][y]);
    }
    if (maze[x][y-1].type != 0) {
      result.add(maze[x][y-1]);
    }
  } else {
    if (maze[x+1][y].type != 0) {
      result.add(maze[x+1][y]);
    }
    if (maze[x-1][y].type != 0) {
      result.add(maze[x-1][y]);
    }
    if (maze[x][y+1].type != 0) {
      result.add(maze[x][y+1]);
    }
    if (maze[x][y-1].type != 0) {
      result.add(maze[x][y-1]);
    }
  }
  return result;
}

void mouseClicked () {
  int counterX = mouseX;
  int counterY = mouseY;
  if (counterX > width/2 || counterY > height/2) {
    return;
  }
  if (mouseButton == LEFT && !startIsSet) {
    while (counterX % 10 != 0) {
      counterX --;
    }
    while (counterY % 10 != 0) {
      counterY --;
    }
    aStar.maze[counterX/10][counterY/10].type = 2;
    aStar.currentNode = aStar.maze[counterX/10][counterY/10];
    aStar.currentNode.value = 0;
    aStar.currentNode.aStarValue = 0;
    aStar.started = true;
    dijakstra.maze[counterX/10][counterY/10].type = 2;
    dijakstra.currentNode = dijakstra.maze[counterX/10][counterY/10];
    dijakstra.currentNode.value = 0;
    dijakstra.started = true;
    bfs.maze[counterX/10][counterY/10].type = 2;
    bfs.currentNode = bfs.maze[counterX/10][counterY/10];
    bfs.currentNode.value = 0;
    bfs.started = true;
    dfs.maze[counterX/10][counterY/10].type = 2;
    dfs.currentNode = dfs.maze[counterX/10][counterY/10];
    dfs.currentNode.value = 0;
    dfs.started = true;
    startIsSet = true;
  } else if (mouseButton == RIGHT && !finishIsSet) {
    while (counterX % 10 != 0) {
      counterX --;
    }
    while (counterY % 10 != 0) {
      counterY --;
    }
    aStar.maze[counterX/10][counterY/10].type = 3;
    dijakstra.maze[counterX/10][counterY/10].type = 3;
    bfs.maze[counterX/10][counterY/10].type = 3;
    dfs.maze[counterX/10][counterY/10].type = 3;
    finishX = counterX/10;
    finishY = counterY/10;
    finishIsSet = true;
  } else if (mouseButton == CENTER) {
    reset();
  }
}

public void renderText () {
  push();
  textSize(24);
  fill(0);
  rect(0, 0, width/2.3, 40);
  rect(width/2, 0, width/2.3, 40);
  rect(0, height/2, width/2.3, 40);
  rect(width/2, height/2, width/2.3, 40);
  fill(255, 0, 0);
  text("A* | Path Length: " + Integer.toString(aStar.pathLength), 10, 30);
  text("Dijakstra | Path Length: " + Integer.toString(dijakstra.pathLength), width/2+10, 30);
  text("Best-FS | Path Length: " + Integer.toString(bfs.pathLength), 10, height/2+30);
  text("Depth-FS | Path Length: " + Integer.toString(dfs.pathLength), width/2+10, height/2+30);
  pop();
}

public void reset () {
  startIsSet = false;
  finishIsSet = false;
  aStar.reset();
  dijakstra.reset();
  bfs.reset();
  dfs.reset();
}
