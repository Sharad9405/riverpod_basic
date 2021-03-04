import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}
final incrementProvider = ChangeNotifierProvider((ref) => IncrementNotifier());


final firstStringProvider = Provider((ref) => 'First');
final secondStringProvider = Provider((ref) => 'Second');


class MyApp extends ConsumerWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final first = watch(firstStringProvider);
    final second = watch(secondStringProvider);

    return MaterialApp(
      title: 'Riverpod Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riverpod Tutorial'),
        ),
        body: Container(
          child: Center(
            child: Consumer(
              builder:  (context, watch, child) {
                final incrementNotifier = watch(incrementProvider);
                return Text(incrementNotifier.value.toString());
              },
            ),
          ),
       /*   child: Center(
            child: Column(
              children: [
                Text(first),
                Text(second),
              ],
            ),
          ),*/
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            context.read(incrementProvider).increment();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class IncrementNotifier extends ChangeNotifier{
  int _value = 0;
  int get value => _value;

  void increment(){
    _value++;
    notifyListeners();
  }




}




