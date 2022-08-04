import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibsmobile/pages/mainhome.dart';
import 'package:ibsmobile/pages/setting.dart';

class loginPage extends StatefulWidget {
  loginPage({Key? key}) : super(key: key);

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String username = "user";
  String password = "123";
  String alert = "Silahkan Login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController usernameInput = new TextEditingController();
  TextEditingController passwordInput = new TextEditingController();

  void prosesLogin() {
    if(_formKey.currentState!.validate()){
      if(usernameInput.text == username && passwordInput.text == password){
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => mainhomePage(username: usernameInput.text,)
        ));
      }else{
        setState(() {
          alert = "Username atau Password salah";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              Container(
                margin: EdgeInsets.fromLTRB(300, 35, 0, 0),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    shape: BoxShape.circle
                ),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return settingPage();
                    }));
                  },
                  child: Center(
                    child: Icon(Icons.settings,size: 40, color: Colors.white,),
                  ),
                ),
              ),

              Container(
                width: 130,
                height: 130,
                child: Center(
                  child: Image(
                    image: AssetImage("images/logo.png"),
                  ),
                ),
              ),
              Text("Selamat Datang di IBSMOBILE", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold ,color: Colors.black87),),
              SizedBox(height: 10,),
              Text(alert, style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold ,color: Colors.black87),),

              SizedBox(height: 50,),

              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: usernameInput,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Isi Username Anda";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        prefixIcon: Icon(Icons.person,size: 40,),
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Masukkan username anda",
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),

                    SizedBox(height: 20,),

                    TextFormField(
                      controller: passwordInput,
                      validator: (value){
                        if(value!.isEmpty){
                          return "Isi Password Anda";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)
                        ),
                        prefixIcon: Icon(Icons.lock,size: 40,),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: "Masukkan password anda",
                        hintStyle: TextStyle(color: Colors.black),
                      ),
                    ),

                    SizedBox(height: 40,),

                    Card(
                      color: Colors.blueGrey,
                      elevation: 5,
                      child: Container(
                        height: 50,
                        child: InkWell(
                          splashColor: Colors.black,
                          onTap: () => prosesLogin(),
                          child: Center(
                            child: Text("LOGIN", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold ,color: Colors.white),),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )

            ],
          ),
        )
      ),
    );
  }
}
