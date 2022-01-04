class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    self.data = data
    self.left = nil
    self.right = nil
  end
end

class BST
 attr_accessor :root, :values

  def initialize()
    self.root = nil
    self.values = []
  end
  
  def insert(node, val)
    if node != nil
      if node.data >= val
        node.left = self.insert(node.left, val)
      else
        node.right = self.insert(node.right, val)
      end
      return node
    else
      return Node.new(val)
    end
  end
  
  def inorder(node)
    if node != nil
      self.inorder(node.left)
      print(" ", node.data)
      self.inorder(node.right)
    end
  end
  
  def find_max(node)
    if node == nil
      return nil
    elsif node.right == nil
      return node.data
    end
    return find_max(node.right)
  end  
  
  def find_min(node)
   if node == nil
     return nil
   elsif node.left == nil
     return node.data
  end
   return find_min(node.left)
  end
  
  def search(node, key)
    if node == nil
      return false
    elsif node.data == key
      return true
    end
    if key > node.data
      return search(node.right, key)
    else
      return search(node.left, key)
    end
    return false  
  end    

  def delete(node, key)
    if node == nil
      return node
    end 
    if key < node.data
      node.left = delete(node.left, key)
      return node
    elsif key > node.data
      node.right = delete(node.right, key)
      return node
    end

    if node.left == nil and node.right == nil
      return nil
    end
    if node.left == nil
      temp = node.right
      node = nil
      return temp  
    elsif node.right == nil
      temp = node.left
      node = nil
      return temp
    end
      
    suc_parent = node
    succ = node.right
      
    while succ.left != nil
      suc_parent = succ
      succ = succ.left
    end
      
    if suc_parent != root
      suc_parent.left = succ.right
    else
      suc_parent.right = succ.right
    end
    node.data = succ.data  
    return node
  end
  
  def print_paths(node)
   path = []
   printpaths_rec(node, path, 0)
  end

  def printpaths_rec(root, path, pathLen)
    if root == nil
      return nil
    end
    if path.length() > pathLen
      path[pathLen] = root.data
    else
      path.append(root.data)
    end
    
    pathLen = pathLen + 1
    if root.left == nil and root.right == nil
      printArray(path, pathLen)
    else
      printpaths_rec(root.left, path, pathLen)
      printpaths_rec(root.right, path, pathLen)
    end
  end

  def printArray(ints, len)
    for i in 0...len do
      print(ints[i], " ")
    end
    puts "" 
  end



  def print_inorder(node)
    puts "inorder: "
    self.inorder(node)
    puts ""
  end

end

def main()
  tree = BST.new()
  puts "Enter 1 to give inputs from a file, Enter to skip"
  input = gets.chomp
  if input == "1"
    puts "getting inputs from input.txt file"
    file = File.open("input.txt")
    file_data = file.readlines.map(&:chomp)
    tree.root = tree.insert(tree.root, file_data.shift().to_i)
    for i in file_data do
      val = i.to_i
        if tree.search(tree.root, val) == false
          tree.values.append(val)  
          tree.insert(tree.root, val)
        end
      end
  else

    puts "Enter root value"
    root_val = gets.to_i
    tree.values.append(root_val)
    tree.root = tree.insert(tree.root, root_val)
  end
  puts "Enter 1 to add elements, 0 to Exit"
  puts "Enter 3 to find max element, 4 to find smallest element"
  puts "Enter 5 to search for an element"
  puts "Enter 6 to delete an element"
  puts "Enter 7 to print paths from root to leaves"
  
  while true
    input = gets.to_i
    if input == 0
      File.write("tree_elements.txt", tree.values.join("\n"))
      break
    end
    if input == 1
      arr = []
      puts "Enter elements"
      input = gets.chomp
      arr = input.split(",")

      for i in arr do
        val = i.to_i
        if tree.search(tree.root, val) == false
          tree.values.append(val)  
          tree.insert(tree.root, val)
        end
      end
      tree.print_inorder(tree.root)
    end
    if input == 3
      puts("Largest element: ", tree.find_max(tree.root))
    end
    if input == 4
      puts("smallest element: ", tree.find_min(tree.root))
    end 
    if input == 5
      puts "Enter the element you want to search"
      key = gets.to_i
      puts tree.search(tree.root, key)
    end  
    if input == 6
      puts "Enter the element you want to delete"
      key = gets.to_i
      if tree.search(tree.root, key) == true
        tree.values.delete(key)
        tree.delete(tree.root, key)
      end
      puts "updated tree: "
      tree.print_inorder(tree.root)
    end
    
    if input == 7
      tree.print_paths(tree.root)
    end

  end
  tree.print_inorder(tree.root)
end
main()
