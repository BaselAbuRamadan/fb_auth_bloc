import 'package:fb_auth_bloc/blocs/signup/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../utils/error_dialog.dart';

class SignupPage extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
 final _passwordController = TextEditingController();
  String? _email, _password , _name;
  void _submit (){
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    print('email: $_email, password: $_password name:$_name');
    context.read<SignupCubit>().signup(
        name:_name!,
        email: _email!,
        password: _password!);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus() ,
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state.signupStatus == SignupStatus.error){
            errorDialog(context,state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: _autovalidateMode,
                    child: ListView(
                      shrinkWrap: true,
                      reverse: true,
                      children: [
                        Image.asset(
                          "assets/images/flutter_logo.png",
                          width: 250,
                          height: 250,
                        ),
                        SizedBox( height: 20),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.account_box),
                          ),
                          validator:(String? value){
                            if (value == null || value.trim().isEmpty){
                              return 'Name Required';
                            }if(value.trim().length<2){
                              return 'Name must be at least 2 charecters';
                            }
                            return null;
                          },
                          onSaved: (String? value){
                            _name = value;
                          },
                        ),
                        SizedBox( height: 20),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator:(String? value){
                            if (value == null || value.trim().isEmpty){
                              return 'Email Required';
                            }if(!isEmail(value.trim())){
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          onSaved: (String? value){
                            _email = value;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'password',
                              prefixIcon: Icon(Icons.lock)
                          ),
                          validator: (String? value){
                            if (value == null || value.trim().isEmpty){
                              return 'Password required';
                            }if (value.trim().length<6){
                              return 'Password must be at least 6 charecters long';
                            }
                            return null;
                          },
                          onSaved: (String? value){
                            _password = value;
                          },
                        ),
                        SizedBox(height: 20.0,),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              labelText: 'Confirm password',
                              prefixIcon: Icon(Icons.lock)
                          ),
                          validator: (String? value){
                            if (_passwordController.text != value){
                              return 'passwords not match';
                            }
                            return null;
                          },
                          onSaved: (String? value){
                            _password = value;
                          },
                        ),
                        SizedBox(height: 20.0,),
                        ElevatedButton(
                          onPressed: state.signupStatus == SignupStatus.submitting
                              ?null
                              : _submit,
                         
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ), 
                          child: Text(state.signupStatus == SignupStatus.submitting
                            ? 'Loading...'
                            :'Sign up'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed:state.signupStatus == SignupStatus.submitting
                            ? null
                            : (){
                          Navigator.pop(context);
                        },
                          child: Text('Already a member? Sign in!'),
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),

                      ].reversed.toList(),
                    ),
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
