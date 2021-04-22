import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grubhub/Components/form.dart';
import 'file:///C:/Users/sANJAI%20R/Documents/GitHub/competitive/grubhub/lib/Components/textwidget.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email, _pw,_username;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _pwcontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
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
                      hintText: "Enter your UserName",
                      controller: _usernamecontroller,
                      parametersValidate: "Required",
                      onsaved: (input) {
                        _username = input;
                      },
                      functionValidate: commonValidation),
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
            SizedBox(height: 10,),
            SigninBtn(context),
            SizedBox(
              height: 10,
            ),
            Or(context),
            SizedBox(height: 10,),

            SignInButton(btnText: "SignUp with Google",buttonType: ButtonType.google, onPressed: (){ print('click');}),
            Signin()
          ],
        ),
      ),
    );
  }
  Widget Signin(){
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));
      },
      child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(text: "Already have an account?", size: 15,color: Color(0xff1DB954),),
          SizedBox(width: 10,),
          TextWidget(text: "Login here", size: 15.0,color: Colors.white60,)
        ],
      ),

    );
  }
  // ignore: non_constant_identifier_names
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
                text: "Sign Up", size: 25, weight: FontWeight.w700)),
      ),
    );
  }

  Future<void> signin() async {
    _formkey.currentState.save();
    try{
      UserCredential user =  await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email, password: _pw);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin(),fullscreenDialog: true));
    }catch( e ){
      print(e.error);
    }

  }
  Widget Or(context){
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
}
