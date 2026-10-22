import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/utils/widgets/images/cached_image_widget.dart';

class CustomCarouselSlider extends StatefulWidget {
  const CustomCarouselSlider({
    super.key,
    required this.images,
    this.autoPlay,
    this.enableInfiniteScroll,
    this.viewportFraction,
    this.aspectRatio,
    this.asset = false,
    this.fit,
    this.height,
    this.padding,
    this.onImageTap,
    this.onPageChanged,
    this.itemBuilder,
    this.showDots = true,
    this.activeDotColor,
    this.inactiveDotColor,
  });

  final List<String> images;

  final bool? autoPlay;
  final bool? enableInfiniteScroll;
  final double? viewportFraction;
  final double? aspectRatio;
  final bool asset;
  final BoxFit? fit;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool showDots;
  final Color? activeDotColor;
  final Color? inactiveDotColor;

  final Widget Function(BuildContext context, int index)? itemBuilder;

  final Function(int index)? onImageTap;
  final Function(int, CarouselPageChangedReason)? onPageChanged;

  @override
  State<CustomCarouselSlider> createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) return const SizedBox();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: double.infinity,
          height: widget.height ?? 180.h,
          child: CarouselSlider.builder(
            itemCount: widget.images.length,
            itemBuilder: (context, index, realIndex) {
              if (widget.itemBuilder != null) {
                return GestureDetector(
                  onTap: () => widget.onImageTap?.call(index),
                  child: Padding(
                    padding: widget.padding ?? EdgeInsets.zero,
                    child: widget.itemBuilder!(context, index),
                  ),
                );
              }

              final image = widget.images[index];
              return Padding(
                padding: widget.padding ?? EdgeInsets.zero,
                child: GestureDetector(
                  onTap: () => widget.onImageTap?.call(index),
                  child: CachedImageWidget(
                    radius: 15.r,
                    imageUrl: image,
                    fit: widget.fit ?? BoxFit.fill,
                    width: double.infinity,
                    height: widget.height ?? 164.h,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: widget.height ?? 164.h,
              autoPlay: widget.autoPlay ?? true,
              enableInfiniteScroll: widget.enableInfiniteScroll ?? false,
              viewportFraction: widget.viewportFraction ?? 1,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
                widget.onPageChanged?.call(index, reason);
              },
            ),
          ),
        ),

        if (widget.showDots && widget.images.length > 1) ...[
          SizedBox(height: 16.h),

          DotsIndicator(
            dotsCount: widget.images.length,
            position: _currentIndex.toDouble(),
            decorator: DotsDecorator(
              activeColor: AppColors.dotColor,
              color: AppColors.border,
              spacing: EdgeInsets.symmetric(horizontal: 4.w),
              size: Size(8.w, 8.h),
              activeSize: Size(8.w, 8.h),
              activeShape: const CircleBorder(),
            ),
          ),
        ],
      ],
    );
  }
}
