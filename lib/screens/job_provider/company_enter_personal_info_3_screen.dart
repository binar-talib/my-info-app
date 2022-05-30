import 'package:flutter/material.dart';
import 'package:job_vacancy/custom_widgets/custom_icon_button.dart';
import 'package:job_vacancy/custom_widgets/custom_list_tile.dart';
import 'package:job_vacancy/custom_widgets/custom_text_button.dart';
import 'package:job_vacancy/custom_widgets/custom_texts.dart';
import 'package:job_vacancy/modules/constants.dart';

class CompanyEnterPersonalInformation3Screen extends StatefulWidget {
  const CompanyEnterPersonalInformation3Screen({Key? key}) : super(key: key);

  @override
  State<CompanyEnterPersonalInformation3Screen> createState() =>
      _EnterPersonalInformation3ScreenState();
}

class _EnterPersonalInformation3ScreenState
    extends State<CompanyEnterPersonalInformation3Screen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: AutoSizeText15(
            text:
                'Thank you for signing up \n\nCompany account will be reviewed and once the review is done, you will be notified.'),
      ),
    );
  }
}
