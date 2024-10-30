import 'package:flutter/material.dart';
import 'package:loginsignup/Login%20SignUp/Widgets/button.dart';
import 'package:loginsignup/Login%20SignUp/Widgets/snack_bar.dart';
import 'package:loginsignup/Login%20SignUp/Widgets/text_field.dart';
import 'package:loginsignup/Login%20SignUp/home.dart';
import 'package:loginsignup/Services/authentication.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void despose()
  {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  void loginUser()async
  {
    String res = await AuthService().signInUser(
      email: emailController.text,
      password: passwordController.text,
    );

    if(res=='Success'){
      setState(() {
        isLoading = true;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }else{
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView( // Add this line
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.7,
                child: Image.asset("images/login.png"),
              ),
              TextFieldInput(
                textEditingController: emailController,
                hintText: "Enter Your Email Address",
                icon: Icons.email,
              ),
              TextFieldInput(
                textEditingController: passwordController,
                hintText: "Enter Your Password",
                icon: Icons.lock,
                isPass: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              MyButton(onTab:loginUser, text: "Log In"),
              SizedBox(height: height/15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(fontSize: 16),),
                  GestureDetector(onTap: (){
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: Text(" SignUp",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}