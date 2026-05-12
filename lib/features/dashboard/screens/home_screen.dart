import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good morning 👋',
                        style: TextStyle(fontSize: 14, color: AppColors.textGray),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Welcome back!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.notifications),
                    child: Stack(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Icon(Icons.notifications_outlined, color: AppColors.textDark),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.error,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Balance card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Savings',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      Formatters.formatBirr(24500),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _BalanceStat(label: 'Active Groups', value: '3'),
                        const SizedBox(width: 24),
                        _BalanceStat(label: 'Next Payout', value: 'Jun 15'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick actions
              const Text(
                'Quick Actions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _QuickAction(
                    icon: Icons.add_circle_outline,
                    label: 'Create Group',
                    color: AppColors.primary,
                    onTap: () => context.go(AppRoutes.createGroup),
                  ),
                  const SizedBox(width: 12),
                  _QuickAction(
                    icon: Icons.group_add_outlined,
                    label: 'Join Group',
                    color: AppColors.secondary,
                    onTap: () => context.go(AppRoutes.joinGroup),
                  ),
                  const SizedBox(width: 12),
                  _QuickAction(
                    icon: Icons.payments_outlined,
                    label: 'Pay Now',
                    color: const Color(0xFF7C3AED),
                    onTap: () => context.go(AppRoutes.contributions),
                  ),
                  const SizedBox(width: 12),
                  _QuickAction(
                    icon: Icons.bar_chart_outlined,
                    label: 'Reports',
                    color: AppColors.warning,
                    onTap: () => context.go(AppRoutes.reports),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Active groups
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Groups',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark),
                  ),
                  TextButton(
                    onPressed: () => context.go(AppRoutes.groups),
                    child: const Text('See all'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _GroupCard(
                name: 'Family Savings',
                amount: 5000,
                members: 8,
                nextDue: 'Jun 10',
                status: 'active',
              ),
              const SizedBox(height: 12),
              _GroupCard(
                name: 'Office Equb',
                amount: 2000,
                members: 12,
                nextDue: 'Jun 15',
                status: 'active',
              ),
              const SizedBox(height: 24),

              // Upcoming payments
              const Text(
                'Upcoming Payments',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textDark),
              ),
              const SizedBox(height: 12),
              _PaymentItem(group: 'Family Savings', amount: 5000, dueDate: 'Jun 10', status: 'pending'),
              const SizedBox(height: 8),
              _PaymentItem(group: 'Office Equb', amount: 2000, dueDate: 'Jun 15', status: 'pending'),
            ],
          ),
        ),
      ),
    );
  }
}

class _BalanceStat extends StatelessWidget {
  final String label;
  final String value;
  const _BalanceStat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white60, fontSize: 12)),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
      ],
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final String name;
  final double amount;
  final int members;
  final String nextDue;
  final String status;
  const _GroupCard({
    required this.name,
    required this.amount,
    required this.members,
    required this.nextDue,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.group, color: AppColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 4),
                Text(
                  '${Formatters.formatBirr(amount)} · $members members',
                  style: const TextStyle(fontSize: 13, color: AppColors.textGray),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('Active', style: TextStyle(fontSize: 11, color: AppColors.secondary, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 4),
              Text('Due $nextDue', style: const TextStyle(fontSize: 12, color: AppColors.textGray)),
            ],
          ),
        ],
      ),
    );
  }
}

class _PaymentItem extends StatelessWidget {
  final String group;
  final double amount;
  final String dueDate;
  final String status;
  const _PaymentItem({required this.group, required this.amount, required this.dueDate, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.schedule, color: AppColors.warning, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(group, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark)),
                Text('Due $dueDate', style: const TextStyle(fontSize: 12, color: AppColors.textGray)),
              ],
            ),
          ),
          Text(
            Formatters.formatBirr(amount),
            style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }
}
