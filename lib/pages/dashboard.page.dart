import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(25, 100, 25, 25),
          child: Center(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/illustration.png',
                  width: 300,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                Text(
                  'Your Personal',
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Fitness Trainer'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 48,
                    color: Theme.of(context).primaryColor,
                    fontFamily: 'Bebas',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(),
                      ),
                    );
                  },
                  minWidth: double.infinity,
                  height: 50,
                  child: Text(
                    'Get Started'.toUpperCase(),
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                MaterialButton(
                  onPressed: () {},
                  minWidth: double.infinity,
                  height: 50,
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Sign In'.toUpperCase(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
