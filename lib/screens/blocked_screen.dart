import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/buttons.dart';
import '../providers/app_providers.dart';

class BlockedScreen extends ConsumerWidget {
  const BlockedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goalsAsync = ref.watch(goalsProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFDF5), Color(0xFFFBF6E9)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                _buildLockIcon(),
                const SizedBox(height: 24),
                Text(
                  'This site is locked.',
                  style: AppTheme.textTheme.displayLarge?.copyWith(fontSize: 36),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'You chose to focus on your goals. Are you sure you want to deviate now?',
                  style: AppTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.muted),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                _buildGoalsReminder(goalsAsync),
                const Spacer(),
                PrimaryButton(
                  text: 'GO BACK TO FOCUS',
                  onPressed: () {
                    // Navigate back or to a safe page
                  },
                ),
                const SizedBox(height: 16),
                SecondaryButton(
                  text: 'EMERGENCY UNLOCK (1 MIN)',
                  onPressed: () => _showEmergencyUnlockDialog(context),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLockIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: AppTheme.emerald.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Icon(
          Icons.lock_person_rounded,
          size: 40,
          color: AppTheme.emerald,
        ),
      ),
    );
  }

  Widget _buildGoalsReminder(AsyncValue<List<dynamic>> goalsAsync) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REMEMBER YOUR GOALS',
            style: AppTheme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 16),
          goalsAsync.when(
            data: (goals) {
              final pendingGoals = goals.where((g) => !g.isCompleted).take(3).toList();
              if (pendingGoals.isEmpty) {
                return const Text('All goals completed! You earned a break.');
              }
              return Column(
                children: pendingGoals.map((goal) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.circle, size: 8, color: AppTheme.emerald),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          goal.title,
                          style: AppTheme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              );
            },
            loading: () => const SizedBox(height: 50, child: Center(child: CircularProgressIndicator())),
            error: (_, __) => const Text('Error loading goals'),
          ),
        ],
      ),
    );
  }

  void _showEmergencyUnlockDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppTheme.paper,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.muted.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Are you sure?',
              style: AppTheme.textTheme.displayMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'Emergency unlock will only last for 1 minute. Use it wisely.',
              style: AppTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.muted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            DangerButton(
              text: 'YES, UNLOCK FOR 1 MIN',
              onPressed: () {
                Navigator.pop(context);
                // Trigger unlock logic
              },
            ),
            const SizedBox(height: 12),
            SecondaryButton(
              text: 'NEVERMIND, KEEP ME LOCKED',
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
