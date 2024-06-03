import 'package:flutter/material.dart';
import 'package:flutter_ui_components/flutter_ui_components.dart';

/// A clickable card with an icon and a caption.
///
class ActionCard extends StatelessWidget {
  const ActionCard({
    required this.icon,
    required this.caption,
    this.onPressed,
    this.dimension = 130.0,
    this.enabled = true,
    this.elevation = 5.0,
    super.key,
  }) : isExpanded = false;

  const ActionCard.expanded({
    required this.icon,
    required this.caption,
    this.onPressed,
    this.enabled = true,
    this.elevation = 5.0,
    super.key,
  })  : dimension = null,
        isExpanded = true;

  /// The icon to display.
  final Widget icon;

  /// The caption to display.
  final String caption;

  /// The callback to be called when the card is pressed.
  final VoidCallback? onPressed;

  /// The dimension of the card.
  final double? dimension;

  /// Whether the card is expanded.
  final bool isExpanded;

  /// Whether the card is enabled.
  final bool enabled;

  /// The elevation of the card. Defaults at 5.0.
  final double elevation;

  Widget _buildCard(BuildContext context) {
    final contentColor = enabled ? Colors.black : Colors.black38;
    return Material(
      color: Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.circular(Dimens.s4),
      elevation: elevation,
      shadowColor: Theme.of(context).cardTheme.shadowColor,
      child: InkWell(
        highlightColor: Colors.white.withOpacity(0.1),
        onTap: enabled ? onPressed : null,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(Dimens.s16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Opacity(
                opacity: enabled ? 1.0 : 0.5,
                child: icon,
              ),
              Gaps.s10,
              Text(
                caption,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: contentColor,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isExpanded
        ? Expanded(child: _buildCard(context))
        : SizedBox.square(
            dimension: dimension,
            child: _buildCard(context),
          );
  }
}
