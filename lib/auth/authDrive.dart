import 'package:googleapis/drive/v3.dart' as ga;
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import 'package:url_launcher/url_launcher.dart';

const _clientId = "314424021152-tl05pfvk1fseiumudr5jd01kuhfh1551.apps.googleusercontent.com";
const _clientSecret = "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";
const _scopes = [ga.DriveApi.driveFileScope];


class GoogleDrive{

  // Get Authenticated Http Client
  Future <http.Client> getHttpClient() async{
    print('eeeee');
    var authClient = await clientViaUserConsent(ClientId(_clientId,_clientSecret),_scopes, (url){
    //open an external Browser
      launch(url);
    });
    return authClient;
   }

}