import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_kesehatan/constant/ConstantFile.dart';
import 'package:flutter_kesehatan/network/NetworkProvider.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  File _image;
  BaseEndpoint network = NetworkProvider();


  TextEditingController etTitle = TextEditingController();
  TextEditingController etContent = TextEditingController();
  TextEditingController etDescription = TextEditingController();

  Future getImage(ImageSource media)async{
    var img = await ImagePicker.pickImage(source: media);
    if(img != null){
      setState(() {
        _image = img;
      });
    }
  }

  void myAlert(){
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text("Please choose media to select"),
            content: Container(
              height: MediaQuery.of(context).size.height/6.5,
              child: Column(
                children: <Widget>[
                  FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                        ),
                        Text("From Galery")
                      ],
                    ),
                  ),
                  FlatButton(
                    onPressed: (){
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                        ),
                        Text("From Camera")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "New Info",
          style: TextStyle(
              color: Colors.green
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () async{
              network.addInfoKesehatan(etTitle.text.toString(), etDescription.text.toString(), _image);
              await network.getInfoKesehatan("");
              Navigator.pop(context);
              network.sendNotification(ConstantFile().imageUrl+ path.basename( _image.path));
            },
            child: Text("Posting"),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              TextFormField(
                controller: etTitle,
                minLines: 2,
                maxLines: 5,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: "Judul"
                ),
              ),

              TextFormField(
                controller: etDescription,
                maxLines: 15,
                minLines: 10,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: "Deskripsi"
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: _image == null
                      ? Center()
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      _image,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height/5,
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: RaisedButton(
                  onPressed: (){
                    myAlert();
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  color: Colors.green,
                  child: Text('Select Image',style: TextStyle(
                      color: Colors.white
                  ),),
                ),
              )
            ],
          )

        ],
      ),
    );
  }
}
