import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalShimmer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius borderRadius;

  const GlobalShimmer({
    super.key,
    this.width = double.infinity,
    this.height = 16.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}

class ShimmerList extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double itemSpacing;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerList({
    super.key,
    this.itemCount = 5,
    this.itemBuilder,
    this.padding,
    this.physics,
    this.shrinkWrap = false,
    this.itemSpacing = 8,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey[300]!,
      highlightColor: highlightColor ?? Colors.grey[100]!,
      child: ListView.builder(
        itemCount: itemCount,
        shrinkWrap: shrinkWrap,
        physics: physics,
        padding: padding,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: itemSpacing),
          child:
              itemBuilder?.call(context, index) ??
              const GlobalShimmer(height: 80),
        ),
      ),
    );
  }
}
