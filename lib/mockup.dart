import 'dart:convert';

import 'package:briefcase_client/main.dart';
import 'package:briefcase_client/progress_screen.dart';

import 'package:http/http.dart' as http;

class Result{

}

class Batch{
  bool complete = false;
  int progress = 0;
  int total = 1;
  Result result = Result();
}



void getStatus(Batch from, Batch to, int sampling, Function refresh) async{
  var uri = Uri.parse('http://3874-89-64-44-23.ngrok.io/batches/' + uid + '/progress');
  var request = http.Request('GET', uri);
  var response = await request.send();
  if (response.statusCode == 200) print('Start progress');
  else print('Error');
  String responseString =  await response.stream.bytesToString() ;

  int to_process = jsonDecode(responseString)['to_process'];

  to.total = to_process != 0 ? to_process: 1;
  refresh(to.complete);
  while(to.complete == false) {
    var uri = Uri.parse('http://3874-89-64-44-23.ngrok.io/batches/' + uid + '/progress');
    var request = http.Request('GET', uri);
    var response = await request.send();
    if (response.statusCode == 200) print('Next progress!');
    else print('Error');
    String responseString =  await response.stream.bytesToString() ;

    int processed = jsonDecode(responseString)['processed'];
    to_process = jsonDecode(responseString)['to_process'];
    to.progress = processed;
    to.total = to_process;
    if(to_process == processed) {
      to.complete = true;
      mockCategory = await getMap();
    }
    await Future.delayed(Duration(seconds: sampling), (){});
    refresh(to.complete);
  }
}

Future<Map<String, List<String>>> getMap() async{
  var uri = Uri.parse('http://3874-89-64-44-23.ngrok.io/batches/' + uid + '/images');
  var request = http.Request('GET', uri);
  var response = await request.send();
  if (response.statusCode == 200) print('Next progress!');
  else print('Error');
  String responseString =  await response.stream.bytesToString() ;
  Map<String, String> test = Map<String, String>.from(jsonDecode(responseString));
  Map<String, List<String>> result = getListFromStrings(test);
  return result;
}



Map<String, List<String>> getListFromStrings( Map<String, String> test){
  Map<String, List<String>> result = new Map();
  List<String> future_keys = test.values.toSet().toList();
  List<List<String>> future_values = [];

  for(var i = 0; i < future_keys.length; i++)
  {
    future_values.add([]);
  }

  for(var i = 0; i < test.keys.length; i++)
  {
    print(test.keys.elementAt(i));
    future_values[future_keys.indexOf(test.values.elementAt(i))].add(test.keys.elementAt(i));
  }
  for(var j = 0; j < future_keys.length; j++) {
    print(j);
    print("key");
    print(future_keys[j]);
    print("values");
    print(future_values[j]);
    result[future_keys[j]] = future_values[j];
  }
  return result;
}

Map<String, List<String>>  mockCategory = {
  "Agreements": ['https://github.com/cat-milk/Anime-Girls-Holding-Programming-Books/blob/master/Rust/Squid_Girl_Ikamusume_recommends_Rust.jpg?raw=true'],
  "Invoices": ['https://github.com/cat-milk/Anime-Girls-Holding-Programming-Books/blob/master/Rust/Suigintou_The_Rust_Lang.jpg?raw=true'],
  "Judicial decisions": ['https://github.com/cat-milk/Anime-Girls-Holding-Programming-Books/blob/master/Rust/Koukaku_no_Pandora_Rust_Programming.jpg?raw=true', 'https://github.com/cat-milk/Anime-Girls-Holding-Programming-Books/blob/master/Rust/Miyamizu_Mitsuha_On_Ownership_And_Borrowing.jpg?raw=true'],
  "Payment confirmations": ['https://github.com/cat-milk/Anime-Girls-Holding-Programming-Books/blob/master/Rust/Kanna_Kamui_Finds_RUST_programming.jpg?raw=true'],
  "Pleadings": ['https://github.com/cat-milk/Anime-Girls-Holding-Programming-Books/blob/master/Math/Kagari_Atsuko_discrete_maths.jpg?raw=true', 'https://github.com/cat-milk/Anime-Girls-Holding-Programming-Books/blob/master/Math/Tomoko_Kuroki_Holding_Discrete_Mathematics.jpg?raw=true'],
  "Power of attorney": ['https://raw.githubusercontent.com/cat-milk/Anime-Girls-Holding-Programming-Books/master/HolyC/Sakurajima_Mai_Holding_The_HolyC_Programming_Language.jpg', 'https://raw.githubusercontent.com/cat-milk/Anime-Girls-Holding-Programming-Books/master/Kotlin/Misato_and_Shinji_Discovering_Kotlin.jpg', 'https://raw.githubusercontent.com/cat-milk/Anime-Girls-Holding-Programming-Books/master/Dart/Fujiwara_Chika_Dart_Apprentice.png']
};


void mockBatch(Batch target) async{
  await Future.delayed(const Duration(seconds: 2), (){});
  target.progress = 3;
  await Future.delayed(const Duration(seconds: 2), (){});
  target.progress = 7;
  await Future.delayed(const Duration(seconds: 2), (){});
  target.progress = 12;
  await Future.delayed(const Duration(seconds: 2), (){});
  target.progress = 15;
  target.complete = true;
}