import 'package:flutter/material.dart';
import 'package:forum_devs_clean_architecture/ui/components/components.dart';
import 'package:forum_devs_clean_architecture/ui/pages/login/components/components.dart';
import 'package:forum_devs_clean_architecture/ui/pages/login/login_presenter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {

  final LoginPresenter presenter;
  LoginPage(this.presenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  void _hideKeyboard(){
    final currectFocus = FocusScope.of(context);
    if(!currectFocus.hasPrimaryFocus){
      currectFocus.unfocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.presenter.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {

          widget.presenter.isLoadingStream.listen((isLoading) {
            if(isLoading){
              showLoading(context);
            }else{
              hideLoading(context);
            }
          });

          widget.presenter.mainErrorStream.listen((error) {
            if(error != null){
              showErrorMessage(context, error);
            }
          });
          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(),
                  Headline1(text:"login"),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Provider(
                      create: (_)=> widget.presenter,
                      child: Form(
                        child: Column(
                          children: [
                            EmailInput(),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, bottom: 32),
                              child: PasswordInput(),
                            ),
                            LoginButton(),
                            FlatButton.icon(
                                onPressed: (){},
                                icon: Icon(Icons.person),
                                label: Text("Criar conta"))
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}





