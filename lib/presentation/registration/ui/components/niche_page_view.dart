import 'package:flutter/material.dart';

import '../../../../domain/usecase/registration/params/fill_influencer_profile_param.dart';
import '../../../../uikit/typography/typography.dart';

class NichePageView extends StatefulWidget {
  const NichePageView({super.key, required this.onChanged});

  final Function(FillInfluencerProfileParam) onChanged;

  @override
  State<NichePageView> createState() => _NichePageViewState();
}

class _NichePageViewState extends State<NichePageView>
    with AutomaticKeepAliveClientMixin<NichePageView> {
  FillInfluencerProfileParam _fillInfluencerProfileParam =
      FillInfluencerProfileParam();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Niches', style: Typographies.titleMedium),
          SizedBox(height: 24),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
