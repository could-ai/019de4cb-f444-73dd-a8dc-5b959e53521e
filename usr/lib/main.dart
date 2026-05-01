import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantAIAgentApp());
}

class RestaurantAIAgentApp extends StatelessWidget {
  const RestaurantAIAgentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant AI Agent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE65100), // Restaurant warm orange theme
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE65100),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,
      home: const MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const OrdersPage(),
    const AiSettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isDesktop
          ? null
          : AppBar(
              title: const Text('Restaurant AI Agent', style: TextStyle(fontWeight: FontWeight.bold)),
              centerTitle: true,
              elevation: 2,
            ),
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              extended: true,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              leading: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Icon(Icons.restaurant_menu, size: 40, color: Colors.deepOrange),
                    SizedBox(height: 8),
                    Text(
                      'AI Waiter\nDashboard',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
              ),
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: Text('Dashboard'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  selectedIcon: Icon(Icons.receipt_long),
                  label: Text('Orders & Bills'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.smart_toy_outlined),
                  selectedIcon: Icon(Icons.smart_toy),
                  label: Text('AI Settings'),
                ),
              ],
            ),
          if (isDesktop) const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.dashboard_outlined),
                  selectedIcon: Icon(Icons.dashboard),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.receipt_long_outlined),
                  selectedIcon: Icon(Icons.receipt_long),
                  label: 'Orders',
                ),
                NavigationDestination(
                  icon: Icon(Icons.smart_toy_outlined),
                  selectedIcon: Icon(Icons.smart_toy),
                  label: 'AI Setup',
                ),
              ],
            ),
    );
  }
}

// ---------------------------------------------------------
// DASHBOARD PAGE
// ---------------------------------------------------------
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Scaffold(
      appBar: isDesktop
          ? AppBar(title: const Text('Overview / Dashboard', style: TextStyle(fontWeight: FontWeight.bold)))
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome, Restaurant Owner! 👋',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Aapka AI Agent calls pick karne aur orders lene ke liye ready hai.',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            
            // STATS CARDS
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = isDesktop ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: isDesktop ? 2.5 : 2.0,
                  children: const [
                    StatCard(
                      title: 'Aaj ke Orders',
                      value: '14',
                      icon: Icons.shopping_bag,
                      color: Colors.blue,
                    ),
                    StatCard(
                      title: 'Active AI Calls',
                      value: '1',
                      icon: Icons.phone_in_talk,
                      color: Colors.green,
                      isPulsing: true,
                    ),
                    StatCard(
                      title: 'Total Revenue',
                      value: 'Rs. 12,450',
                      icon: Icons.payments,
                      color: Colors.orange,
                    ),
                  ],
                );
              }
            ),
            
            const SizedBox(height: 32),
            const Text(
              '🔴 Live AI Agent Call',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const LiveCallMonitor(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Test Call Initiated... AI is ringing!')),
          );
        },
        icon: const Icon(Icons.call),
        label: const Text('Test AI Agent Call'),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final bool isPulsing;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.isPulsing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      if (isPulsing) ...[
                        const SizedBox(width: 8),
                        const SizedBox(
                          width: 10,
                          height: 10,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.green),
                        )
                      ]
                    ],
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

class LiveCallMonitor extends StatelessWidget {
  const LiveCallMonitor({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green.shade200, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.record_voice_over, color: Colors.green),
                const SizedBox(width: 8),
                const Text('Customer: 0300-1234567', style: TextStyle(fontWeight: FontWeight.bold)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Live', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                )
              ],
            ),
            const Divider(height: 32),
            const ChatBubble(
              text: "Hello, me ek Zinger burger or 2 regular fries order karna chahta hu.",
              isAI: false,
            ),
            const SizedBox(height: 12),
            const ChatBubble(
              text: "Zarur sir! 1 Zinger burger aur 2 regular fries. Kya aap drinks bhi add karna chahenge?",
              isAI: true,
            ),
            const SizedBox(height: 12),
            const ChatBubble(
              text: "Haan, 2 pepsi can add kar dein. Aur bill kitna hua?",
              isAI: false,
            ),
            const SizedBox(height: 12),
            const ChatBubble(
              text: "Apka order note ho gaya hai. 1 Zinger (Rs 600), 2 Fries (Rs 400), aur 2 Pepsi (Rs 200). Total bill Rs 1200 ban gaya hai. Order confirm kar dun?",
              isAI: true,
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.pan_tool),
                label: const Text('Take Over Call (Manual)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isAI;

  const ChatBubble({super.key, required this.text, required this.isAI});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: isAI ? Colors.orange.shade50 : Colors.blue.shade50,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isAI ? Radius.zero : const Radius.circular(12),
            bottomRight: isAI ? const Radius.circular(12) : Radius.zero,
          ),
          border: Border.all(
            color: isAI ? Colors.orange.shade200 : Colors.blue.shade200,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isAI ? '🤖 AI Agent' : '👤 Customer',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: isAI ? Colors.orange.shade800 : Colors.blue.shade800,
              ),
            ),
            const SizedBox(height: 4),
            Text(text),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// ORDERS & BILLING PAGE
// ---------------------------------------------------------
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 800
          ? AppBar(title: const Text('Recent Orders & Bills', style: TextStyle(fontWeight: FontWeight.bold)))
          : null,
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.receipt, color: Colors.white),
              ),
              title: Text('Order #${1024 - index} (Auto-generated by AI)'),
              subtitle: Text('Items: ${index + 2} • 0300-987654$index'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('Rs. ${1200 + (index * 250)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const Text('Pending', style: TextStyle(color: Colors.orange, fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------
// AI SETTINGS PAGE
// ---------------------------------------------------------
class AiSettingsPage extends StatelessWidget {
  const AiSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MediaQuery.of(context).size.width > 800
          ? AppBar(title: const Text('AI Agent Configuration', style: TextStyle(fontWeight: FontWeight.bold)))
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AI Agent Setup Instructions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yahan aap apne AI Waiter ki personality, menu, aur awaz (voice) set kar sakte hain.',
            ),
            const SizedBox(height: 24),
            TextFormField(
              initialValue: "Aap ek professional aur polite restaurant waiter hain. Aapka naam 'Ali' hai. Aap call receive karenge, customer se Urdu aur English mix mein baat karenge, order lenge, aur menu ke hisab se total bill bata kar order confirm karenge.",
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'System Prompt (AI Prompt)',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: "1. Zinger Burger - Rs 600\n2. Regular Fries - Rs 200\n3. Pepsi Can - Rs 100\n4. Chicken Tikka Pizza - Rs 1200",
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Restaurant Menu (Pricing)',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save Configuration'),
            ),
          ],
        ),
      ),
    );
  }
}
