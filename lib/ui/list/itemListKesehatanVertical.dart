import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kesehatan/constant/ConstantFile.dart';
import 'package:flutter_kesehatan/model/ModelKesehatan.dart';
import 'package:flutter_kesehatan/network/NetworkProvider.dart';
import 'package:flutter_kesehatan/ui/detail/DetailPage.dart';
import 'package:intl/intl.dart';

class itemListInfoVertical extends StatefulWidget {
  List list;
  itemListInfoVertical({this.list});
  @override
  _itemListInfoVerticalState createState() => _itemListInfoVerticalState();
}

class _itemListInfoVerticalState extends State<itemListInfoVertical> {
  BaseEndpoint network = NetworkProvider();

  var dateFormate;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          Kesehatan data = widget.list[index];
          dateFormate = DateFormat("dd-MM-yyyy").format(data.date);
          return Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              child: Card(
                elevation: 1,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      flex: 4,
                      child: Container(
                        height: 130,
                        width: 130,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              ConstantFile().imageUrl + data.image,
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Flexible(
                      flex: 8,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                    judul: data.judul,
                                                    deskripsi: data.deskripsi,
                                                    image: data.image,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        data.judul,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.deepOrange),
                                        maxLines: 3,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.BOTTOMSLIDE,
                                        tittle: 'Warning!!',
                                        desc:
                                            'Do you Want delete this product?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () async {
                                          network.deleteInfo(data.idKesehatan);
                                          setState(() {
                                            widget.list.removeAt(index);
                                          });
                                          await network.getInfoKesehatan("");
                                        }).show();
                                  },
                                  icon: Icon(Icons.close),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left : 8.0, top: 5),
                              child: Text(
                                dateFormate
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 5),
                              child: Text(
                                data.deskripsi,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
