import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.strUrl);

  final String strUrl;

  dynamic callGetUrl() async {
    var url = Uri.parse(strUrl);
    http.Response res = await http.get(url);
    if (res.statusCode == 200 && res.body != null) {
      return res.body;
    } else {
      return null;
    }
  }
}
