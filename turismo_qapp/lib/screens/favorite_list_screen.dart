import 'package:flutter/material.dart';
import 'package:turismo_qapp/dao/package_dao.dart';
import 'package:turismo_qapp/models/package.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:const  FavoriteList(
      ),
    );
  }
}

class FavoriteList extends StatefulWidget {
  const FavoriteList({super.key});

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<Package> _favorites = [];
  final PackageDao _packageDao = PackageDao();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _packageDao.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
         else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }
        else {
          _favorites = snapshot.data ?? [];
          return ListView.builder(
            itemCount: _favorites.length,
            itemBuilder: (context, index)
            => FavoriteItem(favorite: _favorites[index]),
          );
        }
      },
    );
  }
}

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({super.key, required this.favorite});
  final Package favorite;
  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    return Card(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              favorite.image,
              width: width,
              height: width/2,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              Text(favorite.name),
              Text(favorite.description),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              final PackageDao packageDao = PackageDao();
              packageDao.delete(favorite);
            },
          ),
        ],
      )
    );
  }
}