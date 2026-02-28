import 'package:flutter/material.dart';

void main() {
  runApp(const CodingChallenges());
}

class CodingChallenges extends StatelessWidget {
  const CodingChallenges({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coding Challenges App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Coding Challenges App'),
        ),
        body: const Center(child: Challenge5()),
      ),
    );
  }
}

class Challenge5 extends StatelessWidget {
  const Challenge5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final isSmallScreen = width < 600;

    return Container(
      padding: EdgeInsets.all(isSmallScreen ? 16: 32),
      width: isSmallScreen ? width : width * 0.8,
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'Size (width = $width x height = ${size.height})',
        style: TextStyle(fontSize: isSmallScreen ? 16 : 20),
      ),
    );
  }
}

class Challenge4 extends StatelessWidget {
  const Challenge4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Hello'),
        SizedBox(height: 20),
        Icon(Icons.home),
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('World'),
        ),
      ],
    );
  }
}

class Challenge3 extends StatelessWidget {
  const Challenge3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 50,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.teal,
            child: Text('${index + 1}'),
          ),
          title: Text('Item ${index + 1}'),
          trailing: const Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}

class Challenge2 extends StatelessWidget {
  const Challenge2({Key? key}) : super(key: key);

  Future<String> _fetchUserData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Flutter Master';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUserData(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.hasData) {
          return Text("Data: ${snapshot.data}");
        }

        return const Text("No data");
      }
    );
  }
}

class Challenge1 extends StatefulWidget {
  const Challenge1({Key? key}) : super(key: key);

  @override
  State<Challenge1> createState() => _Challenge1State();
}

class _Challenge1State extends State<Challenge1> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $_counter'),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter++;
            });
          },
          child: const Icon(Icons.add),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              _counter--;
            });
          },
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}