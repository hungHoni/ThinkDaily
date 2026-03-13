import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Schedule the load after the first frame so the provider is available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<UserProvider>().loadUser();
    });
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.pushNamed(context, '/profile');
  }

  @override
  Widget build(BuildContext context) {
    final userState = context.watch<UserProvider>().state;

    return Scaffold(
      body: SafeArea(
        child: _buildBody(context, userState),
      ),
    );
  }

  Widget _buildBody(BuildContext context, UserState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.hasError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.errorMessage ?? 'Something went wrong.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.read<UserProvider>().loadUser(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return Center(
      child: InkWell(
        onTap: () => _navigateToProfile(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            state.userName ?? 'Guest',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
