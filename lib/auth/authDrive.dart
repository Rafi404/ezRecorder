//
// import 'package:googleapis/drive/v3.dart' as ga;
// import 'package:googleapis_auth/auth_io.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
//
//
// const _clientId = "1043182525029-6raml9bjivjpd4skfhlpnk9l39kj30qg.apps.googleusercontent.com";
// const _clientSecret = "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";
// const _scopes = [ga.DriveApi.driveFileScope];
//
// class GoogleDrive{
//
//   //Get Authenticated Http Client
//   Future <http.Client> getHttpClient() async{
//     print('eeeee');
//     var authClient = await clientViaUserConsent(ClientId(_clientId,_clientSecret),_scopes, (url){
//     //open an external Browser
//       launch(url);
//
//     });
//     return authClient;
//    }
//
//
//   Future upload(file,length)async{
//     print("eeeeee");
//     final Stream<List> mediaStream =
//     Future.value([file]).asStream().asBroadcastStream();
//     var client = http.Client();
//     var drive = ga.DriveApi(client);
//     var driveFile =  ga.File();
//     driveFile.name = "MyAudio.txt";
//     var response = await drive.files.create(driveFile,uploadMedia: ga.Media(file,length));
//     print(response.toJson());
//
//   }
//
//
//   // Future upload()async{
//   //   print("asdasd");
//   //   var client = http.Client();
//   //   var drive = ga.DriveApi(client);
//   //
//   //   final Stream<List<int>> mediaStream =
//   //   Future.value([104, 105]).asStream().asBroadcastStream();
//   //   var media =  ga.Media(mediaStream, 2);
//   //   var driveFile =  ga.File();
//   //   driveFile.name = "hello_world.txt";
//   //   final result = await drive.files.create(driveFile, uploadMedia: media);
//   //   print("Upload result: $result");
//   // }
// }