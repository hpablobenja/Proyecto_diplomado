// lib/presentation/widgets/modern_button.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

enum ModernButtonVariant { primary, secondary, accent, success, outline, text }

enum ModernButtonSize { small, medium, large }

class ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ModernButtonVariant variant;
  final ModernButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double? width;
  final double? height;

  const ModernButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ModernButtonVariant.primary,
    this.size = ModernButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.width,
    this.height,
  });

  @override
  State<ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppStyles.animationFast,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: AppStyles.curveFast),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }

  void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: widget.onPressed != null ? _onTapDown : null,
      onTapUp: widget.onPressed != null ? _onTapUp : null,
      onTapCancel: widget.onPressed != null ? _onTapCancel : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: widget.isFullWidth ? double.infinity : widget.width,
          height: widget.height ?? _getButtonHeight(),
          child: _buildButton(isDark),
        ),
      ),
    );
  }

  Widget _buildButton(bool isDark) {
    switch (widget.variant) {
      case ModernButtonVariant.primary:
        return _buildElevatedButton(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          isDark: isDark,
        );
      case ModernButtonVariant.secondary:
        return _buildElevatedButton(
          backgroundColor: AppColors.accentOrange,
          foregroundColor: Colors.white,
          isDark: isDark,
        );
      case ModernButtonVariant.accent:
        return _buildElevatedButton(
          backgroundColor: AppColors.accentGreen,
          foregroundColor: Colors.white,
          isDark: isDark,
        );
      case ModernButtonVariant.success:
        return _buildElevatedButton(
          backgroundColor: AppColors.success,
          foregroundColor: Colors.white,
          isDark: isDark,
        );
      case ModernButtonVariant.outline:
        return _buildOutlinedButton(isDark);
      case ModernButtonVariant.text:
        return _buildTextButton(isDark);
    }
  }

  Widget _buildElevatedButton({
    required Color backgroundColor,
    required Color foregroundColor,
    required bool isDark,
  }) {
    return ElevatedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        elevation: 4,
        shadowColor: backgroundColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        padding: _getPadding(),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: _buildButtonContent(foregroundColor),
    );
  }

  Widget _buildOutlinedButton(bool isDark) {
    return OutlinedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        side: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        padding: _getPadding(),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: _buildButtonContent(AppColors.primaryBlue),
    );
  }

  Widget _buildTextButton(bool isDark) {
    return TextButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_getBorderRadius()),
        ),
        padding: _getPadding(),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: _buildButtonContent(AppColors.primaryBlue),
    );
  }

  Widget _buildButtonContent(Color textColor) {
    if (widget.isLoading) {
      return SizedBox(
        width: _getIconSize(),
        height: _getIconSize(),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: _getIconSize(), color: textColor),
          const SizedBox(width: AppStyles.spacingS),
          Flexible(
            child: Text(
              widget.text,
              style: _getTextStyle().copyWith(color: textColor),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    }

    return Text(
      widget.text,
      style: _getTextStyle().copyWith(color: textColor),
      overflow: TextOverflow.ellipsis,
    );
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case ModernButtonSize.small:
        return 36;
      case ModernButtonSize.medium:
        return 48;
      case ModernButtonSize.large:
        return 56;
    }
  }

  double _getBorderRadius() {
    switch (widget.size) {
      case ModernButtonSize.small:
        return AppStyles.radiusS;
      case ModernButtonSize.medium:
        return AppStyles.radiusM;
      case ModernButtonSize.large:
        return AppStyles.radiusL;
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case ModernButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingM,
          vertical: AppStyles.spacingS,
        );
      case ModernButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingL,
          vertical: AppStyles.spacingM,
        );
      case ModernButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: AppStyles.spacingXL,
          vertical: AppStyles.spacingL,
        );
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ModernButtonSize.small:
        return 16;
      case ModernButtonSize.medium:
        return 20;
      case ModernButtonSize.large:
        return 24;
    }
  }

  TextStyle _getTextStyle() {
    switch (widget.size) {
      case ModernButtonSize.small:
        return AppStyles.labelMedium;
      case ModernButtonSize.medium:
        return AppStyles.ctaButton;
      case ModernButtonSize.large:
        return AppStyles.titleLarge;
    }
  }
}
