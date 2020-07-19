import 'package:flutter/material.dart';
import 'package:flutter_kesehatan/constant/ConstantFile.dart';
import 'package:flutter_kesehatan/model/ModelKesehatan.dart';
import 'package:flutter_kesehatan/ui/detail/DetailPage.dart';


class listItemInfoHorizontal extends StatelessWidget {
  List list;
  listItemInfoHorizontal({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index){
        Kesehatan data = list[index];
        return  Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(
                    judul : data.judul,
                    deskripsi : data.deskripsi,
                    image : data.image,
                  )));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(ConstantFile().imageUrl + data.image,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(16),
                  width: 120,
                  child: Text(data.judul, style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16
                  ),),
                ),
              )
            ],

          ),
        );
      },

    );
  }
}