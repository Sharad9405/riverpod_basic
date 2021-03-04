import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() =>
    runApp(
        ProviderScope(
          child: MaterialApp(
            home: MyApp(),
          ),
        ));

class FakeHttpClient {
  Future<String> get(String url) async {
    await Future.delayed(const Duration(seconds: 1));
    return 'Response from $url';
  }
}

final fakeHttpClientProvider = Provider((ref) => FakeHttpClient());
// final responseProvider = FutureProvider.family<String, String>((ref, url) async {
final responseProvider = FutureProvider.autoDispose.family<String, String>((ref, url) async {
  final httpClient = ref.read(fakeHttpClientProvider);
  return httpClient.get(url);
});


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title'),
        backgroundColor: Colors.red,
      ),
      body: Center(
          child: Consumer(
            builder: (context, watch, child) {
              final responseAsyncValue = watch(responseProvider('https://youtube.com'));
              return responseAsyncValue.map(
                  data: (_) => Text(_.value),
                  loading: (_) => CircularProgressIndicator(),
                  error: (_) => Text(_.error, style: TextStyle(color: Colors.red),));
            },
          ),
        ),
      // child: Text(_value),
    );
  }
}






