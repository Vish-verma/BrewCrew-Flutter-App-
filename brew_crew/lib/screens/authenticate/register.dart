import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

final Function toggleView;
Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

final AuthService _auth = AuthService();
final _formKey = GlobalKey<FormState>();
bool loading = false;
   //text field state
  String email="";
  String password="";
  String error = "";
  @override
  Widget build(BuildContext context) {
    return loading?Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Sign In"),
            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 18.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText:'Email' ),
                validator: (val){
                  if(val.isEmpty){
                    return "Enter an Email";
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                    setState(()=>email=val);
                },
              ),
              SizedBox(height: 18.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val){
                  if(val.length < 6){
                    return "Enter a password with 6+ characters";
                  }
                  else{
                    return null;
                  }
                },
                onChanged: (val){
                    setState(()=>password=val);
                },
                
              ),
              SizedBox(height: 18.0,),
              RaisedButton(
                color: Colors.blue[400],
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                    if (_formKey.currentState.validate()){
                      setState(() {
                        loading=true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      //print(result);
                      
                      if (result == null) {
                        setState(() {
                          error = "Please supply Valid email";
                          loading=false;
                        });
                      }
                    }
                    else{
                      print("Invalid");
                    }
                },
              ),
              SizedBox(height: 8.0,),
              Text(
                error,
                style:TextStyle(
                  color:Colors.red,
                  fontSize: 14.0
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
