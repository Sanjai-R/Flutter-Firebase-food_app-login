import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grubhub/Components/form.dart';
import 'package:grubhub/Components/textwidget.dart';
import 'package:grubhub/Views/Dashboard.dart';
import 'package:grubhub/Views/sign_up.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  String _email, _pw;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwcontroller = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    double ht = MediaQuery.of(context).size.height;
    double wh = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xF010101),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("Asset/images/salad.jpg"),
                      fit: BoxFit.fill)),
            ),
            TextWidget(
              text: "GrubHub",
              size: 40,
              weight: FontWeight.w600,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormFieldWidget(
                      hintText: "Enter your Email",
                      controller: _emailcontroller,
                      parametersValidate: "Required email",
                      onsaved: (input) {
                        _email = input;
                      },
                      functionValidate: commonValidation),
                  TextFormFieldWidget(
                      hintText: "Enter Your Password",
                      obscureText: true,
                      controller: _pwcontroller,
                      parametersValidate: "Please enter password.",
                      onsaved: (input) {
                        _pw = input;
                      },
                      functionValidate: commonValidation),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 180),
              child: TextButton(
                  onPressed: () {},
                  child: TextWidget(
                    text: "Forgotten Password ?",
                    size: 15,
                    color: Color(0xff1DB954),
                  )),
            ),
            SigninBtn(context),
            SizedBox(height: 20,),
            Or(),
            SizedBox(
              height: 10,
            ),
            SignInButton(buttonType: ButtonType.google, onPressed: (){ print('click');}),

            SignUpBtn()
          ],
        ),
      ),
    );
  }
  Widget SignUpBtn(){
    return TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup()));
        },
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: "Don't have an account", size: 15,color: Color(0xff1DB954),),
            SizedBox(width: 10,),
            TextWidget(text: "Sign Up here", size: 15.0,color: Colors.white60,)
          ],
        ),

    );
}
  Widget Or(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width*0.30,
            color: Colors.white60,
          ),
          TextWidget(text: "\t\t OR \t\t", size: 15),
          Container(
            height: 2,
            width: MediaQuery.of(context).size.width*0.30,
            color: Colors.white60,
          ),
        ],
      ),
    );
  }
  Widget SigninBtn(context) {
    return InkWell(
      onTap: signin,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60),
        height: 50,
        width: MediaQuery.of(context).size.width - 140,
        decoration: BoxDecoration(
          color: Color(0xff1DB954),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
            child: TextWidget(
                text: "Get Started", size: 25, weight: FontWeight.w700)),
      ),
    );
  }

  Future<void> signin() async {
    _formkey.currentState.save();
    try{
      UserCredential user =  await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email, password: _pw);
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message:
          "Successfully you logged in",
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard(user: user),fullscreenDialog: true));
      }catch( e ){
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "Something went wrong. Please check your credentials and try again",
        ),
      );
      }

  }
}
