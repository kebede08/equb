import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/status_badge.dart';
import '../../../routes/app_routes.dart';

class GroupDetailScreen extends StatefulWidget {
  final String groupId;
  const GroupDetailScreen({super.key, required this.groupId});

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Family Savings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _StatPill(label: '8/10 Members'),
                            const SizedBox(width: 8),
                            _StatPill(label: '10 Months'),
                            const SizedBox(width: 8),
                            _StatPill(label: 'Active'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.textGray,
              indicatorColor: AppColors.primary,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Members'),
                Tab(text: 'Contributions'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _OverviewTab(),
            _MembersTab(),
            _ContributionsTab(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.go('${AppRoutes.contributions}/pay/new'),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.payments, color: Colors.white),
        label: const Text('Pay Contribution', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _StatPill extends StatelessWidget {
  final String label;
  const _StatPill({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
    );
  }
}

class _OverviewTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Stats row
          Row(
            children: [
              Expanded(child: _StatCard(label: 'Total Pool', value: Formatters.formatBirr(40000), icon: Icons.account_balance_wallet, color: AppColors.primary)),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(label: 'Collected', value: Formatters.formatBirr(32000), icon: Icons.check_circle_outline, color: AppColors.secondary)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _StatCard(label: 'Pending', value: Formatters.formatBirr(8000), icon: Icons.schedule, color: AppColors.warning)),
              const SizedBox(width: 12),
              Expanded(child: _StatCard(label: 'Cycle', value: '4 / 10', icon: Icons.loop, color: AppColors.info)),
            ],
          ),
          const SizedBox(height: 20),

          // Progress
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cycle Progress', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor: AppColors.border,
                    valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    minHeight: 12,
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Cycle 4 of 10', style: TextStyle(fontSize: 12, color: AppColors.textGray)),
                    Text('40% Complete', style: TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Next payout
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.emoji_events, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Next Payout', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                      Text('Abebe Kebede — June 15, 2025', style: TextStyle(fontSize: 13, color: AppColors.textGray)),
                    ],
                  ),
                ),
                Text(
                  Formatters.formatBirr(40000),
                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.secondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  const _StatCard({required this.label, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: color)),
          Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textGray)),
        ],
      ),
    );
  }
}

class _MembersTab extends StatelessWidget {
  final List<Map<String, dynamic>> _members = const [
    {'name': 'Abebe Kebede', 'phone': '+251911234567', 'position': 1, 'status': 'active', 'role': 'admin'},
    {'name': 'Tigist Alemu', 'phone': '+251922345678', 'position': 2, 'status': 'active', 'role': 'member'},
    {'name': 'Dawit Haile', 'phone': '+251933456789', 'position': 3, 'status': 'active', 'role': 'member'},
    {'name': 'Meron Tadesse', 'phone': '+251944567890', 'position': 4, 'status': 'active', 'role': 'member'},
    {'name': 'Yonas Girma', 'phone': '+251955678901', 'position': 5, 'status': 'active', 'role': 'member'},
    {'name': 'Hana Bekele', 'phone': '+251966789012', 'position': 6, 'status': 'active', 'role': 'member'},
    {'name': 'Samuel Tesfaye', 'phone': '+251977890123', 'position': 7, 'status': 'active', 'role': 'member'},
    {'name': 'Liya Worku', 'phone': '+251988901234', 'position': 8, 'status': 'active', 'role': 'member'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _members.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final m = _members[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryLight,
                child: Text(
                  (m['name'] as String)[0],
                  style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(m['name'] as String, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                        if (m['role'] == 'admin') ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text('Admin', style: TextStyle(fontSize: 10, color: AppColors.primary, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ],
                    ),
                    Text(m['phone'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textGray)),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '#${m['position']}',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ContributionsTab extends StatelessWidget {
  final List<Map<String, dynamic>> _contributions = const [
    {'member': 'Abebe Kebede', 'amount': 5000.0, 'date': 'Jun 1, 2025', 'status': 'paid'},
    {'member': 'Tigist Alemu', 'amount': 5000.0, 'date': 'Jun 2, 2025', 'status': 'paid'},
    {'member': 'Dawit Haile', 'amount': 5000.0, 'date': 'Jun 3, 2025', 'status': 'paid'},
    {'member': 'Meron Tadesse', 'amount': 5000.0, 'date': 'Jun 5, 2025', 'status': 'pending'},
    {'member': 'Yonas Girma', 'amount': 5000.0, 'date': 'Jun 5, 2025', 'status': 'late'},
    {'member': 'Hana Bekele', 'amount': 5000.0, 'date': 'Jun 5, 2025', 'status': 'pending'},
    {'member': 'Samuel Tesfaye', 'amount': 5000.0, 'date': 'Jun 5, 2025', 'status': 'pending'},
    {'member': 'Liya Worku', 'amount': 5000.0, 'date': 'Jun 5, 2025', 'status': 'pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _contributions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final c = _contributions[index];
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: AppColors.surfaceVariant,
                child: Text(
                  (c['member'] as String)[0],
                  style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textDark),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(c['member'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.textDark)),
                    Text(c['date'] as String, style: const TextStyle(fontSize: 12, color: AppColors.textGray)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    Formatters.formatBirr(c['amount'] as double),
                    style: const TextStyle(fontWeight: FontWeight.w700, color: AppColors.textDark),
                  ),
                  const SizedBox(height: 4),
                  StatusBadge(status: c['status'] as String),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
