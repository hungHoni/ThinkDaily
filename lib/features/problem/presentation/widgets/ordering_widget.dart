import 'package:flutter/material.dart';

import 'package:think_daily/core/theme/app_colors.dart';
import 'package:think_daily/core/theme/app_spacing.dart';
import 'package:think_daily/core/theme/app_text_styles.dart';

class OrderingWidget extends StatefulWidget {
  const OrderingWidget({
    required this.options,
    required this.onOrderChanged,
    this.disabled = false,
    super.key,
  });

  final List<String> options;
  final ValueChanged<List<int>> onOrderChanged;
  final bool disabled;

  @override
  State<OrderingWidget> createState() => _OrderingWidgetState();
}

class _OrderingWidgetState extends State<OrderingWidget> {
  late List<int> _order;

  @override
  void initState() {
    super.initState();
    _order = List.generate(widget.options.length, (i) => i);
  }

  void _onReorder(int oldIndex, int newIndex) {
    if (widget.disabled) return;
    setState(() {
      final insertIndex = newIndex > oldIndex ? newIndex - 1 : newIndex;
      final item = _order.removeAt(oldIndex);
      _order.insert(insertIndex, item);
    });
    widget.onOrderChanged(List.of(_order));
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      onReorder: _onReorder,
      itemCount: _order.length,
      proxyDecorator: (child, _, __) => Material(
        color: Colors.transparent,
        child: child,
      ),
      itemBuilder: (context, i) {
        final optionIndex = _order[i];
        return _OrderItem(
          key: ValueKey(optionIndex),
          number: i + 1,
          label: widget.options[optionIndex],
          disabled: widget.disabled,
        );
      },
    );
  }
}

class _OrderItem extends StatelessWidget {
  const _OrderItem({
    required this.number,
    required this.label,
    required this.disabled,
    super.key,
  });

  final int number;
  final String label;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 24,
              child: Text(
                '$number',
                style: AppTextStyles.categoryLabel,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(label, style: AppTextStyles.optionText),
            ),
            if (!disabled)
              const Icon(
                Icons.drag_handle,
                color: AppColors.border,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
