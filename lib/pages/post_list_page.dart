import 'package:flutter/material.dart';

import '../util/appTheme.dart';

class PostListPage extends StatefulWidget {
  const PostListPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> with TickerProviderStateMixin {
  final _items = [];
  String? valueText;

  // The key of the list
  final GlobalKey<AnimatedListState> _key = GlobalKey();
  final TextEditingController _textFieldController = TextEditingController(text: "");

  void _addItem(String string) {
    _items.insert(0, string);
    _key.currentState!.insertItem(0, duration: const Duration(seconds: 0));
  }

  void _removeItem(int index) {
    _key.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: const EdgeInsets.all(10),
          elevation: 1,
          // color: AppTheme.pillRed,
          child: const ListTile(
            contentPadding: EdgeInsets.all(15),
          ),
        ),
      );
    }, duration: const Duration(seconds: 0));

    _items.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.greyBackground,
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: AnimatedList(
          key: _key,
          initialItemCount: 0,
          itemBuilder: (_, index, animation) {
            return SizeTransition(
              key: UniqueKey(),
              sizeFactor: animation,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.all(5),
                elevation: 1,
                // color: AppTheme.,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  title: Text(_items[index], style: const TextStyle(fontSize: 20)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removeItem(index),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAlert,
        child: const Icon(Icons.add),
      ),
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value) ? 'Enter a valid email address' : null;
  }

  Future<void> showAlert() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Email Address"),
            content: Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    // hintText: 'Enter a valid email adddress',
                  ),
                  validator: validateEmail,
                  onChanged: (value) {
                    setState(() {
                      valueText = value;
                    });
                  },
                  controller: _textFieldController,
                )),
            actions: <Widget>[
              TextButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(AppTheme.white),
                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.selectButton),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: AppTheme.white)))),
                child: const Text('Post'),
                onPressed: () {
                  if (validateEmail(_textFieldController.text) == null) {
                    _addItem(_textFieldController.text);
                    _textFieldController.text = "";
                  }
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
