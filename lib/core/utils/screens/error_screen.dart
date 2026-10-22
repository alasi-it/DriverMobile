import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:lottie/lottie.dart';

const String _kFont = 'cairo';

class ErrorScreen extends StatefulWidget {
  final Object error;
  final StackTrace? stackTrace;
  final VoidCallback? onRetry;

  const ErrorScreen({
    super.key,
    required this.error,
    this.stackTrace,
    this.onRetry,
  });

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entryController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  bool _showStack = false;
  bool _copied = false;

  @override
  void initState() {
    super.initState();
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _fadeAnim = CurvedAnimation(
      parent: _entryController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(
          CurvedAnimation(parent: _entryController, curve: Curves.easeOutCubic),
        );
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  Color get _bg => AppColors.backgroundPrimary;
  Color get _cardBg => AppColors.backgroundSecondary;
  Color get _divider => AppColors.inputOutline;

  void _copyToClipboard() {
    final stackText =
        widget.stackTrace?.toString() ?? 'error_screen.no_stack'.tr();
    Clipboard.setData(
      ClipboardData(text: 'Error: ${widget.error}\n\nStack Trace:\n$stackText'),
    );
    setState(() => _copied = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  void _retry() =>
      widget.onRetry != null ? widget.onRetry!() : Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    final isRtl = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRtl ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Scaffold(
        backgroundColor: _bg,
        body: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SlideTransition(
              position: _slideAnim,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 32),
                          _buildLottie(),
                          const SizedBox(height: 24),
                          _buildTitle(),
                          const SizedBox(height: 12),
                          _buildSubtitle(),
                          const SizedBox(height: 28),
                          _buildErrorCard(),
                          const SizedBox(height: 14),
                          _buildStackToggle(),
                          if (_showStack) ...[
                            const SizedBox(height: 10),
                            _buildStackCard(),
                          ],
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  _buildActions(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLottie() => SizedBox(
    width: 220,
    height: 220,
    child: Lottie.asset(
      'assets/lottie/error.json',
      repeat: true,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => _fallbackIcon(),
    ),
  );

  Widget _fallbackIcon() => AppContainer(
    width: 120,
    height: 120,
    shape: BoxShape.circle,
    color: AppColors.primary.withOpacity(0.12),
    border: Border.all(color: AppColors.primary, width: 2.5),
    padding: EdgeInsets.zero,
    child: Icon(
      Icons.warning_amber_rounded,
      color: AppColors.primary,
      size: 48,
    ),
  );

  Widget _buildTitle() => Column(
    children: [
      Text(
        'error_screen.title'.tr(),
        textAlign: TextAlign.center,
        style: AppTextStyles.font24SemiBold.copyWith(
          fontFamily: _kFont,
          color: AppColors.typographyHeading,
          letterSpacing: -0.4,
          height: 1.2,
        ),
      ),
      const SizedBox(height: 10),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppContainer(
            width: 32,
            height: 3,
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(2),
          ),
          const SizedBox(width: 4),
          AppContainer(
            width: 16,
            height: 3,
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    ],
  );

  Widget _buildSubtitle() => Text(
    'error_screen.subtitle'.tr(),
    textAlign: TextAlign.center,
    style: AppTextStyles.font14Regular.copyWith(
      fontFamily: _kFont,
      color: AppColors.typographySubtitle,
      height: 1.65,
    ),
  );

  Widget _buildErrorCard() => AppContainer(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    color: _cardBg,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.07),
        blurRadius: 20,
        offset: const Offset(0, 6),
      ),
    ],
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            AppContainer(
              width: 8,
              height: 8,
              shape: BoxShape.circle,
              color: AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              'error_screen.error_details'.tr(),
              style: AppTextStyles.font10Bold.copyWith(
                fontFamily: _kFont,
                color: AppColors.primary,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(height: 1, color: AppColors.primary.withOpacity(0.15)),
        const SizedBox(height: 10),
        Text(
          widget.error.toString(),
          style: AppTextStyles.font12Regular.copyWith(
            fontFamily: 'cairo',
            color: AppColors.typographyHeading.withOpacity(0.85),
            height: 1.6,
          ),
        ),
      ],
    ),
  );

  Widget _buildStackToggle() => GestureDetector(
    onTap: () => setState(() => _showStack = !_showStack),
    child: AppContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: AppColors.secondary.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: AppColors.secondary.withOpacity(0.25)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _showStack ? Icons.expand_less : Icons.expand_more,
            color: AppColors.secondary,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            _showStack
                ? 'error_screen.hide_stack'.tr()
                : 'error_screen.show_stack'.tr(),
            style: AppTextStyles.ts(
              12,
              FontWeight.w600,
            ).copyWith(fontFamily: _kFont, color: AppColors.secondary),
          ),
        ],
      ),
    ),
  );

  Widget _buildStackCard() => AppContainer(
    width: double.infinity,
    constraints: const BoxConstraints(maxHeight: 200),
    padding: const EdgeInsets.all(14),
    color: AppColors.tertiary.withOpacity(AppColors.isDark() ? 0.6 : 0.05),
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: _divider),
    child: SingleChildScrollView(
      child: Text(
        widget.stackTrace?.toString() ?? 'error_screen.no_stack'.tr(),
        style: AppTextStyles.font10Regular.copyWith(
          fontFamily: 'cairo',
          color: AppColors.typographyHeading.withOpacity(0.4),
          height: 1.6,
        ),
      ),
    ),
  );

  Widget _buildActions() => AppContainer(
    padding: const EdgeInsets.fromLTRB(24, 14, 24, 28),
    color: _bg,
    border: Border(top: BorderSide(color: _divider)),
    borderRadius: BorderRadius.zero,
    child: Column(
      children: [
        GestureDetector(
          onTap: _copyToClipboard,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              color: _copied
                  ? AppColors.iconSuccess.withOpacity(0.1)
                  : AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _copied
                    ? AppColors.iconSuccess.withOpacity(0.5)
                    : AppColors.primary.withOpacity(0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  _copied ? Icons.check_rounded : Icons.copy_rounded,
                  color: _copied ? AppColors.iconSuccess : AppColors.primary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  _copied
                      ? 'error_screen.copied'.tr()
                      : 'error_screen.copy_report'.tr(),
                  style: AppTextStyles.font14SemiBold.copyWith(
                    fontFamily: _kFont,
                    color: _copied ? AppColors.iconSuccess : AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        GestureDetector(
          onTap: _retry,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.refresh_rounded,
                  color: AppColors.white,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'error_screen.try_again'.tr(),
                  style: AppTextStyles.font16Bold.copyWith(
                    fontFamily: _kFont,
                    color: AppColors.white,
                    letterSpacing: 0.2,
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

class AppInlineErrorWidget extends StatelessWidget {
  final FlutterErrorDetails details;

  const AppInlineErrorWidget({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    final isRtl = context.locale.languageCode == 'ar';

    return Directionality(
      textDirection: isRtl ? ui.TextDirection.rtl : ui.TextDirection.ltr,
      child: Material(
        color: Colors.transparent,
        child: AppContainer(
          width: double.infinity,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary.withOpacity(0.35)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppContainer(
                width: 40,
                height: 40,
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.12),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.4),
                  width: 1.5,
                ),
                padding: EdgeInsets.zero,
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'error_screen.inline_message'.tr(),
                  style: AppTextStyles.font13Bold.copyWith(
                    fontFamily: _kFont,
                    color: AppColors.typographyHeading,
                    height: 1.3,
                  ),
                ),
              ),
              AppContainer(
                width: 6,
                height: 6,
                shape: BoxShape.circle,
                color: AppColors.errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
