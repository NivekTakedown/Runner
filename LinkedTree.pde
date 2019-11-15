public class LinkedTree<T>{
  private TreeNode root;
  LinkedTree(TreeNode root){
    this.root=root;
  }
  public TreeNode getroot(){
    return root;
  }
  public void setroot(TreeNode root){
    this.root=root;
  }
}
