import 'package:agumentik_task/showUsers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool isDataFilled = false;
  bool isUploadingData = false;
  TextEditingController nameCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController qualificationCon = TextEditingController();
  TextEditingController xpController = TextEditingController();
  TextEditingController xpController2 = TextEditingController();
  bool isEmpty() {
    setState(() {
      if (nameCon.text.length > 2 &&
          phoneCon.text.length > 9 &&
          qualificationCon.text.length >= 2 &&
          xpController.text.length > 0 &&
          xpController2.text.length > 2) {
        isDataFilled = true;
      } else {
        isDataFilled = false;
      }
    });
    return isDataFilled;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Users",
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameCon,
                onChanged: (val) {
                  isEmpty();
                },
                keyboardType: TextInputType.name,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Colors.black45,
                      width: 2.0,
                    ),
                  ),
                  hintText: "Your Name",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: phoneCon,
                onChanged: (val) {
                  isEmpty();
                },
                maxLength: 10,
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone_android_rounded),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Colors.black45,
                      width: 2.0,
                    ),
                  ),
                  hintText: "Phone Number",
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextFormField(
                controller: qualificationCon,
                onChanged: (val) {
                  isEmpty();
                },
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Colors.black45,
                      width: 2.0,
                    ),
                  ),
                  hintText: "Qualification",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: xpController,
                onChanged: (val) {
                  isEmpty();
                },
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.pan_tool),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Colors.black45,
                      width: 2.0,
                    ),
                  ),
                  hintText: "Experience in years",
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: xpController2,
                onChanged: (val) {
                  isEmpty();
                },
                keyboardType: TextInputType.text,
                maxLength: 8,
                style: TextStyle(fontSize: 16.0),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.build),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    borderSide: BorderSide(
                      color: Colors.black45,
                      width: 2.0,
                    ),
                  ),
                  hintText: "Area of Specialization",
                ),
              ),
              ElevatedButton.icon(
                onPressed: isDataFilled || isUploadingData
                    ? () async {
                        setState(() {
                          isUploadingData = true;
                        });
                        final QuerySnapshot result = await FirebaseFirestore
                            .instance
                            .collection("users")
                            .where('userPhone', isEqualTo: phoneCon.text)
                            .get();
                        final List<DocumentSnapshot> userdocs = result.docs;
                        if (userdocs.isEmpty) {
                          FirebaseFirestore.instance
                              .collection('/users')
                              .doc()
                              .set({
                            'userName': nameCon.text,
                            'userPhone': phoneCon.text,
                            'qualification': qualificationCon.text,
                            'experience': xpController.text,
                            'specilization': xpController2.text,
                            'createdAt': DateTime.now(),
                          }).catchError((e) {
                            print(e);
                          }).then((value) => {
                                    Fluttertoast.showToast(
                                        msg:
                                            "${nameCon.text} Registered Successfully ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                        textColor: Colors.white,
                                        fontSize: 16.0),
                                    setState(() {
                                      isDataFilled = false;
                                      isUploadingData = false;
                                    }),
                                    print("data uploaded"),
                                    qualificationCon.text = '',
                                    phoneCon.text = "",
                                    nameCon.text = "",
                                    xpController.text = "",
                                    xpController2.text = "",
                                  });
                        } else {
                          setState(() {
                            isDataFilled = false;
                          });
                          Fluttertoast.showToast(
                              msg: "user Already Exists!!!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          print("data uploaded");
                          qualificationCon.text = '';
                          phoneCon.text = "";
                          nameCon.text = "";
                          xpController.text = "";
                          xpController2.text = "";
                        }
                      }
                    : null,
                icon: !isUploadingData
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Icon(Icons.security),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Icon(Icons.upload_file),
                      ),
                label: !isUploadingData
                    ? Text("Register user")
                    : Text("Uploading Please wait"),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => ShowUsers()),
                    );
                  },
                  child: Text("Show Users"))
            ],
          ),
        ),
      ),
    );
  }
}
