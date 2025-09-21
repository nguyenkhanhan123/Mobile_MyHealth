import 'package:al_datn_my_health/api/sever_api.dart';
import 'package:al_datn_my_health/common_utils.dart';
import 'package:al_datn_my_health/model/req/account_req.dart';
import 'package:al_datn_my_health/view/act/admin/main_act_admin.dart';
import 'package:al_datn_my_health/view/collect_user_data/introduce.dart';
import 'package:al_datn_my_health/view/act/client/main_act.dart';
import 'package:al_datn_my_health/view/act/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.clear();
    _passwordController.clear();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "My",
                style: TextStyle(
                  fontFamily: "SVN_Ready",
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: "Health",
                style: TextStyle(
                  fontFamily: "SVN_Ready",
                  fontSize: 32,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_logo_app.png', height: height * .2),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                'Login',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "SVN_SAF",
                  fontSize: 48,
                  color: Colors.green,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Username
                    TextFormField(
                      controller: _usernameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Username",
                        labelStyle: TextStyle(color: Colors.grey),
                        floatingLabelStyle: TextStyle(color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5,
                          ),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.green),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập Username";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.grey),
                        floatingLabelStyle: TextStyle(color: Colors.green),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5,
                          ),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.green),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập Password";
                        } else if (value.length < 6) {
                          return "Password phải ít nhất 6 ký tự";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 7),

                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: Text(
                        "Chưa có tài khoản, đăng ký ngay!",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontFamily: "SVN_Comic",
                          decoration:TextDecoration.underline
                        ),
                      ),
                    ),
                  ),

                    SizedBox(height: 7),

                    TextButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String username = _usernameController.text;
                          final String password = _passwordController.text;
                          _login(username, password);
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      icon: Icon(Icons.login, size: 24, color: Colors.white),
                      label: Text(
                        'Đăng nhập',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: "SVN_Comic",
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    TextButton.icon(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final String username = _usernameController.text;
                          final String password = _passwordController.text;
                          _loginAdmin(username, password);
                        }
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.green,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                          side: BorderSide(
                            color: Colors.green,
                            width: 2
                          )
                        ),
                      ),
                      icon: Icon(Icons.login, size: 24, color: Colors.green),
                      label: Text(
                        'Đăng nhập đặc biệt',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 22,
                          fontFamily: "SVN_Comic",
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Future<void> _login(String username, String password) async {
    final req = AccountReq(userName: username, passWord: password);
    final res = await SeverApi().loginAccount(req);
    if (res != null && res.message == "Login successful" && res.account != null) {
      CommonUtils().savePref("id", res.account!.id.toString());
      CommonUtils().savePref("idUserInfo", res.idUserInfo.toString());
      if(res.account?.isCollectionInfo==0){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Introduce()),
        );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainAct()),
        );
      }
    } else {
      await Fluttertoast.showToast(
        msg: "Sai tài khoản, mật khẩu hoặc kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _loginAdmin(String username, String password) async {
    final req = AccountReq(userName: username, passWord: password);
    final res = await SeverApi().loginAdmin(req);
    if (res != null && res.message == "Login successful") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainActAdmin()),
        );
    } else {
      await Fluttertoast.showToast(
        msg: "Sai tài khoản, mật khẩu hoặc kết nối không ổn định!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
