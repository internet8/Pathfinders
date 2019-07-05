import java.util.Comparator;

public class NodeIntegerComparator implements Comparator<Node> {
  @Override
  public int compare (Node n1, Node n2) {
    if (n1.aStarValue > n2.aStarValue) {
      return 1;
    }
    return -1;
  }
}

public class NodeIntegerComparator2 implements Comparator<Node> {
  @Override
  public int compare (Node n1, Node n2) {
    if (n1.value > n2.value) {
      return 1;
    }
    return -1;
  }
}
