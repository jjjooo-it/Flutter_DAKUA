import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobileplatform_project/view/widget/appBar.dart';

class LoadingSummaryPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'loadingText'.tr(),
                style: TextStyle(fontSize: 20.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50),
              SpinKitWave(
                itemBuilder: (context, index) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.green),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
