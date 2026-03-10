import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../../../data/models/user_model.dart';

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
                _buildHistorySection(context, widget.user, profile),
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

  Widget _buildHistorySection(BuildContext context, UserModel user, SmokingProfile profile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Daily History',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              Icon(Icons.history_toggle_off, color: AppColors.primary),
            ],
          ),
          const SizedBox(height: 16),
          _buildHistoryList(context, user, profile),
        ],
      ),
    );
  }

  Widget _buildHistoryList(BuildContext context, UserModel user, SmokingProfile profile) {
    final quitDate = user.quitDate!;
    final now = DateTime.now();
    final totalDaysSinceQuit = now.difference(quitDate).inDays;
    
    final slipHistory = user.progressSummary?.slipHistory ?? {};
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    
    final List<Widget> entries = [];
    
    for (int i = totalDaysSinceQuit; i >= 0; i--) {
      final d = quitDate.add(Duration(days: i));
      final dateKey = "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
      final slipsThatDay = (slipHistory[dateKey] as num?)?.toInt() ?? 0;
      
      final activeProfileMap = getActiveProfileForDate(profile, d);
      final activePricePerPack = (activeProfileMap['pricePerPack'] as num?)?.toDouble() ?? 0.0;
      final activeCigarettesPerPack = (activeProfileMap['cigarettesPerPack'] as num?)?.toInt() ?? 1;
      final costPerCigarette = activeCigarettesPerPack > 0 ? activePricePerPack / activeCigarettesPerPack : 0.0;

      final costToday = slipsThatDay * costPerCigarette;
      final isToday = i == totalDaysSinceQuit;

      entries.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isToday ? AppColors.primary.withValues(alpha: 0.1) : AppColors.slate900.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isToday ? AppColors.primary.withValues(alpha: 0.3) : AppColors.backgroundDark,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: slipsThatDay > 0 
                              ? Colors.orangeAccent.withValues(alpha: 0.1) 
                              : AppColors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.smoking_rooms, 
                          color: slipsThatDay > 0 ? Colors.orangeAccent : AppColors.primary, 
                          size: 20
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isToday ? 'Today' : DateFormat('dd MMM yyyy').format(d),
                              style: TextStyle(
                                color: isToday ? AppColors.primary : AppColors.slate100,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${slipsThatDay} sticks',
                              style: TextStyle(
                                color: slipsThatDay > 0 ? Colors.orangeAccent : AppColors.slate400,
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  slipsThatDay > 0 ? formatter.format(costToday) : 'Rp 0',
                  style: TextStyle(
                    color: slipsThatDay > 0 ? Colors.orangeAccent : AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Column(children: entries);
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
