import 'package:auto_mate/core/providers/auth_provider.dart';
import 'package:auto_mate/features/Service/book_service_screen.dart';
import 'package:auto_mate/features/Service/service_history_screen.dart';
import 'package:auto_mate/features/vehicle/my_vehicles_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    final List<_HomeItem> items = [
      _HomeItem("My Vehicles", Icons.directions_car, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const MyVehiclesScreen()),
        );
      }),
      _HomeItem("Book Service", Icons.build_circle, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const BookServiceScreen()),
        );
      }),
      _HomeItem("Service History", Icons.history, () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const ServiceHistoryScreen()),
        );
      }),
      _HomeItem("Contact Support", Icons.support_agent, () {
        
      }),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              auth.logout();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(auth),
            const SizedBox(height: 24),
            const Text(
              "Quick Actions",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: item.onTap,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 6,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(item.icon, size: 36, color: Colors.blueAccent),
                          const SizedBox(height: 12),
                          Text(
                            item.label,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(AuthProvider auth) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 28,
            backgroundColor: Colors.blue,
            child: Icon(Icons.person, size: 32, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              'Hi  ${auth.name ?? "User"} 👋',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeItem {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  _HomeItem(this.label, this.icon, this.onTap);
}
