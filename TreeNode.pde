public class TreeNode<T>{
  T data;
  TreeNode left;
  TreeNode right;
  TreeNode (T data){
    this.data=data;
    this.left=null;
    this.right=null;
  }
    public T getDate() {
    return data;
  }
  public void setDate(T data
  ) {
    this.data = data;
  }
  public TreeNode getleft() {
    return left;
  }
  public void setleft(TreeNode left) {
    this.left = left;
  }
  public TreeNode getright() {
    return right;
  }
  public void setright(TreeNode right) {
    this.right = right;
  }
}
