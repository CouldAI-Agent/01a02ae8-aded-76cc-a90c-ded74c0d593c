import 'package:flutter/material.dart';

void main() {
  runApp(const DealkrApp());
}

class DealkrApp extends StatelessWidget {
  const DealkrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DEALKR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/customer': (context) => const CustomerDashboard(),
        '/vendor': (context) => const VendorDashboard(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // Logic to check session and role goes here.
      // For now, redirect to login.
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'DEALKR',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple),
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Mock login function that simulates backend authentication and role retrieval
  void _login(BuildContext context, String mockRole) {
    // In production, this would be an API call verifying OTP and returning user profile with role.
    if (mockRole == 'CUSTOMER') {
      Navigator.pushReplacementNamed(context, '/customer');
    } else if (mockRole == 'VENDOR') {
      Navigator.pushReplacementNamed(context, '/vendor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login to DEALKR')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Backend Authentication Simulation'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _login(context, 'CUSTOMER'),
              child: const Text('Simulate Customer Login'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _login(context, 'VENDOR'),
              child: const Text('Simulate Vendor Login'),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= CUSTOMER EXPERIENCE =================

class CustomerDashboard extends StatefulWidget {
  const CustomerDashboard({super.key});

  @override
  State<CustomerDashboard> createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('HOME')),
    const Center(child: Text('CATEGORIES')),
    const Center(child: Text('AUCTION')),
    const Center(child: Text('CART')),
    const Center(child: Text('MENU (Orders inside)')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEALKR - Customer'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'CATEGORIES'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'AUCTION'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'CART'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'MENU'),
        ],
      ),
    );
  }
}

// ================= VENDOR EXPERIENCE =================

class VendorDashboard extends StatefulWidget {
  const VendorDashboard({super.key});

  @override
  State<VendorDashboard> createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Center(child: Text('Vendor Dashboard (Metrics)')),
    const Center(child: Text('Products Management')),
    const Center(child: Text('Orders Management')),
    const Center(child: Text('Auctions Management')),
    const Center(child: Text('Wallet')),
    const Center(child: Text('Menu')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEALKR - Vendor Portal'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.gavel), label: 'Auctions'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}
