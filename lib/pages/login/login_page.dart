import "dart:convert";

import 'package:academia/shared/models/user.model.dart';
import 'package:academia/pages/sign_up/sign_up_page.dart';
import 'package:academia/shared/models/constants/custom_colors.dart';
import 'package:academia/shared/models/constants/preferences_keys.dart';
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  bool continueConnected = false;
  Color topColor = Colors.blue;
  Color bottomColor = const Color.fromARGB(255, 212, 247, 255);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              CustomColors().getGradientMainColor(),
              CustomColors().getGradientSecondaryColor(),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 15,
                ),
                child: Image.asset(
                  "assets/dumbbel.png",
                  height: 125,
                ),
              ),
              const Text(
                "Entrar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _mailInputController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "E-mail",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _passwordInputController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Senha",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.vpn_key,
                          color: Colors.white,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "Esqueceu a Senha?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 10)),
              Row(
                children: [
                  Checkbox(
                    value: continueConnected,
                    onChanged: (newValue) {
                      setState(() {
                        continueConnected = newValue!;
                      });
                    },
                  ),
                  const Text(
                    "Continuar conectado?",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
              ),
              ElevatedButton(
                onPressed: () {
                  _doLogin();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) {
                      return Colors.indigo.shade900;
                    },
                  ),
                  shape: MaterialStateProperty.resolveWith(
                    (states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      );
                    },
                  ),
                  foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.red;
                      }
                      return Colors.white;
                    },
                  ),
                ),
                child: const Text("Login"),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Ainda não tem uma conta?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  //
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith(
                    (states) {
                      return Colors.white;
                    },
                  ),
                  shape: MaterialStateProperty.resolveWith(
                    (states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      );
                    },
                  ),
                  foregroundColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.red;
                    }
                    return Colors.black;
                  }),
                ),
                child: const Text("Cadastre-se"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin() async {
    String mailForm = _mailInputController.text;
    String passForm = _passwordInputController.text;

    User savedUser = await _getSavedUser();

    if (mailForm == savedUser.mail && passForm == savedUser.password) {
      print("LOGIN EFETUADO COM SUCESSO");
    } else {
      print("FALHA DO LOGIN");
    }
  }

  Future<User> _getSavedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonUser = prefs.getString(PreferencesKeys.activeUser).toString();

    Map<String, dynamic> mapUser = json.decode(jsonUser.toString());
    User user = User.fromJson(mapUser);
    return user;
  }
}
