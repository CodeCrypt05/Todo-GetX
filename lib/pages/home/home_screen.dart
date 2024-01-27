import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/components/home_components/empty_screen.dart';
import 'package:todo_app/pages/home/home_controller.dart';
import 'package:todo_app/pages/signin/signin_controller.dart';
import 'package:todo_app/routes/app_page.dart';
import 'package:todo_app/services/firebase/firebase_cloud_messaging.dart';
import 'package:todo_app/services/firebase/notification_services.dart';
import 'package:todo_app/theme/colors.dart';

import 'package:todo_app/widget/appdrawer.dart';
import 'package:todo_app/widget/bottom_appbar.dart';
import 'package:todo_app/widget/task_tile.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();
  // final homeController = Get.put(HomeController());
  // final signinController = Get.find<SigninController>();
  final signinController = Get.put(SigninController());

  final FirebaseCloudMessaging firebaseCloudMessaging =
      FirebaseCloudMessaging();

  final player = AudioPlayer();

  Future<void> playAudio() async {
    String audioPath = "assets/audio/bubble_click.wav";
    String url =
        "https://codeskulptor-demos.commondatastorage.googleapis.com/pang/pop.mp3";

    await player.play(
      UrlSource(url),
    );
  }

  @override
  Widget build(BuildContext context) {
    Query<Map<String, dynamic>> querySnapshot = FirebaseFirestore.instance
        .collection('task_list')
        .doc(signinController.auth.currentUser!.uid)
        .collection('notes')
        .orderBy(
          'isCompleted',
        );

    return Scaffold(
      bottomNavigationBar: BottomAppbarWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeController.gotoAddNewTaskScreen();
        },
        backgroundColor: kColorPrimary,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: kColorWhite,
          size: 24.h,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
      ),
      drawer: AppDrawerWidget(onClearData: () {
        signinController.onClearData();
      }),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
              stream: querySnapshot.snapshots(),
              builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.data!.docs.isNotEmpty) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          Map data = snapshot.data?.docs[index].data() as Map;
                          String task = data['task'];
                          bool isCompleted = data['isCompleted'];
                          String time = data['time'];
                          String date = data['date'];
                          bool isBellIc = data['bellIC'];

                          QueryDocumentSnapshot documentSnapshot =
                              snapshot.data!.docs[index];
                          String docID = documentSnapshot.reference.id;

                          // Schedule notification using NotificationService
                          // firebaseCloudMessaging
                          //     .scheduleNotification(documentSnapshot);

                          return Dismissible(
                            key: Key(docID),
                            background: const Card(
                              color: Colors.red,
                              child: Center(
                                child: Text(
                                  "Deleted",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              FirebaseFirestore.instance
                                  .collection('task_list')
                                  .doc(signinController.auth.currentUser!.uid)
                                  .collection('notes')
                                  .doc(docID)
                                  .delete();
                            },
                            child: TaskTile(
                              documentId: docID,
                              currentTime: time,
                              currentDate: date,
                              taskName: task.toString(),
                              taskCompleted: isCompleted,
                              onChanged: (value) {
                                print("pressed index: $index");
                                homeController.checkBoxChanged(value, index);
                                playAudio();
                              },
                              onDelete: (docId) {
                                FirebaseFirestore.instance
                                    .collection('task_list')
                                    .doc(signinController.auth.currentUser!.uid)
                                    .collection('notes')
                                    .doc(docID)
                                    .delete();
                              },
                              bellIc: isBellIc,
                            ),
                          );
                        },
                      ).reversed.toList(),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.only(top: 90.h),
                    child: Center(child: EmptyScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
