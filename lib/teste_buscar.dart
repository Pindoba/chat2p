import 'package:chat2p/shared/widgets/profile_list_wedget.dart';
import 'package:flutter/material.dart';
import 'package:matrix/matrix.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Client? client;
  List<dynamic> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _initializeMatrixClient();
    _searchController.addListener(_onSearchChanged);
  }

  void _initializeMatrixClient() async {
    client = Provider.of<Client>(context, listen: false);
    setState(() {});
  }

  void _onSearchChanged() {
    if (_searchController.text.isNotEmpty) {
      _search(_searchController.text);
    } else {
      setState(() {
        _searchResults.clear();
      });
    }
  }

  void _search(String searchTerm) async {
    // Realiza a pesquisa de usuários e salas
    // Substitua 'searchTerm' com o termo de pesquisa real
    // var response = await client!.searchUserDirectory(searchTerm, limit: 20);
    var response =
        await client!.searchUserDirectory(searchTerm );
    setState(() {
      _searchResults = response.results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisa Matrix'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                var result = _searchResults[index];
                return ProfileListWedget(profile: result,);

                //  ListTile(
                //   title: Text(result.displayName),
                //   subtitle: Text(result.userId),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
