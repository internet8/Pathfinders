class AStar {
  public Node[][]maze = new Node[arrayWidth][arrayHeight];
  public Comparator<Node> comparator = new NodeIntegerComparator();
  public PriorityQueue<Node> queue = new PriorityQueue<Node>(10000, comparator);
  public int pathLength = 0;
  public boolean started = false;
  public Node currentNode;
  
  public void search (Node n) {
    boolean addToQueue = false;
    n.children = getChildren(n.x, n.y, maze);
    for (Node child : n.children) {
      if (child.type == 3) {
        started = false;
        queue.clear();
        showPath(n);
        return;
      }
      if (child.value == width * height) {
        addToQueue = true;
      }
      if (getValue(n.value, child.value) + getAStarValue(child.x, child.y) < child.aStarValue) {
        child.value = getValue(n.value, child.value);
        child.aStarValue = child.value + getAStarValue(child.x, child.y);
        child.parent = n;
        child.type = 4;
        if (addToQueue) {
          queue.add(child);
        }
      }
    }
    currentNode = queue.remove();
    if (iterations == 0) {
      iterations = iterationsStartVal;
    } else {
      iterations --;
      search(currentNode);
    }
  }
  
  public void showPath(Node n) {
    Node current = n;
    while (current.parent != null) {
      current.type = 5;
      current = current.parent;
      pathLength ++;
    }
  }
  
  public void render () {
    for (int i = 0; i < (height/cellSize)/2; i++) {
      for (int j = 0; j < (height/cellSize)/2; j++) {
        if (maze[i][j].type == 0) {
          // black
          fill(0);
        } else if (maze[i][j].type == 2) {
          // start
          fill(80, 255, 80);
        } else if (maze[i][j].type == 3) {
          // finish
          fill(255, 100, 100);
        } else if (maze[i][j].type == 4) {
          // visited
          fill(210, 210, 210);
        } else if (maze[i][j].type == 5) {
          // path
          fill(91, 214, 255);
        } else {
          // white
          fill(255);
        }
        stroke(200, 200, 255);
        rect(i*10, j*10, 10, 10);
      }
    }
  }
  
  public void reset () {
    queue.clear();
    pathLength = 0;
    for (int i = 0; i < (height/cellSize)/2; i++) {
      for (int j = 0; j < (height/cellSize)/2; j++) {
        if (maze[i][j].type != 0) {
          maze[i][j].type = 1;
        }
        maze[i][j].value = width * height;
        maze[i][j].aStarValue = width * height;
        maze[i][j].parent = null;
        maze[i][j].children = null;
      }
    }
  }
}
