import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const ListApp());
}

class ListApp extends StatelessWidget {
  const ListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Q19: MaterialApp - Material Design
    return MaterialApp(
      title: 'List & Stream',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const ListScreen(),
    );
    
    // Q19: CupertinoApp - iOS Design
    // return CupertinoApp(
    //   title: 'List & Stream',
    //   theme: CupertinoThemeData(),
    //   home: ListScreen(),
    // );
  }
}

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  // Q13: Stream - multiple values over time
  // StreamController manages a stream
  final _messageController = StreamController<String>();
  
  // List for ListView demo
  final List<String> _items = List.generate(20, (i) => 'Item ${i + 1}');
  
  int _messageCount = 0;

  @override
  void initState() {
    super.initState();
    
    // Q13: Simulate real-time messages
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      _messageCount++;
      // Q13: Add data to stream
      _messageController.add('Message $_messageCount at ${DateTime.now().second}s');
    });
  }

  @override
  void dispose() {
    // Q13: Always close stream controllers
    _messageController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Q20: MediaQuery - device information
    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final orientation = MediaQuery.of(context).orientation;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 5: List & Stream'),
      ),
      
      body: Column(
        children: [
          // Q20: MediaQuery info panel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.teal[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'MediaQuery Info:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text('Screen: ${size.width.toInt()} x ${size.height.toInt()}'),
                Text('Orientation: $orientation'),
                Text('Top padding: ${padding.top.toInt()}px (status bar)'),
                Text('Bottom padding: ${padding.bottom.toInt()}px (nav bar)'),
              ],
            ),
          ),
          
          // Q15: StreamBuilder - builds UI from Stream
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'StreamBuilder (Real-time Messages):',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                StreamBuilder<String>(
                  // Q15: stream to listen to
                  stream: _messageController.stream,
                  
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Waiting for messages...');
                    }
                    
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    
                    if (snapshot.hasData) {
                      // Q15: Gets called every time stream emits data
                      return Text(
                        '📨 ${snapshot.data}',
                        style: const TextStyle(color: Colors.green),
                      );
                    }
                    
                    return const Text('No messages yet');
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 10),
          
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'ListView.builder Example:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          
          // Q16: ListView.builder - builds items on demand
          // More efficient than ListView for large lists
          Expanded(
            child: ListView.builder(
              // Q16: itemCount - number of items
              itemCount: _items.length,
              
              // Q16: itemBuilder - called for each visible item
              // Only builds what's on screen (lazy loading)
              itemBuilder: (context, index) {
                print('Building item $index'); // See lazy loading
                
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal,
                    child: Text('${index + 1}'),
                  ),
                  title: Text(_items[index]),
                  subtitle: Text('Index: $index'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Q18: Navigate with data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailView(
                          item: _items[index],
                          index: index,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // Add new item
            _items.add('Item ${_items.length + 1}');
          });
          
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item added! Scroll to bottom'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

// Detail view for list item
class DetailView extends StatelessWidget {
  final String item;
  final int index;
  
  const DetailView({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Q20: MediaQuery for responsive UI
    final width = MediaQuery.of(context).size.width;
    final isSmallScreen = width < 600;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: $item'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                // Q20: Responsive icon size
                size: isSmallScreen ? 80 : 120,
                color: Colors.teal,
              ),
              const SizedBox(height: 20),
              Text(
                item,
                style: TextStyle(
                  // Q20: Responsive text size
                  fontSize: isSmallScreen ? 24 : 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text('Index: $index'),
              const SizedBox(height: 30),
              
              // Q17: SingleChildScrollView example
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SingleChildScrollView(
                  // Q17: Use when content might overflow
                  // Unlike ListView, renders all children
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'SingleChildScrollView Demo\n\n'
                    'This is a scrollable text container.\n'
                    'Unlike ListView, it renders all content at once.\n'
                    'Use ListView.builder for large lists.\n'
                    'Use SingleChildScrollView for forms or small content.\n\n'
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                    'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.\n\n'
                    'More text here to demonstrate scrolling...\n'
                    'Keep scrolling...\n'
                    'Almost there...\n'
                    'End of content!',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              
              const SizedBox(height: 30),
              
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}