import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';
import '../../../../core/application/common/widgets/primary_app_bar.dart';
import '../../../../core/application/common/widgets/social_media_list_tile.dart';
import '../../../../core/application/common/widgets/stories_indicator_widget.dart';
import '../../../../core/application/navigation/router.dart';
import '../../../../core/util/assets/colors/color_scheme.dart';
import '../../../../core/util/assets/colors/colors.dart';
import '../../../../core/util/assets/text/text_extention.dart';
import '../../application/registration_bloc.dart';

class CompleteProfileSocialLinksPage extends StatefulWidget {
  const CompleteProfileSocialLinksPage({
    super.key,
  });

  @override
  State<CompleteProfileSocialLinksPage> createState() => _CompleteProfileSocialLinksPageState();
}

class _CompleteProfileSocialLinksPageState extends State<CompleteProfileSocialLinksPage> {
  final ValueNotifier<bool> _isContinueButtonEnabled = ValueNotifier(false);
  final _twitterTextController = TextEditingController();
  final _instTextController = TextEditingController();
  final _facebookTextController = TextEditingController();
  final _linkedInTextController = TextEditingController();
  final _tikTokTextController = TextEditingController();
  final _discordTextController = TextEditingController();
  final _websiteTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _twitterTextController.addListener(_updateButtonState);
    _instTextController.addListener(_updateButtonState);
    _facebookTextController.addListener(_updateButtonState);
    _linkedInTextController.addListener(_updateButtonState);
    _tikTokTextController.addListener(_updateButtonState);
    _discordTextController.addListener(_updateButtonState);
    _websiteTextController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _twitterTextController.dispose();
    _instTextController.dispose();
    _facebookTextController.dispose();
    _linkedInTextController.dispose();
    _tikTokTextController.dispose();
    _discordTextController.dispose();
    _websiteTextController.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    final enableButton = _twitterTextController.text.isNotEmpty ||
        _instTextController.text.isNotEmpty ||
        _facebookTextController.text.isNotEmpty ||
        _linkedInTextController.text.isNotEmpty ||
        _tikTokTextController.text.isNotEmpty ||
        _discordTextController.text.isNotEmpty ||
        _websiteTextController.text.isNotEmpty;
    _isContinueButtonEnabled.value = enableButton;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>() ?? AppTextTheme.base();

    final appBar = PrimaryAppBar(
      leading: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: _onBackPressed,
          child: Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0x33D9D9D9),
              shape: BoxShape.circle,
            ),
            child: AppAssets.images.chevronLeft.image(),
          ),
        ),
      ),
    );

    return BlocConsumer<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFillSecondPageSuccessState) {
          AppRouter.instance().go('/home');
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColorScheme.of(context).primary,
          body: Stack(
            children: [
              if (state is RegistrationLoading)
                CircularProgressIndicator(
                  color: AppColors.pumpkin.value,
                  backgroundColor: AppColors.grape.value,
                ),
              CustomScrollView(
                slivers: [
                  appBar,
                  const SliverPadding(
                    padding: EdgeInsets.only(top: 10),
                    sliver: SliverToBoxAdapter(
                      child: StoriesProgressIndicatorWidget(
                        storiesNumber: 2,
                        currentIndex: 2,
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      bottom: 45,
                      left: 28,
                      right: 28,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: S.current.add_social_links,
                                  style: textTheme.bold30.copyWith(
                                    fontFamily: 'Montserrat',
                                    color: AppColors.whiteSmoke.value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          RichText(
                            textAlign: TextAlign.left,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: S.current.let_people_know_how_to_find,
                                  style: textTheme.medium15.copyWith(
                                    fontFamily: 'Montserrat',
                                    color: AppColors.pumpkin.value,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 28,
                      right: 34,
                    ),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SocialMediaListTile(
                              type: SocialMediaType.twitter,
                              textEditingController: _twitterTextController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SocialMediaListTile(
                              type: SocialMediaType.instagram,
                              textEditingController: _instTextController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SocialMediaListTile(
                              type: SocialMediaType.facebook,
                              textEditingController: _facebookTextController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SocialMediaListTile(
                              type: SocialMediaType.linkedin,
                              textEditingController: _linkedInTextController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SocialMediaListTile(
                              type: SocialMediaType.tiktok,
                              textEditingController: _tikTokTextController,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SocialMediaListTile(
                              type: SocialMediaType.discord,
                              textEditingController: _discordTextController,
                            ),
                          ),
                          SocialMediaListTile(
                            type: SocialMediaType.website,
                            textEditingController: _websiteTextController,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        const Spacer(),
                        const SizedBox(height: 34),
                        ValueListenableBuilder(
                          valueListenable: _isContinueButtonEnabled,
                          builder: (context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 34),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.pumpkin.value,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(26),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 33),
                                      ),
                                      onPressed: value ? _onContinuePressed : null,
                                      child: Center(
                                        child: Text(
                                          S.current.continue_title.toUpperCase(),
                                          style: textTheme.medium15.copyWith(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.whiteSmoke.value,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    flex: 1,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.blueCharcoal.value,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(26),
                                          side: BorderSide(
                                            color: AppColors.whiteSmoke.value,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 33),
                                      ),
                                      onPressed: _onSkipPressed,
                                      child: Center(
                                        child: Text(
                                          S.current.skip.toUpperCase(),
                                          style: textTheme.medium15.copyWith(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.whiteSmoke.value,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 34), // Add extra space at the bottom if needed
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _onContinuePressed() {
    final controllersTexts = [
      _twitterTextController.text,
      _instTextController.text,
      _facebookTextController.text,
      _linkedInTextController.text,
      _tikTokTextController.text,
      _discordTextController.text,
      _websiteTextController.text,
    ];
    const socialMediaTypes = SocialMediaType.values;
    final providers = <SocialMediaType, String>{};
    for (var i = 0; i < socialMediaTypes.length; i++) {
      providers[socialMediaTypes[i]] = controllersTexts[i];
    }
    context.read<RegistrationBloc>().add(RegistrationFillSecondProfilePageEvent(providers));
  }

  void _onSkipPressed() {
    AppRouter.instance().go('/home');
  }

  void _onBackPressed() {
    AppRouter.instance().go('/sign-up/complete-profile/first');
  }
}
