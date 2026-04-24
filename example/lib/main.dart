import 'package:flutter/material.dart';
import 'package:api_state_view/api_state_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'api_state_view Example',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

enum ViewState { loading, success, empty, error }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ViewState state = ViewState.loading;

  final List<String> users = [
    "Happy Patel",
    "John Doe",
    "Emma Watson",
    "David Smith",
    "Sophia Lee",
  ];

  @override
  void initState() {
    super.initState();
    _loadSuccess();
  }

  Future<void> _loadSuccess() async {
    setState(() => state = ViewState.loading);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => state = ViewState.success);
  }

  void _showEmpty() {
    setState(() => state = ViewState.empty);
  }

  void _showError() {
    setState(() => state = ViewState.error);
  }

  void _retry() {
    _loadSuccess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("api_state_view Example"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ApiStateView(
              isLoading: state == ViewState.loading,
              error: state == ViewState.error ? "Something went wrong.\nPlease try again." : null,
              isEmpty: state == ViewState.empty,
              onRetry: _retry,
              child: ListView.separated(
                itemCount: users.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  return ListTile(
                    leading: CircleAvatar(child: Text(users[index][0])),
                    title: Text(users[index]),
                    subtitle: const Text("Flutter Developer"),
                  );
                },
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(onPressed: _loadSuccess, child: const Text("Loading")),
                ElevatedButton(onPressed: _showEmpty, child: const Text("Empty")),
                ElevatedButton(onPressed: _showError, child: const Text("Error")),
                ElevatedButton(onPressed: _loadSuccess, child: const Text("Success")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
