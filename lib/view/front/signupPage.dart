import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobileplatform_project/viewModel/signupPage_viewModel.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpViewModel(),
      child: Scaffold(
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

class SignUpForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SignUpViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('NAME', textAlign: TextAlign.center),
            SizedBox(height: 8.0),
            TextFormField(
              onChanged: (value) => viewModel.user.name = value,
              decoration: InputDecoration(
                labelText: 'ID',
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.user.password = value,
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),
            TextFormField(
              onChanged: (value) => viewModel.user.name = value,
              decoration: InputDecoration(
                labelText: 'NAME',
                filled: true,
                fillColor: Colors.grey[200],
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: 16.0),
            PopupMenuButton<String>(
              initialValue: viewModel.user.country ?? '한국', // 초기 선택 값
              itemBuilder: (BuildContext context) {
                return ['한국', '중국'].map((String country) {
                  return PopupMenuItem<String>(
                    value: country,
                    child: Text(country),
                  );
                }).toList();
              },
              onSelected: (String value) {
                viewModel.user.country = value;
              },
              child: ListTile(
                title: Text('Country'),
                trailing: Icon(Icons.arrow_drop_down),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () => viewModel.signUp(context),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize: Size(double.infinity, 48.0),
              ),
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
