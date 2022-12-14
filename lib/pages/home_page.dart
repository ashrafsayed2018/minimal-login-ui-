import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:minimal_login_ui/constants/colors.dart';
import 'package:minimal_login_ui/read_data/get_user_name.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = FirebaseAuth.instance.currentUser;

  // list of docs id

  List<String> docIds = [];
  // get the docs ids

  Future getDocsIds() async {
    await FirebaseFirestore.instance
        .collection("users")
        .orderBy("age", descending: true)
        .get()
        .then(
      (snapshot) {
        for (var document in snapshot.docs) {
          docIds.add(document.reference.id);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.kPrimaryColor,
        elevation: 0,
        title: Text(
          user!.email!,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Icon(Icons.logout),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder(
                future: getDocsIds(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return ListView.builder(
                    itemCount: docIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: AppColor.kLightGreyColor,
                          title: GetUserName(documentId: docIds[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: AppColor.kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: GNav(
              backgroundColor: AppColor.kPrimaryColor,
              color: Colors.grey.shade300,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.deepPurple.shade300,
              tabs: const [
                GButton(
                  padding: EdgeInsets.all(10),
                  gap: 8,
                  icon: Icons.home,
                  text: "Home",
                ),
                GButton(
                  padding: EdgeInsets.all(10),
                  gap: 8,
                  icon: Icons.favorite_border,
                  text: "Likes",
                ),
                GButton(
                  padding: EdgeInsets.all(10),
                  gap: 8,
                  icon: Icons.search,
                  text: "Search",
                ),
                GButton(
                  padding: EdgeInsets.all(10),
                  gap: 8,
                  icon: Icons.settings,
                  text: "Settings",
                ),
              ]),
        ),
      ),
    );
  }
}
