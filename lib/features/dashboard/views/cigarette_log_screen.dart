import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../../../data/models/user_model.dart';
import 'dart:math';

class CigaretteLogScreen extends ConsumerWidget {
  const CigaretteLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: userAsync.when(
        data: (user) {
          if (user == null || user.quitDate == null || user.smokingProfile == null) {
            return const Center(
              child: Text(
                'Data tidak ditemukan',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return _CigaretteLogContent(user: user);
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

class _CigaretteLogContent extends ConsumerStatefulWidget {
  final UserModel user;

  const _CigaretteLogContent({required this.user});

  @override
  ConsumerState<_CigaretteLogContent> createState() => _CigaretteLogContentState();
}

class _CigaretteLogContentState extends ConsumerState<_CigaretteLogContent> {
  String _selectedFilter = 'This Week';
  @override
  Widget build(BuildContext context) {
    final profile = widget.user.smokingProfile!;

    return CustomScrollView(
      slivers: [
        _buildAppBar(),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 120.0), // Match money tracker padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTargetCard(context, profile),
                _buildHeatmapSection(context, widget.user),
                _buildFilters(),
                _buildMiniChart(context, widget.user, profile),
                _buildTimelineHistory(context, widget.user, profile),
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
      backgroundColor: AppColors.backgroundDark.withValues(alpha: 0.8),
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Cigarette Log',
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: AppColors.primary.withValues(alpha: 0.1),
          height: 1.0,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: AppColors.primary, size: 20),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
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

  Widget _buildTargetCard(BuildContext context, SmokingProfile profile) {
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
              AppColors.primary.withValues(alpha: 0.2),
              Colors.transparent,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.05),
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
                  'DAILY CIGARETTE TARGET',
                  style: TextStyle(
                    color: AppColors.slate400,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _showEditTargetModal(context, profile);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.edit,
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
                    '${profile.cigarettesPerDay}',
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
                const Text(
                  'STICKS',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.sell_outlined, color: AppColors.primary, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Pack Price: Rp ${NumberFormat('#,###', 'id_ID').format(profile.pricePerPack)}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.smoking_rooms, color: AppColors.primary, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Pack Size: ${profile.cigarettesPerPack} sticks',
                  style: const TextStyle(
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

  Widget _buildHeatmapSection(BuildContext context, UserModel user) {
    final quitDate = user.quitDate!;
    final slipHistory = user.progressSummary?.slipHistory ?? {};
    final now = DateTime.now();

    // Generate a 35-day grid (5 weeks x 7 days) or 36 like design (3 rows x 12 cols)
    final gridItems = <Widget>[];
    for (int i = 35; i >= 0; i--) { // 36 days = 12 cols x 3 rows
      final d = now.subtract(Duration(days: i));
      if (d.isBefore(quitDate)) {
        // Not tracking yet
        gridItems.add(
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          )
        );
      } else {
        final dateKey = "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
        final slips = (slipHistory[dateKey] as num?)?.toInt() ?? 0;
        
        Color boxColor;
        if (slips == 0) {
          boxColor = AppColors.primary;
        } else if (slips <= 2) {
          boxColor = Colors.orange;
        } else {
          boxColor = Colors.red;
        }
        
        // vary opacity slightly to match "heatmap" look, or stick to solid
        double opacity = slips == 0 ? (i % 3 == 0 ? 0.3 : (i % 2 == 0 ? 0.6 : 1.0)) : 1.0;
        // The opacity variation is just a mock for visual similar to the design
        
        gridItems.add(
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                color: boxColor.withOpacity(opacity),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          )
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Smoke-free Heatmap',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.slateCard.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 12,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: gridItems,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('LESS', style: TextStyle(fontSize: 10, color: AppColors.slate500, letterSpacing: 2.0)),
                    Row(
                      children: [
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.slateCard, borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 4),
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.3), borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 4),
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.6), borderRadius: BorderRadius.circular(2))),
                        const SizedBox(width: 4),
                        Container(width: 8, height: 8, decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
                      ],
                    ),
                    const Text('MORE', style: TextStyle(fontSize: 10, color: AppColors.slate500, letterSpacing: 2.0)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          _buildFilterChip('This Week'),
          const SizedBox(width: 8),
          _buildFilterChip('This Month'),
          const SizedBox(width: 8),
          _buildFilterChip('All Time'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.slateCard,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.backgroundDark : AppColors.slate400,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMiniChart(BuildContext context, UserModel user, SmokingProfile profile) {
    final slipHistory = user.progressSummary?.slipHistory ?? {};
    final now = DateTime.now();
    
    // Get last 7 days
    final chartData = <int>[];
    for (int i = 6; i >= 0; i--) {
      final d = now.subtract(Duration(days: i));
      if (d.isBefore(user.quitDate!)) {
        chartData.add(profile.cigarettesPerDay); // Pretend baseline before quitting
      } else {
        final dateKey = "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
        final slips = (slipHistory[dateKey] as num?)?.toInt() ?? 0;
        chartData.add(slips);
      }
    }

    final maxVal = max(profile.cigarettesPerDay, chartData.reduce(max).toInt() + 1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.slateCard.withOpacity(0.3),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Cigarettes per day',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.slate300,
                  ),
                ),
                const Text(
                  '-45% Trend',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 96,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  final val = chartData[index];
                  final heightFactor = val / maxVal;
                  final isRecentSuccess = val == 0;
                  
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Container(
                        height: 96 * (heightFactor == 0 ? 0.05 : heightFactor), // min height 5%
                        decoration: BoxDecoration(
                          color: isRecentSuccess ? AppColors.primary : AppColors.slateCard,
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final d = now.subtract(Duration(days: 6 - index));
                final dayStr = DateFormat('E').format(d); // Mon, Tue...
                return Expanded(
                  child: Text(
                    dayStr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.slate500,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineHistory(BuildContext context, UserModel user, SmokingProfile profile) {
    final quitDate = user.quitDate!;
    final now = DateTime.now();
    final totalDaysSinceQuit = now.difference(quitDate).inDays;
    
    final slipHistory = user.progressSummary?.slipHistory ?? {};
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    final List<Widget> entries = [];
    
    for (int i = 0; i <= min(14, totalDaysSinceQuit); i++) { // show up to 15 days in log
      final d = now.subtract(Duration(days: i));
      if (d.isBefore(quitDate)) break;

      final dateKey = "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      final slipsThatDay = (slipHistory[dateKey] as num?)?.toInt() ?? 0;
      
      final activeProfileMap = getActiveProfileForDate(profile, d);
      final activePricePerPack = (activeProfileMap['pricePerPack'] as num?)?.toDouble() ?? 0.0;
      final activeCigarettesPerPack = (activeProfileMap['cigarettesPerPack'] as num?)?.toInt() ?? 1;
      final costPerCigarette = activeCigarettesPerPack > 0 ? activePricePerPack / activeCigarettesPerPack : 0.0;

      final costTodaySaved = profile.cigarettesPerDay * costPerCigarette - (slipsThatDay * costPerCigarette);
      
      Widget iconBox;
      String subtitle;
      Widget rightSide;
      
      if (slipsThatDay == 0) {
        iconBox = Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.backgroundDark, width: 4),
          ),
          child: const Icon(Icons.check, color: AppColors.backgroundDark, size: 20),
        );
        subtitle = "0 sticks • ${formatter.format(costTodaySaved)} saved";
        rightSide = Text(
          isToday(d, now) ? 'Today' : '', // simple message
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary),
        );
      } else if (slipsThatDay <= 2) {
        iconBox = Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.orange,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.backgroundDark, width: 4),
          ),
          child: const Icon(Icons.priority_high, color: Colors.white, size: 20),
        );
        subtitle = "Progress is not linear";
        rightSide = Text(
          "$slipsThatDay sticks",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.orange),
        );
      } else {
        iconBox = Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.backgroundDark, width: 4),
          ),
          child: const Icon(Icons.close, color: Colors.white, size: 20),
        );
        subtitle = "Relapsed today";
        rightSide = Text(
          "$slipsThatDay sticks",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.red),
        );
      }

      entries.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // line connecting to next item
              if (i < min(14, totalDaysSinceQuit))
                Positioned(
                  left: 19,
                  top: 40,
                  bottom: -32,
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          slipsThatDay == 0 ? AppColors.primary : AppColors.slate400,
                          AppColors.backgroundDark.withOpacity(0.0),
                        ],
                      ),
                    ),
                  ),
                ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iconBox,
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              DateFormat('d MMM').format(d),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            if (slipsThatDay == 0 && isToday(d, now))
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                                  ),
                                  child: const Text(
                                    'STREAK ACTIVE',
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: 12,
                            color: slipsThatDay > 0 && slipsThatDay <= 2 ? AppColors.slate400 : AppColors.slate400,
                            fontStyle: slipsThatDay > 0 && slipsThatDay <= 2 ? FontStyle.italic : FontStyle.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  rightSide,
                ],
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Logs',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Column(children: entries),
        ],
      ),
    );
  }

  bool isToday(DateTime date, DateTime now) {
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  void _showEditTargetModal(BuildContext context, SmokingProfile currentProfile) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: _EditTargetModal(profile: currentProfile),
      ),
    );
  }
}

class _EditTargetModal extends ConsumerStatefulWidget {
  final SmokingProfile profile;

  const _EditTargetModal({required this.profile});

  @override
  ConsumerState<_EditTargetModal> createState() => _EditTargetModalState();
}

class _EditTargetModalState extends ConsumerState<_EditTargetModal> {
  late TextEditingController _priceController;
  late TextEditingController _packSizeController;
  late TextEditingController _dailyTargetController;

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: widget.profile.pricePerPack.toInt().toString());
    _packSizeController = TextEditingController(text: widget.profile.cigarettesPerPack.toString());
    _dailyTargetController = TextEditingController(text: widget.profile.cigarettesPerDay.toString());
  }

  @override
  void dispose() {
    _priceController.dispose();
    _packSizeController.dispose();
    _dailyTargetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = AppColors.slate900;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cigarette Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: AppColors.slate400),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildTextField('Price per pack (Rp)', _priceController, TextInputType.number),
          const SizedBox(height: 16),
          _buildTextField('Size per pack (sticks)', _packSizeController, TextInputType.number),
          const SizedBox(height: 16),
          _buildTextField('Daily target (sticks)', _dailyTargetController, TextInputType.number),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              onPressed: () async {
                final price = double.tryParse(_priceController.text) ?? 0;
                final packSize = int.tryParse(_packSizeController.text) ?? 0;
                final dailyTarget = int.tryParse(_dailyTargetController.text) ?? 0;

                final isDecreased = await ref.read(dashboardActionsProvider).updateSmokingProfile(price, packSize, dailyTarget);
                
                if (context.mounted) {
                  Navigator.pop(context);
                  if (isDecreased) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: const Row(
                            children: [
                              Icon(Icons.celebration, color: Colors.white),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  'Luar biasa! Target harian berhasil dikurangi!! 🎉',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                        duration: const Duration(seconds: 4),
                      ),
                    );
                  }
                }
              },
              child: const Text(
                'SAVE CHANGES',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType type) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.slate400,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: type,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.slateCard,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
        ),
      ],
    );
  }
}
