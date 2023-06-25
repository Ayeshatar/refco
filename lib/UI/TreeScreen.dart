import 'package:flutter/material.dart';

// Define the user class
class User {
  final String name;
  final String image;

  User(this.name, this.image);

  User? leftChild;
  User? rightChild;
}


// Define the binary tree class
class BinaryTree {
  late User root;

  List<List<BinaryTreeNode>> getNodesByLevel() {
    final queue = <BinaryTreeNode>[];
    final result = <List<BinaryTreeNode>>[];
    if (root != null) {
      queue.add(BinaryTreeNode(root, 0));
      while (queue.isNotEmpty) {
        final node = queue.removeAt(0);
        if (result.length <= node.level) {
          result.add([node]);
        } else {
          result[node.level].add(node);
        }
        if (node.user.leftChild != null) {
          queue.add(BinaryTreeNode(node.user.leftChild!, node.level + 1));
        }
        if (node.user.rightChild != null) {
          queue.add(BinaryTreeNode(node.user.rightChild!, node.level + 1));
        }
      }
    }
    return result;
  }
}

// Define the binary tree node class
class BinaryTreeNode {
  final User user;
  final int level;

  BinaryTreeNode(this.user, this.level);
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Tree Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:binaryscreen(),
    );
  }
}

class binaryscreen extends StatelessWidget {
  static const String routeName = '/';
  // Define the users
  final User userA = User('A', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80');
  final User userB = User('B', 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80');
  final User userC = User('C', 'https://media.istockphoto.com/id/518873011/photo/he-never-misses-a-deadline.jpg?s=612x612&w=is&k=20&c=sxq73QHwLwiJSyUhvM69v86U1MBHPSHalH8-VLweUbA=');
  final User userD = User('D', 'https://media.istockphoto.com/id/518873011/photo/he-never-misses-a-deadline.jpg?s=612x612&w=is&k=20&c=sxq73QHwLwiJSyUhvM69v86U1MBHPSHalH8-VLweUbA=');
  final User userE = User('E', 'https://media.istockphoto.com/id/518873011/photo/he-never-misses-a-deadline.jpg?s=612x612&w=is&k=20&c=sxq73QHwLwiJSyUhvM69v86U1MBHPSHalH8-VLweUbA=');
  final User userF = User('F', 'https://media.istockphoto.com/id/518873011/photo/he-never-misses-a-deadline.jpg?s=612x612&w=is&k=20&c=sxq73QHwLwiJSyUhvM69v86U1MBHPSHalH8-VLweUbA=');
  final User userG = User('G', 'https://media.istockphoto.com/id/518873011/photo/he-never-misses-a-deadline.jpg?s=612x612&w=is&k=20&c=sxq73QHwLwiJSyUhvM69v86U1MBHPSHalH8-VLweUbA=');
  final User userH = User('H', 'https://media.istockphoto.com/id/518873011/photo/he-never-misses-a-deadline.jpg?s=612x612&w=is&k=20&c=sxq73QHwLwiJSyUhvM69v86U1MBHPSHalH8-VLweUbA=');
  final User userI = User('I', 'https://media.istockphoto.com/id/518873011/photo/he-never-misses-a-deadline.jpg?s=612x612&w=is&k=20&c=sxq73QHwLwiJSyUhvM69v86U1MBHPSHalH8-VLweUbA=');
  final User userJ = User('J', 'https://media.istockphoto.com/id/518873011/photo/he-never-misses-a-deadline.jpg?s=612x612&w=is&k=20&c=sxq73QHwLwiJSyUhvM69v86U1MBHPSHalH8-VLweUbA=');

  // Set the parent-child relationships
  MyHomePage() {
    userA.leftChild = userB;
    userA.rightChild = userC;
    userB.leftChild = userD;
    userB.rightChild = userE;
    userC.leftChild = userF;
    userD.leftChild =userG;
    userF.leftChild = userJ;
    userE.leftChild=userH;
    userE.rightChild = userI;




  }


  @override
  Widget build(BuildContext context) {
    final binaryTree = BinaryTree();
    binaryTree.root = userA;

    return Scaffold(
      appBar: AppBar(
        title: Text('Binary Tree Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      for (final nodes in binaryTree.getNodesByLevel())
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            for (final node in nodes)
                              buildUserTile(node),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build a user tile
  // Helper method to build a user tile
  Widget buildUserTile(BinaryTreeNode node) {
    final user = node.user;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              user.image?.toString() ?? 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',

            ),
            radius: 30.0,
          ),
          SizedBox(height: 8.0),
          Text(user.name),
        ],
      ),
    );
  }
}
