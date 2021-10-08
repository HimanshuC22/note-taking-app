import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_taking_app/add_note.dart';
import 'package:note_taking_app/constants.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

String? EMAIL;

List<List<String>>? list;

class Notes extends StatelessWidget {
  final String email;
  const Notes({Key? key, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EMAIL = email;
    list = getNotes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Notes, " + email.substring(0, email.indexOf("@"))),
      ),
      body: NotesBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddNoteScreen(EMAIL: email)));
        },
        child: Icon(
          Icons.add_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class NotesBody extends StatelessWidget {
  const NotesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<String>> data = [];

    Size size = MediaQuery.of(context).size;
    return ListView.builder(
      padding: EdgeInsets.all(kDefaultSmallPadding),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.black,
          margin: EdgeInsets.symmetric(vertical: kDefaultSmallPadding / 2),
          height: size.height / 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.pink,
                child: Text((index + 1).toString()),
              ),
              Container(
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data[index][0]),
                    Text(data[index][1]),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

getNotes() async {
  List<List<String>>? list = [];
  final QueryBuilder<ParseObject> parseQuery =
      QueryBuilder<ParseObject>(ParseObject("note"));
  parseQuery.whereContains("email", EMAIL!);
  final ParseResponse apiResponse = await parseQuery.query();
  if (apiResponse.success && apiResponse.results != null) {
    for (var i in apiResponse.results!) {
      list.add(
          [(i as ParseObject).get("title"), (i as ParseObject).get("text")]);
    }
  }
  return list;
}
