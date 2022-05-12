import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'Welcomescreen.dart';

final _firestory = FirebaseFirestore.instance;
late User signedInUser;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const String screenRoute = 'ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? messageText;
  final _auth = FirebaseAuth.instance;

  final messageTextController = TextEditingController();

  @override
  void initState() {
    getcurreqtUser();
    super.initState();
  }

  void getcurreqtUser() {
    try {
      // ignore: unused_local_variable
      final user = _auth.currentUser;
      if (user != null) {
        signedInUser = user;
        // ignore: avoid_print
        print(signedInUser.email);
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(children: [
          Image.asset(
            'images/logo.png',
            height: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text('Chat'),
        ]),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.popAndPushNamed(context, Welcomescreen.screenRoute);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const MessageStreem(),
          Container(
            decoration: const BoxDecoration(
                border:
                    Border(top: BorderSide(color: Colors.orange, width: 2))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: messageTextController,
                    onChanged: (value) {
                      messageText = value;
                    },
                    decoration: const InputDecoration(
                        hintText: 'Write your message here ....',
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20)),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestory.collection('messages').add({
                      'text': messageText,
                      'sender': signedInUser.email,
                      'time': FieldValue.serverTimestamp(),
                    });
                  },
                  child: Text(
                    'Send',
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}

class MessageLinne extends StatelessWidget {
  const MessageLinne({this.text, this.sender, required this.isMy, Key? key})
      : super(key: key);
  final String? text;
  final String? sender;
  final bool isMy;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isMy ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$sender',
            style: TextStyle(color: Colors.yellow[900], fontSize: 12),
          ),
        ),
        Material(
          elevation: 5,
          borderRadius: isMy
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )
              : const BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
          color: isMy ? Colors.blue[800] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              '$text ',
              style: TextStyle(color: isMy ? Colors.white : Colors.black45),
            ),
          ),
        ),
      ],
    );
  }
}

class MessageStreem extends StatelessWidget {
  const MessageStreem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: _firestory.collection('messages').orderBy('time').snapshots(),
      builder: (context, snapshot) {
        List<MessageLinne> messageWigets = [];
        if (!snapshot.hasData) {
          return const Center();
        }
        final messages = snapshot.data!.docs;
        for (var message in messages) {
          final messageText = message.get('text');
          final messageSender = message.get('sender');
          final currentUser = signedInUser.email;

          final messageWiget = MessageLinne(
            text: messageText,
            sender: messageSender,
            isMy: currentUser == messageSender,
          );
          messageWigets.add(messageWiget);
        }
        return Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageWigets,
          ),
        );
      },
    );
  }
}
