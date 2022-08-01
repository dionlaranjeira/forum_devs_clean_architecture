import 'package:flutter/material.dart';
import 'package:forum_devs_clean_architecture/ui/components/components.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(Icons.email, color: Theme.of(context).primaryColorLight,),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          icon: Icon(Icons.lock, color: Theme.of(context).primaryColorLight,),
                        ),
                        obscureText: true,
                      ),
                    ),
                    RaisedButton(
                      onPressed: null,
                      child: Text("Entrar"),
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
      ),
    );
  }
}

