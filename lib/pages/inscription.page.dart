import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InscriptionPage extends StatelessWidget {
  late SharedPreferences prefs;
  TextEditingController txt_login = new TextEditingController();
  TextEditingController txt_password = new TextEditingController();
  TextEditingController txt_password2 = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(
            'Page Inscription',
            style:
                TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[200],
          elevation: 10,
        ),
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Icon(Icons.add_card, size: 100),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    controller: txt_login,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      prefixIcon: Icon(Icons.person, color: Colors.black),
                      hintText: "Identifiant",
                    )),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    obscureText: true,
                    controller: txt_password,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      prefixIcon: Icon(Icons.password, color: Colors.black),
                      hintText: "Mot de passe",
                    )),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                    obscureText: true,
                    controller: txt_password2,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade600)),
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      prefixIcon: Icon(Icons.password, color: Colors.black),
                      hintText: "Confirmer mot de passe",
                    )),
              ),
              Container(
                padding: EdgeInsets.all(15),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        minimumSize: Size.fromHeight(55)),
                    onPressed: () {
                      _OnInscrire(context);
                    },
                    child: Text(
                      'Inscription',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, '/authentification');
                  },
                  child: Text(
                    "J'ai déjà un compte",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[400]),
                  ))
            ],
          ),
        ));
  }

  Future<void> _OnInscrire(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    if ((txt_login.text.isNotEmpty && txt_password.text.isNotEmpty) &&
        (txt_password.text == txt_password2.text)) {
      prefs.setString("login", txt_login.text);
      prefs.setString("password", txt_password.text);
      prefs.setBool("connecte", true);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } else if (txt_password.text != txt_password2.text) {
      const snackBar = SnackBar(
          content: Text(
              "Les mots de passe ne correspondent pas. Veuillez réessayer. "));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(content: Text("Id ou mot de passe vides"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
