import 'package:flutter/material.dart';
import 'package:note_taking_app/constants.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

final titleController = TextEditingController();
final textController = TextEditingController();

class AddNoteScreen extends StatelessWidget {
  final String EMAIL;

  const AddNoteScreen({Key? key, required this.EMAIL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Add Note"),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(
          vertical: kDefaultSmallPadding * 1.5,
          horizontal: kDefaultSmallPadding / 2,
        ),
        child: FloatingActionButton(
          onPressed: () {
            final note = ParseObject("note");
            note.set("email", EMAIL);
            note.set("title", titleController.text);
            note.set("text", textController.text);
            note.save();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Note Added!"),
                action: SnackBarAction(
                  label: "UNDO",
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );

            Navigator.pop(context);
          },
          child: Icon(
            Icons.done_outlined,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
      body: AddNoteBody(),
    );
  }
}

class AddNoteBody extends StatelessWidget {
  const AddNoteBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(kDefaultSmallPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: kDefaultSmallPadding),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.blue,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.symmetric(vertical: kDefaultSmallPadding),
            height: size.height / 8,
            child: TextField(
              controller: titleController,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: kDefaultSmallPadding),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blue,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.symmetric(vertical: kDefaultSmallPadding),
              child: TextField(
                controller: textController,
                style: TextStyle(
                  fontSize: 20,
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: "Body",
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
