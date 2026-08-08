import 'package:flutter/material.dart';
import 'package:isnad_worker/core/utils/widgets/images/custom_svg.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key, required this.logo});
  final String logo;

  @override
  Widget build(BuildContext context) {
    return Center(child: CustomSvg(svg: logo));
  }
}
