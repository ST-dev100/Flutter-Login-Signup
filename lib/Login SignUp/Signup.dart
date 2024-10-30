import 'package:flutter/material.dart';
import 'package:loginsignup/Login%20SignUp/Widgets/button.dart';
import 'package:loginsignup/Login%20SignUp/Widgets/snack_bar.dart';
import 'package:loginsignup/Login%20SignUp/Widgets/text_field.dart';
import 'package:loginsignup/Login%20SignUp/home.dart';
import 'package:loginsignup/Services/authentication.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({super.key});
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen>{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void despose()
  {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }
  void sigUpUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthService().signUpUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );



    if (res == 'Success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
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
                child: Image.asset("images/signup.png"),
              ),
              TextFieldInput(
                textEditingController: nameController,
                hintText: "Enter Your Name",
                icon: Icons.person,
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
              ),

              MyButton(onTab: sigUpUser, text: "Sign up"),
              SizedBox(height: height/15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: TextStyle(fontSize: 16),),
                  GestureDetector(onTap: (){
                    Navigator.pushNamed(context,'/login');
                  },
                    child: Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
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