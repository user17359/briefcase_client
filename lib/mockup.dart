import 'package:briefcase_client/progress_screen.dart';

class Result{

}

class Batch{
  bool complete = false;
  int progress = 0;
  int total = 15;
  Result result = Result();
}

void getStatus(Batch from, Batch to, int sampling, Function refresh) async{
  while(to.complete == false) {
    to.progress = from.progress;
    to.complete = from.complete;
    await Future.delayed(Duration(seconds: sampling), (){});
    refresh(to.complete);
  }
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