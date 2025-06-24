import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splitin_frontend/constants/splitin_colors.dart';
import 'package:splitin_frontend/models/provider.dart';
import 'package:splitin_frontend/models/user.dart';
import 'package:splitin_frontend/widgets/bottom_navigation_bar.dart';
import 'package:splitin_frontend/widgets/floating_action_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _currentUser;

  void profileDialog(
    // Map currentUser,
    Text title,
    Icon title_icon,
    Text content,
    List<Widget> dialog_action,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              title_icon,
              SizedBox(width: 8),
              // Text("Error!!"),
              title,
            ],
          ),
          content: content,
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: dialog_action,
        ),
      ),
    );
  }

  void refreshPage() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ProviderModel>().changeProfileInitState();
      Map currentUser = await getUser();
      print(
        "profile init state = ${context.read<ProviderModel>().profileInitProcess}",
      );
      print(currentUser['data']);
      if (currentUser['data'] != null) {
        _currentUser = User(
          username: currentUser['data']['username'],
          email: currentUser['data']['email'],
          phone_number: currentUser['data']['phone_number'] ?? "",
          student_id: currentUser['data']['student_id'] ?? "",
        );
        if (context.read<ProviderModel>().profileEditState)
          context.read<ProviderModel>().changeProfileEditState();

        context.read<ProviderModel>().emailController.text =
            currentUser['data']['email'];

        context.read<ProviderModel>().usernameController.text =
            currentUser['data']['username'];
        context.read<ProviderModel>().phoneNumberController.text =
            currentUser['data']['phone_number'] ?? "";
        context.read<ProviderModel>().studentIDController.text =
            currentUser['data']['student_id'] ?? "";
      } else {
        profileDialog(
          Text("Error!!"),
          Icon(Icons.close_rounded, color: Colors.red),
          Text(currentUser['message']),
          <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                context.read<ProviderModel>().authController.deleteToken();
                Navigator.pushReplacementNamed(context, "/");
                context.read<ProviderModel>().clearAllForm();
                context.read<ProviderModel>().changeIndex(0);
              },
              child: Text("OK", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      }
      context.read<ProviderModel>().changeProfileInitState();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshPage();
  }

  Future<Map> getUser() async {
    return await context.read<ProviderModel>().authController.getUserSession;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FittedBox(
            fit: BoxFit.fill,
            child: SplitinFloatingActionButton(),
          ),
        ),
        bottomNavigationBar: SplitInNavBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Profil",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/person.jpeg"),
                    // Replace with NetworkImage if you use a URL
                  ),
                ),
                const SizedBox(height: 30),
                _buildField("Username", value.usernameController, "Username"),
                _buildField("Email", value.emailController, "Email"),
                _buildField(
                  "Nomor Telepon",
                  value.phoneNumberController,
                  "Nomor Telepon belum diatur",
                ),
                _buildField(
                  "Student ID",
                  value.studentIDController,
                  "Student ID belum diatur",
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async {
                          value.changeProfileEditState();

                          if (value.profileEditState) {
                            _currentUser = User(
                              username: value.usernameController.text,
                              email: value.emailController.text,
                              phone_number: value.phoneNumberController.text,
                              student_id: value.studentIDController.text,
                            );
                          } else if (value.usernameController.text == "") {
                            profileDialog(
                              Text("Form Error"),
                              Icon(Icons.close_rounded, color: Colors.red),
                              Text("Username tidak boleh kosong"),
                              [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                    value.changeProfileEditState();
                                  },
                                  child: Text(
                                    "Kembali Mengedit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          } else if (value.emailController.text == "" ||
                              !value.checkEmailValidation()) {
                            profileDialog(
                              Text("Form Error"),
                              Icon(Icons.close_rounded, color: Colors.red),
                              Text("Format email tidak valid"),
                              [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                    value.changeProfileEditState();
                                  },
                                  child: Text(
                                    "Kembali Mengedit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          } else if (value.phoneNumberController.text != "" &&
                              ((value.phoneNumberController.text.length < 10 ||
                                      value.phoneNumberController.text.length >
                                          13) ||
                                  int.tryParse(
                                        value.phoneNumberController.text,
                                      ) ==
                                      null)) {
                            profileDialog(
                              Text("Form Error"),
                              Icon(Icons.close_rounded, color: Colors.red),
                              Text(
                                "phone number harus angka dan harus memiliki panjang antara 10 dan 13",
                              ),
                              [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                    value.changeProfileEditState();
                                  },
                                  child: Text(
                                    "Kembali Mengedit",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            bool getRequest = false;
                            profileDialog(
                              Text("Perubahan Biodata"),
                              Icon(Icons.question_mark),
                              Text("Apakah kamu yakin ingin merubah data"),
                              [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () async {
                                    Map updatedUser = await value.authController
                                        .updateUser(
                                          value.usernameController.text,
                                          value.emailController.text,

                                          value.phoneNumberController.text == ''
                                              ? null
                                              : value
                                                    .phoneNumberController
                                                    .text,
                                          value.studentIDController.text == ''
                                              ? null
                                              : value.studentIDController.text,
                                        );
                                        print("UPDATE : ${updatedUser}");
                                    if (updatedUser['data'] != null) {
                                      _currentUser = User(
                                        username: value.usernameController.text,
                                        email: value.emailController.text,
                                        phone_number:
                                            value.phoneNumberController.text,
                                        student_id:
                                            value.studentIDController.text,
                                      );
                                      Navigator.of(context).pop(false);
                                      profileDialog(
                                        Text("Update User"),
                                        Icon(Icons.check, color: Colors.green),
                                        Text("Biodata Berhasil Diubah"),
                                        [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                              refreshPage();
                                            },
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    } else {
                                      profileDialog(
                                        Text("Update Error"),
                                        Icon(
                                          Icons.close_rounded,
                                          color: Colors.red,
                                        ),
                                        Text(updatedUser["message"]),
                                        [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                              Navigator.of(context).pop(false);
                                              refreshPage();
                                            },
                                            child: Text(
                                              "OK",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                    value.usernameController.text =
                                        _currentUser!.username;
                                    value.emailController.text =
                                        _currentUser!.email;
                                    value.phoneNumberController.text =
                                        _currentUser!.phone_number;
                                    value.studentIDController.text =
                                        _currentUser!.student_id;
                                  },
                                  child: Text(
                                    "Batalkan",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: value.profileEditState
                              ? Colors.blue
                              : Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: value.profileEditState
                            ? Text(
                                "Save",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      18, // increase or decrease font size here
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      18, // increase or decrease font size here
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // action
                          if (value.profileEditState) {
                            value.changeProfileEditState();
                            value.emailController.text = _currentUser!.email;
                            value.usernameController.text =
                                _currentUser!.username;
                            value.studentIDController.text =
                                _currentUser!.student_id;
                            value.phoneNumberController.text =
                                _currentUser!.phone_number;
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Sign Out Pengguna'),
                                content: Text('Apakah kamu yakin bos?'),

                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(
                                      context,
                                    ).pop(false), // Cancel
                                    child: Text('Tidak'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      value.authController.deleteToken();

                                      Navigator.pushReplacementNamed(
                                        context,
                                        "/",
                                      );
                                      value.changeIndex(0);

                                      value.clearAllForm();
                                    }, // Confirm
                                    child: Text('Iya'),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: value.profileEditState
                              ? SplitinColors.orange_star_color
                              : Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          value.profileEditState ? "Cancel" : "Logout",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18, // increase or decrease font size here
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    TextEditingController controller,
    String labelText,
  ) {
    return Consumer<ProviderModel>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F3F3),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: value.profileInitProcess ? Alignment.center : null,
            child: value.profileInitProcess
                ? CircularProgressIndicator(
                    color: SplitinColors.register_font_color,
                  )
                : TextField(
                    controller: controller,
                    obscureText: false,
                    enabled: value.profileEditState,
                    style: const TextStyle(fontSize: 15, color: Colors.black87),

                    decoration: InputDecoration(
                      hintText: value.profileEditState ? label : labelText,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: value.profileEditState
                            ? BorderSide(color: Colors.black, width: 2)
                            : BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: value.profileEditState
                            ? BorderSide(color: Colors.black, width: 2)
                            : BorderSide.none,
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
