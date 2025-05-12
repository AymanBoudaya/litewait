import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  late SharedPreferences prefs;

  HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page Home',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 33, 37, 243),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: Colors.white, size: 30)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
                        Container(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 232, 138, 71),
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    Navigator.pushNamed(context,'/coffee');
                  },
                  child: const Text(
                    'Commander un café',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 33, 37, 243),
                      minimumSize: const Size.fromHeight(50)),
                  onPressed: () {
                    _Deconnexion(context);
                  },
                  child: const Text(
                    'Deconnexion',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _Deconnexion(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setBool("connecte", false);
    Navigator.pushNamedAndRemoveUntil(
        context, '/authentification', (route) => false);
  }
}
