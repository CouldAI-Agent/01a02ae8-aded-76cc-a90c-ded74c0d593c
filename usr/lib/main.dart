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
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/customer': (context) => const CustomerApp(),
        '/vendor': (context) => const VendorApp(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// MOCK AUTH SERVICE
// ==========================================

enum UserRole { customer, vendor }

class MockAuth {
  static UserRole? currentUserRole;
  
  static Future<UserRole> login(String username, String password) async {
    // In production, this would securely authenticate with the backend
    // and return the user's role. Never rely solely on frontend data.
    await Future.delayed(const Duration(seconds: 1));
    if (username.toLowerCase() == 'vendor') {
      currentUserRole = UserRole.vendor;
      return UserRole.vendor;
    }
    currentUserRole = UserRole.customer;
    return UserRole.customer;
  }
  
  static void logout() {
    currentUserRole = null;
  }
}

// ==========================================
// SCREENS
// ==========================================

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    
    if (MockAuth.currentUserRole == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _navigateToRole(MockAuth.currentUserRole!);
    }
  }
  
  void _navigateToRole(UserRole role) {
    if (role == UserRole.customer) {
      Navigator.pushReplacementNamed(context, '/customer');
    } else if (role == UserRole.vendor) {
      Navigator.pushReplacementNamed(context, '/vendor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Text(
          'DEALKR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    try {
      final role = await MockAuth.login(
        _usernameController.text, 
        _passwordController.text
      );
      if (!mounted) return;
      if (role == UserRole.customer) {
        Navigator.pushReplacementNamed(context, '/customer');
      } else {
        Navigator.pushReplacementNamed(context, '/vendor');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DEALKR Authentication')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'DEALKR',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Sign in to continue. Use "vendor" to see vendor UI.'),
                const SizedBox(height: 32),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username or Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading 
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('LOGIN'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// CUSTOMER EXPERIENCE
// ==========================================

class CustomerApp extends StatefulWidget {
  const CustomerApp({super.key});

  @override
  State<CustomerApp> createState() => _CustomerAppState();
}

class _CustomerAppState extends State<CustomerApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    Center(child: Text('HOME')),
    Center(child: Text('CATEGORIES')),
    Center(child: Text('AUCTION')),
    Center(child: Text('CART')),
    CustomerMenu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEALKR', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'HOME'),
          NavigationDestination(icon: Icon(Icons.category), label: 'CATEGORIES'),
          NavigationDestination(icon: Icon(Icons.gavel), label: 'AUCTION'),
          NavigationDestination(icon: Icon(Icons.shopping_cart), label: 'CART'),
          NavigationDestination(icon: Icon(Icons.menu), label: 'MENU'),
        ],
      ),
    );
  }
}

class CustomerMenu extends StatelessWidget {
  const CustomerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('My Profile'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text('MY ORDERS'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Wishlist'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            MockAuth.logout();
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }
}

// ==========================================
// VENDOR EXPERIENCE
// ==========================================

class VendorApp extends StatefulWidget {
  const VendorApp({super.key});

  @override
  State<VendorApp> createState() => _VendorAppState();
}

class _VendorAppState extends State<VendorApp> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    VendorDashboard(),
    Center(child: Text('PRODUCTS')),
    Center(child: Text('ORDERS')),
    Center(child: Text('AUCTIONS')),
    Center(child: Text('WALLET')),
    VendorMenu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DEALKR Vendor', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.inventory), label: 'Products'),
          NavigationDestination(icon: Icon(Icons.receipt), label: 'Orders'),
          NavigationDestination(icon: Icon(Icons.gavel), label: 'Auctions'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
          NavigationDestination(icon: Icon(Icons.menu), label: 'Menu'),
        ],
      ),
    );
  }
}

class VendorDashboard extends StatelessWidget {
  const VendorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Overview',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
            return GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildStatCard('Today\\'s Sales', '₹12,400'),
                _buildStatCard('Pending Orders', '5'),
                _buildStatCard('Products', '42'),
                _buildStatCard('Wallet Balance', '₹4,000'),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class VendorMenu extends StatelessWidget {
  const VendorMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.business),
          title: const Text('Vendor Profile / KYC'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.campaign),
          title: const Text('Campaigns'),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () {
            MockAuth.logout();
            Navigator.pushReplacementNamed(context, '/login');
          },
        ),
      ],
    );
  }
}
