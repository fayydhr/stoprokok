import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../viewmodels/dashboard_viewmodel.dart';
import '../../../core/utils/currency_formatter.dart';
import 'package:intl/intl.dart';

class AddRewardModal extends ConsumerStatefulWidget {
  final int? index;
  final String? initialName;
  final double? initialPrice;

  const AddRewardModal({
    super.key,
    this.index,
    this.initialName,
    this.initialPrice,
  });

  @override
  ConsumerState<AddRewardModal> createState() => _AddRewardModalState();
}

class _AddRewardModalState extends ConsumerState<AddRewardModal> {
  late String _itemName;
  late double _targetPrice;
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _itemName = widget.initialName ?? '';
    _targetPrice = widget.initialPrice ?? 0.0;
    
    _nameController = TextEditingController(text: _itemName);
    _priceController = TextEditingController(
      text: _targetPrice > 0 ? _targetPrice.toInt().toString() : '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.index != null;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundDark,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // BottomSheet handle
              Container(
                height: 6,
                width: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(999),
                ),
                margin: const EdgeInsets.only(bottom: 24),
              ),

              // Header Icon
              Container(
                width: 64,
                height: 64,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                ),
                child: const Icon(
                  Icons.card_giftcard,
                  color: AppColors.primary,
                  size: 32,
                ),
              ),

              // Title
              Text(
                isEditing ? 'Edit Reward Goal' : 'Add Reward Goal',
                style: const TextStyle(
                  color: AppColors.slate100,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Give yourself something to look forward to.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.slate400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 32),

              // Input Groups
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ITEM NAME',
                    style: TextStyle(
                      color: AppColors.slate300,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.05),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Center(
                        child: TextFormField(
                          controller: _nameController,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. Flight to Bali',
                            hintStyle: TextStyle(color: AppColors.slate500.withOpacity(0.5)),
                            border: InputBorder.none,
                          ),
                          onChanged: (val) {
                            setState(() {
                              _itemName = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Consumer(
                    builder: (context, ref, child) {
                      final user = ref.watch(userStreamProvider).value;
                      final currencyCode = user?.currency ?? 'IDR';
                      final symbol = CurrencyFormatter.getFormatter(currencyCode).currencySymbol;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TARGET PRICE ($currencyCode)',
                            style: const TextStyle(
                              color: AppColors.slate300,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.05),
                              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                                  child: Text(
                                    symbol.trim(),
                                    style: const TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _priceController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      CurrencyInputFormatter(currencyCode: currencyCode),
                                    ],
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      hintStyle: TextStyle(color: AppColors.slate500.withOpacity(0.5)),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (val) {
                                      setState(() {
                                        final cleanVal = val.replaceAll(RegExp(r'[^0-9]'), '');
                                        _targetPrice = double.tryParse(cleanVal) ?? 0.0;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // Action Buttons
              if (isEditing) ...[
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _isLoading ? null : () async {
                      // Confirm dialog before removing
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: AppColors.slate900,
                          title: const Text('Remove Goal?', style: TextStyle(color: Colors.white)),
                          content: const Text(
                            'Are you sure you want to delete this reward goal?',
                            style: TextStyle(color: AppColors.slate300),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: const Text('Cancel', style: TextStyle(color: AppColors.slate400)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              child: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        setState(() => _isLoading = true);
                        await ref.read(dashboardActionsProvider).removeSavingsTarget(widget.index!);
                        if (context.mounted) {
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text(
                      'Delete Goal',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.backgroundDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 10,
                    shadowColor: AppColors.primary.withOpacity(0.3),
                  ),
                  onPressed: _isLoading || _itemName.isEmpty || _targetPrice <= 0 ? null : () async {
                    setState(() => _isLoading = true);
                    if (isEditing) {
                      await ref.read(dashboardActionsProvider).editSavingsTarget(widget.index!, _itemName, _targetPrice);
                    } else {
                      await ref.read(dashboardActionsProvider).updateSavingsTarget(_itemName, _targetPrice);
                    }
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: _isLoading 
                      ? const CircularProgressIndicator(color: AppColors.backgroundDark) 
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline, size: 24, color: AppColors.backgroundDark),
                            const SizedBox(width: 8),
                            Text(
                              isEditing ? 'Update Reward Goal' : 'Save Reward Goal',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.slate400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
