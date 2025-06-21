import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/get_user_model.dart';
import '../../cubit/user_cubit.dart';
import '../../cubit/user_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, UserState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit profile coming soon')),
                  );
                },
              ),
            ],
          ),
          body: _buildBody(state),
        );
      },
    );
  }

  Widget _buildBody(UserState state) {
    if (state is GetprofileLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is GetProfilesuccess) {
      return _buildProfile(state.user);
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No profile data available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildProfile(GetUserModel user) {
    return RefreshIndicator(
      onRefresh: () async {
        // TODO: Implement profile refresh logic
        await Future.delayed(const Duration(seconds: 2));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header Section
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(
                        Icons.person,
                        size: 70,
                        color: Colors.blue,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                          onPressed: () {
                            // TODO: Implement profile picture change
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '${user.nom} ${user.prenom}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // User Information Section
          _buildInfoCard(
            icon: Icons.person_outline,
            title: 'Full Name',
            subtitle: '${user.nom} ${user.prenom}',
          ),
          _buildInfoCard(
            icon: Icons.numbers,
            title: 'User ID',
            subtitle: '#${user.id}',
          ),
          _buildInfoCard(
            icon: Icons.numbers,
            title: 'Matricule',
            subtitle: user.matricule,
          ),
          _buildInfoCard(
            icon: Icons.phone,
            title: 'Phone',
            subtitle: user.phone,
          ),
          _buildInfoCard(
            icon: Icons.verified_user,
            title: 'Account Status',
            subtitle: user.isActive ? 'Active' : 'Inactive',
            subtitleColor: user.isActive ? Colors.green : Colors.red,
          ),

          // Additional Action Buttons
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // TODO: Implement logout functionality
            },
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to create consistent info cards
  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
    Color? subtitleColor,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 30),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: subtitleColor ?? Colors.black87,
          ),
        ),
      ),
    );
  }
}
