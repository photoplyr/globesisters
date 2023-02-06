import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:globesisters/util/appTheme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with TickerProviderStateMixin {
  final TextEditingController _headerController = TextEditingController(text: "");
  final TextEditingController _commentController = TextEditingController(text: "");
  File? _imageFile;
  List photos = [];

  bool showButton = false;
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void postCallback() {}

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var bottom = MediaQuery.of(context).viewInsets.bottom;

    bool isLoading = false;

    return LoadingOverlay(
        isLoading: isLoading,
        color: Colors.black,
        opacity: 0.5,
        progressIndicator: const CircularProgressIndicator(),
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: AppTheme.white,
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: const Text('Share something',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.charcole,
                              fontSize: 20.0,
                            ))),

                    Container(
                      margin: const EdgeInsets.only(left: 15, right: 15),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: AppTheme.charcole, fontWeight: FontWeight.bold),
                        textCapitalization: TextCapitalization.sentences,
                        controller: _headerController,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          hintMaxLines: 1,
                          hintText: "Subject",
                          hintStyle: TextStyle(fontSize: 16.0, color: AppTheme.lightGrey, fontWeight: FontWeight.normal),
                        ),
                        onChanged: (value) {
                          if (_headerController.text.length > 30) {
                            showButton = false;
                          } else {
                            if (_headerController.text.isNotEmpty || _commentController.text.isNotEmpty || _imageFile != null) {
                              setState(() {
                                showButton = true;
                              });
                            } else {
                              setState(() {
                                showButton = false;
                              });
                            }
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter missing fields";
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(
                      constraints: BoxConstraints(
                        maxHeight: height - bottom - 200,
                        minHeight: 50.0,
                      ),
                      margin: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,

                        style: const TextStyle(color: AppTheme.charcole, fontWeight: FontWeight.normal),
                        // autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
                        controller: _commentController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintMaxLines: 16,
                          hintText: "Share more here",
                          hintStyle: TextStyle(fontSize: 16.0, color: AppTheme.lightGrey, fontWeight: FontWeight.normal),
                        ),
                        onChanged: (value) {
                          if (_headerController.text.isNotEmpty || _commentController.text.isNotEmpty) {
                            setState(() {
                              showButton = true;
                            });
                          } else {
                            setState(() {
                              showButton = false;
                            });
                          }
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter missing fields";
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(height: 1, color: AppTheme.topBorder),

                    Container(
                        margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                        child: Row(
                          children: const [
                            Text(('Upload Image'),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.charcole,
                                  fontSize: 20.0,
                                )),
                            Text((' (optional)'),
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: AppTheme.charcole,
                                  fontSize: 20.0,
                                )),
                          ],
                        )),

                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                      child: TextButton.icon(
                        icon: const Icon(Icons.add_photo_alternate, size: 30, color: AppTheme.selectButton),
                        onPressed: () {
                          showCupertinoModalPopup(context: context, builder: (BuildContext context) => _actionSheet(context));
                        },
                        label: Text((photos.isEmpty ? "Upload Images" : "Upload More Images"),
                            style: const TextStyle(
                              color: AppTheme.charcole,
                              fontSize: 16.0,
                            )),
                      ),
                    ),

                    Container(height: 1, color: AppTheme.topBorder),

                    if (photos.isNotEmpty)
                      Stack(
                        children: [
                          SizedBox(
                            width: width,
                            height: 400,
                            child: PageView(
                                scrollDirection: Axis.horizontal,
                                pageSnapping: true,
                                children: List.generate(photos.length, (index) {
                                  return Stack(children: [
                                    SizedBox(
                                      width: width,
                                      height: 400,
                                      child: Image.file(File(photos[index]), fit: BoxFit.cover),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: RawMaterialButton(
                                            onPressed: () {
                                              setState(() {
                                                photos.remove(photos[index]);
                                              });
                                            },
                                            elevation: 2.0,
                                            fillColor: Colors.white,
                                            // padding: EdgeInsets.all(15.0),
                                            shape: const CircleBorder(),
                                            child: const Icon(
                                              Icons.close,
                                              size: 25.0,
                                            ),
                                          )),
                                    ),
                                  ]);
                                })),
                          )
                        ],
                      ),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(height: 1, color: AppTheme.topBorder),
                    ),

                    Center(
                      child: SizedBox(
                          width: 150, //260.0,
                          height: 45,
                          child: TextButton(
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all<Color>((showButton == true ? AppTheme.white : AppTheme.geyText)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>((showButton == true ? AppTheme.selectButton : AppTheme.greyBackground)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0), side: BorderSide(color: AppTheme.white)))),
                            child: const Text('Post'),
                            // color: (showLogin == true ? AppTheme.selectButton : AppTheme.greyBackground),
                            // textColor: (showLogin == true ? AppTheme.white : AppTheme.geyText),
                            onPressed: () {},
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _actionSheet(context) {
    return CupertinoActionSheet(
      title: const Text("Create Post"),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text("Take Photo"),
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            XFile? pickedFile = await picker.pickImage(
              source: ImageSource.gallery,
              maxWidth: 1000.0,
              maxHeight: 1000.0,
              imageQuality: 100,
            );

            setState(() {
              if (pickedFile != null) {
                File file = File(pickedFile.path);
                _imageFile = file;
                photos.add(pickedFile.path);

                setState(() {
                  showButton = true;
                });
              }
            });
          },
        ),
        CupertinoActionSheetAction(
          child: const Text("Choose Gallery"),
          onPressed: () async {
            final ImagePicker picker = ImagePicker();
            XFile? pickedFile = await picker.pickImage(
              source: ImageSource.gallery,
              maxWidth: 1000.0,
              maxHeight: 1000.0,
              imageQuality: 100,
            );

            setState(() {
              if (pickedFile != null) {
                File file = File(pickedFile.path);
                photos.add(pickedFile.path);
                _imageFile = file;
              }
            });

            Navigator.pop(context, 'Cancel');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
        child: const Text("Cancel"),
      ),
    );
  }
}
