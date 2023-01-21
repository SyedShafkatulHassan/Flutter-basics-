import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 100),
          _getEmailInputField(),
          SizedBox(height: 10),
          _getPasswordInputField(),
          SizedBox(height: 10),
          ForgetPassword(context),
          SizedBox(height: 30),
          LoginOption(context),
          SizedBox(height: 50),
          last(context),
        ],
      )),
    );
  }

  Widget _getEmailInputField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(
            prefixIcon: Icon(Icons.email_outlined), hintText: "Email"),
        keyboardType: TextInputType.emailAddress,
        onChanged: (String value) {},
      ),
    );
  }

  Widget _getPasswordInputField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        controller: passwordController,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          suffixIcon: Icon(
            Icons.remove_red_eye_rounded,
          ),
          hintText: "Password",
        ),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        obscuringCharacter: "*",
      ),
    );
  }

  Widget ForgetPassword(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ElevatedButton.styleFrom(),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Under Development"),
            ));
          },
          child: Text(
            'Forget password ?',
            style: TextStyle(
                color: Color.fromARGB(255, 17, 11, 11).withOpacity(0.6)),
          ),
        ),
      ],
    );
  }

  Widget LoginOption(context) {
    return Row(
      children: [
        SizedBox(
            width: 180,
            height: 70,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(
                                color: Color.fromARGB(255, 240, 233, 233))))),
                onPressed: () {
                  createuser(emailController.text, passwordController.text);
                  readdata();
                  print("hello world");
                },
                child: Text("Sign In"))),
      ],
    );
  }
}

Widget last(context) {
  return (Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text("Do not have a account?"),
      TextButton(
        style: ElevatedButton.styleFrom(),
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Under Development"),
          ));
        },
        child: Text(
          'Forget password ?',
          style: TextStyle(
              color: Color.fromARGB(255, 92, 158, 219).withOpacity(0.6)),
        ),
      ),
    ],
  ));
}

Future Sigin(String email, String password) async {
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: password);
}

Future createuser(String email, String password) async {
  final docuser = FirebaseFirestore.instance.collection('Users').doc();
  final jsona = {'name': email, 'password': password};
  docuser.set(jsona);
}

readdata() {
  DocumentReference documentReference =
      FirebaseFirestore.instance.collection('Users').doc('shafkat');
  documentReference.get().then((datasnapshot) {
    print(datasnapshot.data());
  });
}
