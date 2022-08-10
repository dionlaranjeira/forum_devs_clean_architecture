import 'package:flutter/material.dart';
import 'package:forum_devs_clean_architecture/ui/components/components.dart';
import 'package:forum_devs_clean_architecture/ui/pages/login/login_presenter.dart';

class LoginPage extends StatefulWidget {

  final LoginPresenter presenter;
  LoginPage(this.presenter);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LoginHeader(),
                Headline1(text:"login"),
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Form(
                    child: Column(
                      children: [
                        StreamBuilder<String>(
                          stream: widget.presenter.emailErrorStream,
                          builder: (context, snapshot) {
                            return TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Email',
                                icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight,),
                                errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onChanged: widget.presenter.validateEmail,
                            );
                          }
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 32),
                          child: StreamBuilder<String>(
                            stream: widget.presenter.passwordErrorStream,
                            builder: (context, snapshot) {
                              return TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Senha',
                                  icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight,),
                                  errorText: snapshot.data?.isEmpty == true ? null : snapshot.data
                                ),
                                obscureText: true,
                                onChanged: widget.presenter.validatePassword,
                              );
                            }
                          ),
                        ),
                        StreamBuilder<bool>(
                          stream: widget.presenter.isFormValidStream,
                          builder: (context, snapshot) {
                            return RaisedButton(
                              onPressed: snapshot.data == true ? widget.presenter.auth : null,
                              child: Text("Entrar"),
                            );
                          }
                        ),
                        FlatButton.icon(
                            onPressed: (){},
                            icon: Icon(Icons.person),
                            label: Text("Criar conta"))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }
}


