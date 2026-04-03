import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';

class ExperiencePageView extends StatefulWidget {
  const ExperiencePageView({super.key, required this.onChanged});
  final Function(FillInfluencerProfileParam) onChanged;
  @override
  State<ExperiencePageView> createState() => _ExperiencePageViewState();
}

class _ExperiencePageViewState extends State<ExperiencePageView> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
