import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<Map<String, String>> sections = [
    {
      'title': 'كم تستغرق معاملة استفسار لحن الوصول',
      'content': """
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
""",
    },
    {
      'title': 'متطلبات أساسية للوصول',
      'content': """
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
""",
    },
    {
      'title': 'عقوبات الخزيلة ومن',
      'content': """
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
""",
    },
    {
      'title': 'عقوبات الخزيلة ومن',
      'content': """
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
""",
    },
    {
      'title': 'عقوبات الخزيلة ومن',
      'content': """
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
""",
    },
    {
      'title': 'عقوبات الخزيلة ومن',
      'content': """
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
""",
    },
    {
      'title': 'عقوبات الخزيلة ومن',
      'content': """
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
أن يؤدي العمل المتفق عليه، وأن يبذل في ذلك عناية الشخص المعتاد.
""",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile.faq'.tr()),

      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppContainer(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sections[index]['title']!,
                      style: AppTextStyles.font18Medium,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 4.w,
                      children: [
                        Container(
                          width: 3.w,
                          height: 3.h,

                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          sections[index]['content']!,
                          style: AppTextStyles.font12Regular,
                        ),
                      ],
                    ),
                  ],
                ),
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: sections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
