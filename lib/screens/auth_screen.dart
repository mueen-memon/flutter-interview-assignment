import 'package:flutter/material.dart';
import '../providers/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

String email = '';
String password = '';

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    final deviceSize = MediaQuery.of(context).size;
    // TextEditingController userName = TextEditingController();
    // TextEditingController password = TextEditingController();

    bool spinner = false;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    'Weight Tracker',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline1,
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  flex: deviceSize.width > 600 ? 2 : 1,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 8.0,
                    child: Container(
                      width: deviceSize.width * 0.80,
                      height: deviceSize.height * 0.3,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextField(
                            decoration:
                                const InputDecoration(labelText: 'E-Mail'),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          TextField(
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              obscureText: true,
                              onChanged: (value) {
                                password = value;
                              }),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                setState(() {
                                  spinner = true;
                                });
                                var logIn = await _auth.signInWithEmail(
                                    email: email, password: password);

                                // if (logIn != null){

                                // }
                                //Navigator.pop(context);
                                // Navigator.pushNamed(
                                //   context, HomeScreen.routeId);

                                setState(() {
                                  spinner = false;
                                });
                              } catch (e) {
                                setState(() {
                                  spinner = false;
                                });
                                final snackBar =
                                    SnackBar(content: Text(e.toString()));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: spinner
                                ? CircularProgressIndicator()
                                : const Text('Sign In'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(120, 30),
                              primary: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
