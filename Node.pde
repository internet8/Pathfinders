class Node {
  public int type;
  public int x;
  public int y;
  public int value;
  public int aStarValue;
  public Node parent;
  public ArrayList<Node> children = new ArrayList<Node>();
  
  public Node (int type, int x, int y, int value, int aStarValue, Node parent, ArrayList<Node> children) {
    this.type = type;
    this.x = x;
    this.y = y;
    this.value = value;
    this.aStarValue = aStarValue;
    this.parent = parent;
    this.children = children;
  }  
}
