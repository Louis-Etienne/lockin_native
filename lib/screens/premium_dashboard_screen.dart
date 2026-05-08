import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme.dart';
import '../widgets/glass_card.dart';
import '../providers/app_providers.dart';

class PremiumDashboardScreen extends ConsumerWidget {
  const PremiumDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statsProvider);

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
                _buildHeader(context),
                const SizedBox(height: 32),
                _buildHeroSection(),
                const SizedBox(height: 32),
                _buildStatsGrid(stats),
                const SizedBox(height: 32),
                _buildProgressSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: AppTheme.pine),
          onPressed: () {
            // Navigation handled in main.dart
          },
        ),
        const SizedBox(width: 8),
        Text(
          'DASHBOARD',
          style: AppTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'You are building a calmer day.',
          style: AppTheme.textTheme.displayLarge?.copyWith(fontSize: 32),
        ),
        const SizedBox(height: 12),
        Text(
          'Your focus metrics show significant improvement this week. Keep going.',
          style: AppTheme.textTheme.bodyLarge?.copyWith(color: AppTheme.muted),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(Map<String, String> stats) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.4,
      children: [
        _buildStatCard('Focus streak', stats['streak']!, Icons.local_fire_department),
        _buildStatCard('Focus time', stats['focus_time']!, Icons.timer),
        _buildStatCard('Goals completed', stats['goals_completed']!, Icons.check_circle),
        _buildStatCard('Time protected', stats['time_protected']!, Icons.shield),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 24,
      isFlameCard: label == 'Focus streak',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: AppTheme.emerald, size: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppTheme.textTheme.headlineLarge,
              ),
              Text(
                label,
                style: AppTheme.textTheme.bodySmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'WORK GOAL PROGRESS',
              style: AppTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: 1.2,
              ),
            ),
            Text(
              '75%',
              style: AppTheme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppTheme.emerald,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          height: 12,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(6),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.75,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppTheme.primaryButtonGradient,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
