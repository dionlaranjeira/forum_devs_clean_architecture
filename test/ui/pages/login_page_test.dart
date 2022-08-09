import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:forum_devs_clean_architecture/ui/pages/pages.dart';
import 'package:mockito/mockito.dart';

class LoginPresenterSpy extends Mock implements LoginPresenter{}

void main(){

  LoginPresenter presenter;
  StreamController<String> emailErrorController;
  StreamController<String> passwordErrorController;
  StreamController<bool> isFormValidControler;
  StreamController<bool> isLoadingController;

  Future<void> loadPage(WidgetTester tester) async {
    presenter = LoginPresenterSpy();
    emailErrorController = StreamController<String>();
    passwordErrorController = StreamController<String>();
    isFormValidControler = StreamController<bool>();
    isLoadingController = StreamController<bool>();


    when(presenter.emailErrorStream).thenAnswer((_) => emailErrorController.stream);
    when(presenter.passwordErrorStream).thenAnswer((_) => passwordErrorController.stream);
    when(presenter.isFormValidStream).thenAnswer((_) => isFormValidControler.stream);
    when(presenter.isLoadingStream).thenAnswer((_) => isLoadingController.stream);

    final loginPage = MaterialApp(home: LoginPage(presenter));
    await tester.pumpWidget(loginPage);
  }
  
  tearDown((){
    emailErrorController.close();
    passwordErrorController.close();
    isFormValidControler.close();
    isLoadingController.close();
  });
  
  testWidgets("Should load with correct if inicial state", (WidgetTester tester) async{
    await loadPage(tester);

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(
        emailTextChildren,
        findsOneWidget,
        reason: 'when a TextFormField has only text child, means it has no errors, since one of the childs is always the label text'
    );

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(
        passwordTextChildren,
        findsOneWidget,
        reason: 'when a TextFormField has only text child, means it has no errors, since one of the childs is always the label text'
    );
    
    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);
    expect(find.byType(CircularProgressIndicator), findsNothing);

  });

  testWidgets("Should call validate with correct values", (WidgetTester tester) async{
    await loadPage(tester);

    final email = faker.internet.email();
    await tester.enterText(find.bySemanticsLabel('Email'), email);
    verify(presenter.validateEmail(email));

    final password = faker.internet.password();
    await tester.enterText(find.bySemanticsLabel('Senha'), password);
    verify(presenter.validatePassword(password));

  });

  testWidgets("Should present error email is invalid", (WidgetTester tester) async{
    await loadPage(tester);

    emailErrorController.add('any error');
    await tester.pump();
    
    expect(find.text('any error'), findsOneWidget);

  });

  testWidgets("Should present no error email is invalid", (WidgetTester tester) async{
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump();

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(
        emailTextChildren,
        findsOneWidget
    );

  });

  testWidgets("Should present no error email is valid", (WidgetTester tester) async{
    await loadPage(tester);

    emailErrorController.add(null);
    await tester.pump();

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(
        emailTextChildren,
        findsOneWidget
    );
  });

  testWidgets("Should present no error email is valid", (WidgetTester tester) async{
    await loadPage(tester);

    emailErrorController.add('');
    await tester.pump();

    final emailTextChildren = find.descendant(of: find.bySemanticsLabel('Email'), matching: find.byType(Text));
    expect(
        emailTextChildren,
        findsOneWidget
    );

  });

  testWidgets("Should present error password is invalid", (WidgetTester tester) async{
    await loadPage(tester);

    passwordErrorController.add('any error');
    await tester.pump();

    expect(find.text('any error'), findsOneWidget);

  });

  testWidgets("Should present no error password is valid", (WidgetTester tester) async{
    await loadPage(tester);

    passwordErrorController.add(null);
    await tester.pump();

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(
        passwordTextChildren,
        findsOneWidget
    );
  });

  testWidgets("Should present no error password is valid", (WidgetTester tester) async{
    await loadPage(tester);

    passwordErrorController.add('');
    await tester.pump();

    final passwordTextChildren = find.descendant(of: find.bySemanticsLabel('Senha'), matching: find.byType(Text));
    expect(
        passwordTextChildren,
        findsOneWidget
    );

  });


  testWidgets("Should enable button if form is valid", (WidgetTester tester) async{
    await loadPage(tester);

    isFormValidControler.add(true);
    await tester.pump();

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, isNotNull);

  });

  testWidgets("Should enable button if form is invalid", (WidgetTester tester) async{
    await loadPage(tester);

    isFormValidControler.add(false);
    await tester.pump();

    final button = tester.widget<RaisedButton>(find.byType(RaisedButton));
    expect(button.onPressed, null);

  });

  testWidgets("Should call authentication on form submit", (WidgetTester tester) async{
    await loadPage(tester);

    isFormValidControler.add(true);
    await tester.pump();
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    verify(presenter.auth()).called(1);

  });

  testWidgets("Should call authentication on form submit", (WidgetTester tester) async{
    await loadPage(tester);

    isFormValidControler.add(true);
    await tester.pump();
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    verify(presenter.auth()).called(1);

  });

  testWidgets("Should present loading", (WidgetTester tester) async{
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

  });

  testWidgets("Should present loading", (WidgetTester tester) async{
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

  });

  testWidgets("Should hide loading", (WidgetTester tester) async{
    await loadPage(tester);

    isLoadingController.add(true);
    await tester.pump();
    isLoadingController.add(false);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsNothing);

  });

}