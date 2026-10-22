import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isnad_worker/core/style/app_colors.dart';
import 'package:isnad_worker/core/style/app_dimensions.dart';
import 'package:isnad_worker/core/style/text_styles.dart';
import 'package:isnad_worker/core/utils/widgets/layout/app_container.dart';
import 'package:isnad_worker/core/utils/widgets/layout/custom_app_bar.dart';

class PoliciesScreen extends StatefulWidget {
  const PoliciesScreen({super.key});

  @override
  State<PoliciesScreen> createState() => _PoliciesScreenState();
}

class _PoliciesScreenState extends State<PoliciesScreen> {
  final List<Map<String, dynamic>> sections = [
    {
      'header': 'حقوق وواجبات العامل',
      'lists': [
        {
          'title': 'واجبات عامل الخدمة المنزلية',
          'bullets': [
            'أن يؤدي العمل المتقن عليه وأن يدخل في ذلك عائلة الشخص المعتاد.',
            'أن يشرح أوامر صاحب العمل والأسرة المتعلقة به بتنفيذ العمل المتقن عليه.',
            'أن يحافظ على ممتلكات صاحب العمل وأفراد أسرته، ألا يؤدي أضرار للسيرة بسبب الأطفال وكبار السن.',
            'أن يتقيد بالزي والفي المنزل، إلا يطلع على أشياء العمل أو بسبه والحتياجات المتعلقة به.',
            'ألا يقبض العمل أو يترك الخدمة دون سبب مشروع، ألا يعمل لحساب الخاص.',
            'ألا يبس كارثة صاحب العمل وأفراد أسرته، وألا يدخم الدين الباشي والمتطمة المعمول بها في نهابته والتجديد.',
          ],
        },
        {
          'title':
              'عقوبات العامل المخالف لالئحة عمال الخدمة المنزلية ومن في حكمه',
          'bullets': [
            'غرامــة ماليــة ال تزيــد علــى ألفــي ريــال، أو بمنعــه مــن العمــل  فــي المملكــة نهائي ًّ ــا، أو بهمــا معــا ً .'
                'تتعــدد الغرامــات بتعــدد المخالفــات المثبتــة علــى عامــل  الخدمــة المزليــة.',
            'ويتحمــل عامــل الخدمــة المزليــة المخالــف تكاليــف عودتــه  إلــى بلــده، فــإن لــم يكــن لديــه مســتحقات ماليــة تفــي  بالغرامــات المقــررة عليــه، ي ُ رح ّ ــل إلــى بلــده علــى حســاب الدولة.',
            'أن يحافــظ علــى األســرار الخاصــة بصاحــب العمــل وأفــراد األســرة واألشــخاص الذيــن فــي المــزل، الــي يطلــع عليهــا أثنــاء العمــل أو بســببه، وأال يفشــيها إلــى الغــر. ',
            'أال يرفض العمل أو يرتك الخدمة دون سبب مشروع. أال يعمل لحسابه الخاص. ',
            'أال يمس كرامة صاحب العمل وأفراد األسرة، وأال يتدخل فيما يخصهم.',
            'أن يحــرتم الديــن اإلســامي، ويلــزم باألنظمــة المعمــول بهــا فــي المملكــة، وعــادات المجتمــع الســعودي وتقاليــده.',
          ],
        },
      ],
    },
    {
      'header': 'حقوق وواجبات صاحب العمل',
      'lists': [
        {
          'title': 'واجبات صاحب العمل',
          'bullets': [
            'أن يؤدي العمل المتقن عليه وأن يدخل في ذلك عائلة الشخص المعتاد.',
            'أن يشرح أوامر صاحب العمل والأسرة المتعلقة به بتنفيذ العمل المتقن عليه.',
            'أن يحافظ على ممتلكات صاحب العمل وأفراد أسرته، ألا يؤدي أضرار للسيرة بسبب الأطفال وكبار السن.',
          ],
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'profile.polices'.tr()),
      body: SingleChildScrollView(
        padding: AppPadding.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppContainer(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, sectionIndex) {
                  final section = sections[sectionIndex];
                  final lists = section['lists'] as List<Map<String, dynamic>>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section['header']!,
                        style: AppTextStyles.font20Bold.copyWith(
                          color: AppColors.primaryTextStrong,
                        ),
                      ),
                      SizedBox(height: 12.h),

                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, listIndex) {
                          final list = lists[listIndex];
                          final bullets = list['bullets'] as List<String>;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                list['title']!,
                                style: AppTextStyles.font14Medium,
                              ),
                              SizedBox(height: 8.h),

                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, bulletIndex) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: Row(
                                      spacing: 4.w,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 3.w,
                                          height: 3.h,

                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.typographyHeading,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            bullets[bulletIndex],
                                            style: AppTextStyles.font12Regular,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: bullets.length,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (context, listIndex) =>
                            SizedBox(height: 16.h),
                        itemCount: lists.length,
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, sectionIndex) =>
                    SizedBox(height: 20.h),
                itemCount: sections.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
