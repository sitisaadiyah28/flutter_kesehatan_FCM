import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kesehatan/constant/ConstantFile.dart';


class DetailPage extends StatefulWidget {
  String judul, deskripsi, image;

  DetailPage({this.judul, this.deskripsi, this.image});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.judul),
        backgroundColor: Colors.green[500],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height/3,

                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(ConstantFile().imageUrl + widget.image,),
                        fit: BoxFit.cover
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.judul, style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.deskripsi,
                  style: TextStyle(
                      fontSize: 16
                  ),
                  textAlign: TextAlign.justify,
                ),
              )

            ],
          )

        ],
      ),
    );
  }
}
