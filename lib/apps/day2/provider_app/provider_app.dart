import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'counter_model.dart';
import 'theme_model.dart';
import 'cart_model.dart';

void main() {
  runApp(const ProviderApp());
}

class ProviderApp extends StatelessWidget {
  const ProviderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Q24: MultiProvider - provides multiple models to widget tree
    // All descendants can access these models
    return MultiProvider(
      providers: [
        // Q21: ChangeNotifierProvider - creates and provides ChangeNotifier
        ChangeNotifierProvider(create: (_) => CounterModel()),
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => CartModel()),
      ],
      
      // Q23: Consumer - rebuilds when ThemeModel changes
      child: Consumer<ThemeModel>(
        builder: (context, themeModel, child) {
          return MaterialApp(
            title: 'Provider Demo',
            
            // Use theme from provider
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeModel.themeMode,
            
            home: const ProviderHomeScreen(),
          );
        },
      ),
    );
  }
}

class ProviderHomeScreen extends StatelessWidget {
  const ProviderHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App 1: Provider Pattern'),
        actions: [
          // Q23: Consumer for theme toggle
          Consumer<ThemeModel>(
            builder: (context, themeModel, child) {
              return IconButton(
                icon: Icon(
                  themeModel.isDarkMode 
                      ? Icons.light_mode 
                      : Icons.dark_mode,
                ),
                onPressed: themeModel.toggleTheme,
              );
            },
          ),
        ],
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Counter Section
            const Text(
              'Counter Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const CounterSection(),
            
            const Divider(height: 40),
            
            // Shopping Cart Section
            const Text(
              'Shopping Cart Example',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const ShoppingCartSection(),
            
            const SizedBox(height: 20),
            
            // Educational Notes
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎓 Provider Pattern:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '• ChangeNotifier: Base class for state\n'
                    '• notifyListeners(): Triggers rebuild\n'
                    '• Consumer: Rebuilds when state changes\n'
                    '• Provider.of: Access state without rebuilding\n'
                    '• MultiProvider: Provide multiple models\n',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Q23: Counter section showing Consumer vs Provider.of
class CounterSection extends StatelessWidget {
  const CounterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Q23: Consumer - rebuilds when CounterModel changes
            Consumer<CounterModel>(
              builder: (context, counterModel, child) {
                return Column(
                  children: [
                    Text(
                      '${counterModel.counter}',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'This text rebuilds (inside Consumer)',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Q23: This Text does NOT rebuild (outside Consumer)
            Text(
              'This text NEVER rebuilds (outside Consumer)',
              style: TextStyle(
                fontSize: 12,
                color: Colors.orange.shade600,
              ),
            ),
            
            const SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  // Q23: Provider.of with listen: false
                  // Doesn't rebuild when state changes
                  onPressed: () {
                    Provider.of<CounterModel>(context, listen: false)
                        .decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CounterModel>(context, listen: false)
                        .reset();
                  },
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    // Q23: context.read() - shorthand for Provider.of(listen: false)
                    context.read<CounterModel>().increment();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shopping cart section
class ShoppingCartSection extends StatelessWidget {
  const ShoppingCartSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cart summary
            Consumer<CartModel>(
              builder: (context, cartModel, child) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Items: ${cartModel.itemCount}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Total: \$${cartModel.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    
                    if (cartModel.itemCount > 0) ...[
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: cartModel.clearCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Clear Cart'),
                      ),
                    ],
                  ],
                );
              },
            ),
            
            const Divider(height: 30),
            
            // Product list
            const Text(
              'Available Products:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            // Q23: context.watch() - shorthand for Consumer
            ...context.watch<CartModel>().availableProducts.map((product) {
              return ListTile(
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    context.read<CartModel>().addItem(product.id);
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}