import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../../../data/models/user_model.dart';
import '../widgets/add_reward_modal.dart';
import '../widgets/savings_history_modal.dart';
import '../../../core/utils/currency_formatter.dart';

class MoneyTrackerScreen extends ConsumerWidget {
  const MoneyTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: userAsync.when(
        data: (user) {
          if (user == null) {
            return const Center(
              child: Text(
                'Data tidak ditemukan',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return _TrackerContent(user: user);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (error, stack) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _TrackerContent extends ConsumerWidget {
  final UserModel user;

  const _TrackerContent({required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120.0), // Padding for bottom nav
            child: Column(
              children: [
                _buildCumulativeSavings(context, ref, user),
                _buildSavingsGrowth(ref, user),
                _buildBuyThisInstead(context, ref, user),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.backgroundDark.withOpacity(0.8),
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.primary.withOpacity(0.1),
          height: 1.0,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: AppColors.primary, size: 20),
        ),
      ),
      title: const Text(
        'Money Tracker',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.settings, color: AppColors.primary, size: 20),
              onPressed: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCumulativeSavings(BuildContext context, WidgetRef ref, UserModel user) {
    final moneySaved = ref.watch(moneySavedProvider);
    final formatter = CurrencyFormatter.getFormatter(user.currency);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary.withOpacity(0.2),
              Colors.transparent,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'CUMULATIVE SAVINGS',
                  style: TextStyle(
                    color: AppColors.slate400,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const SavingsHistoryModal(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.history,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    formatter.format(moneySaved),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  user.currency,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.trending_up, color: AppColors.primary, size: 16),
                const SizedBox(width: 8),
                Text(
                  '+15% vs last month',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSavingsGrowth(WidgetRef ref, UserModel user) {
    final moneySaved = ref.watch(moneySavedProvider);
    return SavingsGrowthChartSection(
      user: user,
      currentMoneySaved: moneySaved,
    );
  }

  Widget _buildBuyThisInstead(BuildContext context, WidgetRef ref, UserModel user) {
    final moneySaved = ref.watch(moneySavedProvider);
    final targets = user.savingsTargets;
    final legacyTarget = user.savingsTarget; // For users who haven't added a new target yet
    final formatter = CurrencyFormatter.getFormatter(user.currency);
    
    // Combine newest list targets and fallback legacy target to display
    final allTargets = <SavingsTarget>[...targets];
    if (targets.isEmpty && legacyTarget != null && legacyTarget.itemName.isNotEmpty && legacyTarget.targetPrice > 0) {
      allTargets.add(legacyTarget);
    }
    
    final hasTargets = allTargets.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Buy This Instead',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Icon(Icons.celebration, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 16),
          if (hasTargets) ...[
            ...allTargets.asMap().entries.map((entry) {
              final index = entry.key;
              final target = entry.value;

              int progress = ((moneySaved / target.targetPrice) * 100).floor();
              if (progress > 100) progress = 100;
              
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _TargetCard(
                  title: target.itemName,
                  price: formatter.format(target.targetPrice),
                  icon: Icons.star_rounded,
                  progress: progress,
                  onEdit: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: AddRewardModal(
                          index: index,
                          initialName: target.itemName,
                          initialPrice: target.targetPrice,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ] else ...[
             Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.slate900.withOpacity(0.4),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.slate800, style: BorderStyle.solid),
              ),
              child: const Column(
                children: [
                  Icon(Icons.lightbulb_outline, color: AppColors.slate400, size: 32),
                  SizedBox(height: 12),
                  Text(
                    'No Reward Goals Yet',
                    style: TextStyle(
                      color: AppColors.slate200,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Add a target like a new phone or vacation to stay motivated.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.slate400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                side: BorderSide(
                  color: AppColors.primary.withOpacity(0.3),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: const AddRewardModal(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_circle, color: AppColors.primary.withOpacity(0.6)),
                  const SizedBox(width: 8),
                  Text(
                    'Add New Reward Goal',
                    style: TextStyle(
                      color: AppColors.primary.withOpacity(0.6),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  final String title;
  final String price;
  final IconData icon;
  final int progress;
  final VoidCallback onEdit;

  const _TargetCard({
    required this.title,
    required this.price,
    required this.icon,
    required this.progress,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.slate900.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.backgroundDark),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: AppColors.primary, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.slate100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        price,
                        style: const TextStyle(
                          color: AppColors.slate400,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '$progress% Saved',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: onEdit,
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.more_vert, color: AppColors.slate400, size: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 8,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.slate500.withOpacity(0.3),
              borderRadius: BorderRadius.circular(999),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: progress / 100,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(999),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.6),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum TimeFilter {
  oneDay(1, '1 Hari'),
  sevenDays(7, '7 Hari'),
  oneMonth(30, '1 Bulan'),
  threeMonths(90, '3 Bulan'),
  oneYear(365, '1 Tahun'),
  all(9999, 'All');

  final int days;
  final String label;

  const TimeFilter(this.days, this.label);
}

class SavingsGrowthChartSection extends ConsumerStatefulWidget {
  final UserModel user;
  final double currentMoneySaved;

  const SavingsGrowthChartSection({
    super.key,
    required this.user,
    required this.currentMoneySaved,
  });

  @override
  ConsumerState<SavingsGrowthChartSection> createState() => _SavingsGrowthChartSectionState();
}

class _SavingsGrowthChartSectionState extends ConsumerState<SavingsGrowthChartSection> {
  TimeFilter _selectedFilter = TimeFilter.oneMonth; // default to 1 Bulan mapped loosely

  @override
  void initState() {
    super.initState();
    _selectedFilter = TimeFilter.oneMonth;
  }

  @override
  Widget build(BuildContext context) {
    final formatter = CurrencyFormatter.getFormatter(widget.user.currency);
    final goal = widget.user.savingsTarget?.targetPrice ?? (widget.user.savingsTargets.isNotEmpty ? widget.user.savingsTargets.first.targetPrice : 2000000.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Savings Growth',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<TimeFilter>(
                  value: _selectedFilter,
                  dropdownColor: AppColors.slate900,
                  icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.slate400, size: 16),
                  style: const TextStyle(
                    color: AppColors.slate400,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (TimeFilter? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedFilter = newValue;
                      });
                    }
                  },
                  items: TimeFilter.values.map<DropdownMenuItem<TimeFilter>>((TimeFilter value) {
                    return DropdownMenuItem<TimeFilter>(
                      value: value,
                      child: Text(value.label),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.slate900.withOpacity(0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.backgroundDark),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      formatter.format(widget.currentMoneySaved),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Goal: ${formatter.format(goal)}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: _buildChart(goal),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(double goal) {
    if (widget.user.quitDate == null || widget.user.smokingProfile == null) {
      return const Center(child: Text('Not enough data', style: TextStyle(color: AppColors.slate400)));
    }

    final history = ref.watch(dailySavingsHistoryProvider);
    if (history.isEmpty) {
      return const Center(child: Text('No history found', style: TextStyle(color: AppColors.slate400)));
    }

    List<FlSpot> spots = [];
    List<String> xLabels = [];

    int daysToLookBack = _selectedFilter.days;
    // Safety check, don't look back further than we have data
    if (daysToLookBack > history.length) {
      daysToLookBack = history.length;
    }

    // Get the sublist of the history based on the lookback window
    final windowData = history.sublist(history.length - daysToLookBack);

    double currentCumSum = 0;
    
    for (int i = 0; i < windowData.length; i++) {
      final entry = windowData[i];
      currentCumSum = entry.cumulativeTotal;
      spots.add(FlSpot(i.toDouble(), currentCumSum));

      // Build labels
      if (i == 0) {
        xLabels.add("${entry.date.day}/${entry.date.month}");
      } else if (i == windowData.length - 1) {
        xLabels.add('Hari ini'); // Today
      } else if (windowData.length > 7 && i % (windowData.length ~/ 4) == 0) {
        xLabels.add("${entry.date.day}/${entry.date.month}");
      } else {
         xLabels.add('');
      }
    }

    // Edge case empty fallback
    if (spots.isEmpty) {
       spots.add(const FlSpot(0, 0));
       xLabels.add('Hari ini');
    }

    // maxY dynamically maps to goal or current total, whichever is larger
    double maxY = goal;
    if (currentCumSum > maxY) maxY = currentCumSum * 1.2;
    if (maxY == 0) maxY = 10000;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: maxY / 4,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: AppColors.slate800,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: 1,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= xLabels.length) return const SizedBox();
                final text = xLabels[index];
                if (text.isEmpty) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: AppColors.slate500,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: (spots.length - 1).toDouble(),
        minY: 0,
        maxY: maxY,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: false, // Make it jagged to show slips clearly
            color: AppColors.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
               show: true,
               getDotPainter: (spot, percent, barData, index) {
                 return FlDotCirclePainter(
                   radius: 4,
                   color: AppColors.backgroundDark,
                   strokeWidth: 2,
                   strokeColor: AppColors.primary,
                 );
               },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primary.withAlpha(80),
                  AppColors.primary.withAlpha(0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
