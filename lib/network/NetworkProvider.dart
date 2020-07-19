import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter_kesehatan/constant/ConstantFile.dart';
import 'package:flutter_kesehatan/model/ModelKesehatan.dart';
import 'package:http/http.dart' as http;


abstract class BaseEndpoint{

  Future<List> getInfoKesehatan(String id);
  void addInfoKesehatan(String judul, String deskripsi, File image);
  void sendNotification(String urlImage);
  void deleteInfo(String idKesehatan);
}

class NetworkProvider extends BaseEndpoint{

  @override
  Future<List> getInfoKesehatan(String id) async{
    // TODO: implement getNews
    final response = await http.post(ConstantFile().baseUrl + "getInfoKesehatan", body: {
      'iduser' : id
    });

    ModelKesehatan listData = modelKesehatanFromJson(response.body);

    return listData.kesehatan;
  }

  @override
  void addInfoKesehatan(String myJudul, String myDeskripsi, File image) async{
    // TODO: implement addNews
    var stream = http.ByteStream(DelegatingStream.typed(image.openRead()));
    var length = await image.length();
    var request = http.MultipartRequest('POST',Uri.parse(ConstantFile().baseUrl+"addInfoKesehatan")); // http.MultiparRequest

    var multipart = http.MultipartFile('image', stream,length,filename: image.path);

    request.files.add(multipart);
    request.fields['judul'] = myJudul;
    request.fields['deskripsi'] = myDeskripsi;
    var response = await request.send();
    if(response.statusCode == 200){
      print("Image Uploaded");
    }else{
      print("Image Failed Uploaded");
    }

  }

  @override
  void sendNotification(String urlImage)async {
    // TODO: implement senNotification
    final body = jsonEncode({
      "to": "/topics/InternshipTopic",
      "topic" : "InternshipTopic",
      "notification" : {
        "body" : "This is a Firebase Cloud Messaging Topic Message!",
        "title" : "FCM Message",
        "sound" : "default",
        "image": urlImage
      },
      "data": {
        "body" : "This is a Firebase Cloud Messaging Topic Message!",
        "title" : "FCM Message",
        "sound" : "default",
        "image": urlImage
      }
    });
    await http.post("https://fcm.googleapis.com/fcm/send", headers: {
      HttpHeaders.contentTypeHeader : "application/json",
      HttpHeaders.authorizationHeader: ConstantFile().keyServer,
    }, body: body);
  }



  @override
  void deleteInfo(String idkesehatan) async{
    // TODO: implement deleteNews
    final response = await http.post(ConstantFile().baseUrl + "deleteInfo" , body: {
      'idkesehatan' : idkesehatan
    });

    var listData = jsonDecode(response.body);
    if(listData['status'] == 200){
      print(listData['message']);
    }else{
      print(listData['message']);
    }
  }



}