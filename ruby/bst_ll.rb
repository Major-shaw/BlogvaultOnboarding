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
      print(node.data, " ")
      self.inorder(node.right)
    end
  end

  def preorder(node)
    if node != nil
      print(node.data, " ")
      self.preorder(node.left)
      self.preorder(node.right)
    end
  end

  def postorder(node)
    if node != nil
      self.postorder(node.left)
      self.postorder(node.right)
      print(node.data, " ")
    end
  end

  def levelorder(node)
    if node == nil
      return nil
    end
    queue = []
    queue.append(node)

    while queue.length() > 0
      print(queue[0].data, " ")
      curr = queue.shift()
      if curr.left != nil
        queue.append(curr.left)
      end
      if curr.right != nil
        queue.append(curr.right)
      end
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

    if suc_parent != node
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
      print_array(path, pathLen)
    else
      printpaths_rec(root.left, path, pathLen)
      printpaths_rec(root.right, path, pathLen)
    end
  end

  def print_array(ints, len)
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

  def print_preorder(node)
    puts "preorder: "
    self.preorder(node)
    puts ""
  end

  def print_postorder(node)
    puts "postorder: "
    self.postorder(node)
    puts ""
  end

  def print_levelorder(node)
    puts "levelorder: "
    self.levelorder(node)
    puts ""
  end

end

class LLNode < Node
  attr_accessor :data, :next

  def initialize(data, next_ptr = nil)
    self.data = data
    self.next = next_ptr
  end
end

class LinkedList
  attr_accessor :head

  def initialize()
    self.head = nil
  end

  def add(val)
    if self.head == nil
      self.head = LLNode.new(val)
    else
      curr = self.head
      new_node = LLNode.new(val)
      while curr.next != nil
        curr = curr.next
      end
      curr.next = new_node
    end
  end

  def delete(val)
    node = self.head

    if node == nil
      self.print_list()
      return nil
    end
    if node.data == val
      self.head = node.next
      node = nil
      puts "updated list: "
      self.print_list()
    end

    while node != nil
      if node.data == val
        break
      end
      prev = node
      node = node.next
    end

    if node == nil
      return nil
    end

    prev.next = node.next
    node = nil
    puts "updated list: "
    self.print_list()
  end

  def search(val)
    node = self.head
    while node != nil
      if node.data == val
        return true
      end
      node = node.next
    end
    return false
  end

  def print_list()
    node = self.head
    if node == nil
      put "Empty List"
    end
    while node != nil
      print(node.data, " ")
      node = node.next
    end
    puts ""
  end

  def reverse()
    prev = nil
    curr = self.head
    while curr != nil
      next_ptr = curr.next
      curr.next = prev
      prev = curr
      curr = next_ptr
    end
    self.head = prev
  end
end


def tree_interface()
  tree = BST.new()
  puts "Enter 1 to give inputs from a file, Enter to skip"
  input = gets.chomp
  if input == "1"
    puts "Enter file name: "
    filename = gets.chomp
    file = File.open(filename, "r")
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

    puts "Initialising Tree.. Enter root value: "
    root_val = gets.to_i
    tree.values.append(root_val)
    tree.root = tree.insert(tree.root, root_val)
  end
  puts "Enter 1 to add elements"
  puts "Enter 2 to find max element, 3 to find smallest element"
  puts "Enter 4 to search for an element"
  puts "Enter 5 to delete an element"
  puts "Enter 6 to print paths from root to leaves"
  puts "Enter 7 to print inorder traversal"
  puts "Enter 8 to print preorder traversal"
  puts "Enter 9 to print postorder traversal"
  puts "Enter 10 to print Levelorder"
  puts "Enter quit to exit"
  puts "========================================================"

  loop do
    print ">> "
    input = gets.chomp
    if input == 'quit'
      File.write("tree_elements.txt", tree.values.join("\n"))
      break
    end
    if input == '1'
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
      next
    end

    if input == '2'
      puts("Largest element: ", tree.find_max(tree.root))
      next
    end

    if input == '3'
      puts("smallest element: ", tree.find_min(tree.root))
      next
    end 

    if input == '4'
      puts "Enter the element you want to search"
      key = gets.to_i
      puts tree.search(tree.root, key)
      next
    end  

    if input == '5'
      puts "Enter the element you want to delete"
      key = gets.to_i
      if tree.search(tree.root, key) == true
        tree.values.delete(key)
        tree.delete(tree.root, key)
      end
      puts "updated tree: "
      tree.print_inorder(tree.root)
      next
    end

    if input == '6'
      tree.print_paths(tree.root)
      next
    end

    if input == '7'
      tree.print_inorder(tree.root)
      next
    end

    if input == '8'
      tree.print_preorder(tree.root)
      next
    end
    if input == '9'  
      tree.print_postorder(tree.root)
      next
    end

    if input == '10'
      tree.print_levelorder(tree.root)
    else
      puts "Invalid input"
    end

  end
end

def linkedList_interface()
  list = LinkedList.new()
  puts "Enter 1 to add elements"
  puts "Enter 2 to print the list"
  puts "Enter 3 to delete an element"
  puts "Enter 4 to search an element"
  puts "Enter 5 to reverse an element"
  puts "Enter quit to exit"

  loop do
    print ">> "
    input = gets.chomp
    if input == '1'
      arr = []
      puts "Enter elements: "
      ele = gets.chomp
      arr = ele.split(",")

      for i in arr do
        val = i.to_i 
        list.add(val)
      end
      puts "Printing list: "
      list.print_list()
      next
    end

    if input == '2'
      list.print_list()
      next
    end

    if input == '3'
      puts "Enter the element you want to delete: "
      ele = gets.to_i
      list.delete(ele)
      next
    end

    if input == '4'
      puts "Enter the element you want to search: "
      ele = gets.to_i
      puts(list.search(ele))
      next
    end

    if input == '5'
      list.reverse()
      puts "reversed list: "
      list.print_list()
      next
    end

    if input == 'quit'
      break
    else
      puts "Invalid Input"
    end
  end
end

def main()
  loop do
    puts "Enter 1 to work on BST"
    puts "Enter 2 to work on Linked List"
    puts "Enter quit to exit"

    print ">> "
    input = gets.chomp
    if input == '1'
      tree_interface()
      next
    end
    if input == '2'
      linkedList_interface()
      next
    end
    if input == 'quit'
      break
    else
      puts "Invalid input"
    end
  end
end

main()
