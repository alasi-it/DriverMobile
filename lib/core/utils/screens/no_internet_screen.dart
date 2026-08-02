import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isnad_worker/core/network/connectivity/network_cubit.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/text_styles.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  bool _isRetrying = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _retry() async {
    setState(() => _isRetrying = true);
    await context.read<NetworkCubit>().checkConnectivity();
    if (mounted) setState(() => _isRetrying = false);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Scaffold(
          backgroundColor: AppColors.backgroundPrimary,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  _buildIcon(),
                  const SizedBox(height: 32),
                  _buildTitle(),
                  const SizedBox(height: 12),
                  _buildSubtitle(),
                  const Spacer(),
                  _buildRetryButton(),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 130,
      height: 130,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withValues(alpha: 0.08),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 2,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.wifi_off_rounded, size: 60, color: AppColors.primary),
          Positioned(
            bottom: 20,
            right: 18,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.errorColor,
                border: Border.all(
                  color: AppColors.backgroundPrimary,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.close_rounded,
                size: 14,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      children: [
        Text(
          'no_internet.title'.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyles.font24SemiBold.copyWith(
            color: AppColors.typographyHeading,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 16,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubtitle() => Text(
    'no_internet.subtitle'.tr(),
    textAlign: TextAlign.center,
    style: AppTextStyles.font14Regular.copyWith(
      color: AppColors.typographySubtitle,
      height: 1.65,
    ),
  );

  Widget _buildRetryButton() => GestureDetector(
    onTap: _isRetrying ? null : _retry,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        gradient: _isRetrying
            ? null
            : LinearGradient(
                colors: [AppColors.primary, AppColors.tertiary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
        color: _isRetrying ? AppColors.primary.withValues(alpha: 0.4) : null,
        borderRadius: BorderRadius.circular(14),
        boxShadow: _isRetrying
            ? null
            : [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isRetrying
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : const Icon(
                  Icons.refresh_rounded,
                  color: AppColors.white,
                  size: 20,
                ),
          const SizedBox(width: 10),
          Text(
            _isRetrying
                ? 'no_internet.checking'.tr()
                : 'no_internet.retry'.tr(),
            style: AppTextStyles.font16Bold.copyWith(
              color: AppColors.white,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    ),
  );
}

class NoInternetWrapper extends StatelessWidget {
  final Widget child;

  const NoInternetWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkCubit, NetworkState>(
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (context, state) {
        if (state.isDisconnected) {
          return const NoInternetScreen();
        }
        return child;
      },
    );
  }
}
