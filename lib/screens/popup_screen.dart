import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../widgets/glass_card.dart';
import '../widgets/custom_switch.dart';
import '../widgets/buttons.dart';
import '../providers/app_providers.dart';
import '../models/goal.dart';

class PopupScreen extends ConsumerWidget {
  const PopupScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFocusMode = ref.watch(focusModeProvider);
    final goalsAsync = ref.watch(goalsProvider);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppTheme.popupBackground,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 24),
                _buildFocusModeCard(isFocusMode, ref),
                const SizedBox(height: 24),
                _buildGoalsSection(goalsAsync, ref),
                const SizedBox(height: 24),
                _buildAllowedWebsitesSection(),
                const SizedBox(height: 32),
                PremiumButton(
                  text: 'UNLOCK PREMIUM DASHBOARD',
                  onPressed: () {
                    // Navigation will be implemented in main.dart
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppTheme.emerald,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.lock, color: AppTheme.cream, size: 18),
            ),
            const SizedBox(width: 12),
            Text(
              'LockIn',
              style: AppTheme.textTheme.displayMedium,
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: AppTheme.pine),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildFocusModeCard(bool isFocusMode, WidgetRef ref) {
    return GlassCard(
      isModeCard: isFocusMode,
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Focus Mode',
                style: AppTheme.textTheme.headlineLarge?.copyWith(
                  color: isFocusMode ? Colors.white : AppTheme.pine,
                ),
              ),
              Text(
                isFocusMode ? 'Focus is active' : 'Ready to lock in?',
                style: AppTheme.textTheme.bodySmall?.copyWith(
                  color: isFocusMode ? Colors.white.withValues(alpha: 0.7) : AppTheme.muted,
                ),
              ),
            ],
          ),
          CustomSwitch(
            value: isFocusMode,
            onChanged: (val) {
              ref.read(focusModeProvider.notifier).value = val;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGoalsSection(AsyncValue<List<Goal>> goalsAsync, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "TODAY'S GOALS",
          style: AppTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        goalsAsync.when(
          data: (goals) => Column(
            children: [
              ...goals.map((goal) => _buildGoalItem(goal, ref)),
              const SizedBox(height: 12),
              _buildAddGoalInput(ref),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err'),
        ),
      ],
    );
  }

  Widget _buildGoalItem(Goal goal, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        borderRadius: 16,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => ref.read(goalsProvider.notifier).toggleGoal(goal.id),
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: goal.isCompleted ? AppTheme.emerald : AppTheme.forest.withValues(alpha: 0.2),
                    width: 2,
                  ),
                  color: goal.isCompleted ? AppTheme.emerald : Colors.transparent,
                ),
                child: goal.isCompleted
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                goal.title,
                style: AppTheme.textTheme.bodyMedium?.copyWith(
                  decoration: goal.isCompleted ? TextDecoration.lineThrough : null,
                  color: goal.isCompleted ? AppTheme.muted : AppTheme.pine,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, size: 18, color: AppTheme.muted),
              onPressed: () => ref.read(goalsProvider.notifier).deleteGoal(goal.id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddGoalInput(WidgetRef ref) {
    final controller = TextEditingController();
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      borderRadius: 16,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Add a new goal...',
          hintStyle: AppTheme.textTheme.bodyMedium?.copyWith(color: AppTheme.muted),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(Icons.add_circle, color: AppTheme.emerald),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(goalsProvider.notifier).addGoal(controller.text);
                controller.clear();
              }
            },
          ),
        ),
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            ref.read(goalsProvider.notifier).addGoal(value);
            controller.clear();
          }
        },
      ),
    );
  }

  Widget _buildAllowedWebsitesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ALLOWED WEBSITES",
          style: AppTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 12),
        GlassCard(
          padding: const EdgeInsets.all(16),
          borderRadius: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter URLs one per line...',
                style: AppTheme.textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: const TextField(
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: TextStyle(fontSize: 13, color: AppTheme.pine),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
