import 'dart:convert';
import 'package:academia/shared/models/user.model.dart';
import 'package:academia/shared/models/constants/custom_colors.dart';
import 'package:academia/shared/models/constants/preferences_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameInputController = TextEditingController();
  final TextEditingController _mailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final TextEditingController _confirmInputController = TextEditingController();

  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 50,
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                CustomColors().getGradientSecondaryColor(),
                CustomColors().getGradientMainColor(),
              ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Cadastro",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameInputController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "Nome Completo",
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person,
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
                      obscureText: (showPassword == true) ? false : true,
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
                    (showPassword == false) // como se fosse um if else
                        ? TextFormField(
                            controller: _confirmInputController,
                            obscureText: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: const InputDecoration(
                              labelText: "Confirme a Senha",
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
                          )
                        : Container(),
                    Row(
                      children: [
                        Checkbox(
                          value: showPassword,
                          onChanged: (newValue) {
                            setState(() {
                              showPassword = newValue!;
                            });
                          },
                          activeColor: Colors.blue,
                        ),
                        const Text(
                          "Mostrar senha",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _doSignUp();
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
                  foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.red;
                      }
                      return Colors.cyan;
                    },
                  ),
                ),
                child: const Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _doSignUp() {
    User newUser = User(
      name: _nameInputController.text,
      mail: _mailInputController.text,
      password: _passwordInputController.text,
      keepOn: true,
    );

    _savedUser(newUser);
  }

  void _savedUser(User user) async {
    // ignore: unused_local_variable
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
      PreferencesKeys.activeUser,
      json.encode(user.toJson()),
    );
  }
}
