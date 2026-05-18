import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/buttons.dart';
import '../providers/app_providers.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool _isLoading = false;

  Future<void> _handleSignIn() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authStateProvider.notifier).signIn('test@example.com', 'password');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.popupBackground,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                _buildBranding(),
                const SizedBox(height: 48),
                _buildLockCard(),
                const Spacer(),
                _buildActionButtons(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBranding() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppTheme.emerald,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppTheme.emerald.withValues(alpha: 0.3),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: const Icon(Icons.lock, color: AppTheme.cream, size: 40),
        ),
        const SizedBox(height: 24),
        Text(
          'LockIn',
          style: AppTheme.textTheme.displayLarge,
        ),
        const SizedBox(height: 8),
        Text(
          'Your focus starts here.',
          style: AppTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.muted),
        ),
      ],
    );
  }

  Widget _buildLockCard() {
    return GlassCard(
      padding: const EdgeInsets.all(32),
      borderRadius: 32,
      child: Column(
        children: [
          Text(
            'Secure Connection Required',
            style: AppTheme.textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Text(
            'Connect your account to sync goals across devices and track your progress.',
            style: AppTheme.textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (_isLoading)
          const CircularProgressIndicator(color: AppTheme.emerald)
        else ...[
          PrimaryButton(
            text: 'CONNECT TO FOCUS',
            onPressed: _handleSignIn,
          ),
          const SizedBox(height: 16),
          SecondaryButton(
            text: 'CREATE NEW ACCOUNT',
            onPressed: () {
              // Mock sign up
            },
          ),
          const SizedBox(height: 24),
          Text(
            'By continuing, you agree to our Terms of Service.',
            style: AppTheme.textTheme.bodySmall?.copyWith(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
