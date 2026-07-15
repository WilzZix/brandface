import 'package:brandface/core/i18n/strings.g.dart';
import 'package:brandface/uikit/typography/typography.dart';
import 'package:flutter/material.dart';

class TermOfUsePage extends StatelessWidget {
  const TermOfUsePage({super.key});

  static const String tag = '/term_of_use';

  static const String _body =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
      'Maecenas tincidunt quam at facilisis ornare. Donec lacinia dui '
      'tempor, luctus sem nec, lobortis nibh. Fusce dictum, ex sit amet '
      'vulputate dignissim, metus neque aliquet arcu, sed feugiat lectus '
      'elit sed dolor. Mauris aliquet, metus id pretium suscipit, libero '
      'orci dictum quam, sed blandit ligula orci eu mauris. Curabitur '
      'libero tortor, pulvinar eu lectus nec, dignissim ullamcorper eros. '
      'Nulla ornare posuere risus, a feugiat dolor tempus laoreet. In '
      'pharetra sem leo, ac ultrices ex aliquet at. Curabitur posuere diam '
      'at leo eleifend, vitae varius massa luctus. Maecenas vitae sed '
      'mauris euismod imperdiet. Ut imperdiet orci eget sapien tincidunt, '
      'ac viverra magna bibendum. Phasellus ante sem, iaculis vel velit '
      'quis, egestas feugiat mauris.\n\n'
      'Vestibulum nunc urna, consectetur vitae laoreet id, ultrices ac mi. '
      'Nunc et vestibulum massa. Duis tincidunt malesuada massa vitae '
      'ultrices. Proin non egestas sapien. Proin ut justo felis. Sed '
      'posuere hendrerit ultrices. Mauris auctor sit amet dui in porta. '
      'Sed sodales leo ac mauris porta, eu sagittis purus euismod. Mauris '
      'nulla augue, dignissim ut lorem nec, convallis faucibus ligula. '
      'Etiam mollis vehicula elit et vestibulum. Orci varius natoque '
      'penatibus et magnis dis parturient montes, nascetur ridiculus mus. '
      'Curabitur sit amet libero justo. Nullam ullamcorper dui at ante '
      'aliquam, non iaculis urna mattis. Ut nec massa vel urna dignissim '
      'tincidunt.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, scrolledUnderElevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.misc.terms_of_use_title, style: Typographies.headlineSmall),
              const SizedBox(height: 16),
              Text(_body, style: Typographies.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
