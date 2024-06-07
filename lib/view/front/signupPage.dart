import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobileplatform_project/viewModel/signupPage_viewModel.dart';
import 'package:easy_localization/easy_localization.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: SignUpForm(),
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String selectedCountry = 'choose'.tr();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 50.0),
        Row(
          children: [
            SizedBox(width: 60),
            Text(
              'NAME',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        Container(
          height: 60,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            onChanged: (value) => viewModel.user.username = value.toString(),
            decoration: InputDecoration(
              labelText: 'name'.tr(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            SizedBox(width: 60),
            Text(
              'ID',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        Container(
          height: 60,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            onChanged: (value) {
              viewModel.user.id = value.toString();
              viewModel.user.userId = value.toString();
            },
            decoration: InputDecoration(
              labelText: 'id'.tr(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            SizedBox(width: 60),
            Text(
              'PASSWORD',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        Container(
          height: 60,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: TextField(
            onChanged: (value) => viewModel.user.password = value.toString(),
            decoration: InputDecoration(
              labelText: 'password'.tr(),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          children: [
            SizedBox(width: 60),
            Text(
              'COUNTRY',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return CupertinoActionSheet(
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        setState(() {
                          selectedCountry = 'korea'.tr();
                          viewModel.user.country = selectedCountry;
                        });
                        Navigator.pop(context);
                      },
                      child: Text('korea'.tr()),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        setState(() {
                          selectedCountry = 'china'.tr();
                          viewModel.user.country = selectedCountry;
                        });
                        Navigator.pop(context);
                      },
                      child: Text('china'.tr()),
                    ),
                  ],
                  cancelButton: CupertinoActionSheetAction(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'.tr()),
                  ),
                );
              },
            );
          },
          child: Container(
            width: 300,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedCountry,
                  style: TextStyle(color: Colors.black),
                ),
                Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        SizedBox(height: 50.0),
        SizedBox(
          height: 60,
          width: 300,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.greenAccent, Colors.blueGrey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: ElevatedButton(
              onPressed: () => viewModel.signUp(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              child: Text(
                'sign_up_button'.tr(),
                style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold,),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

