import 'package:flutter/material.dart';
import 'package:turismo_qapp/dao/package_dao.dart';
import 'package:turismo_qapp/models/package.dart';
import 'package:turismo_qapp/services/package_service.dart';

class PackageSearchScreen extends StatefulWidget {
  const PackageSearchScreen({super.key});

  @override
  State<PackageSearchScreen> createState() => _PackageSearchScreenState();
}

class _PackageSearchScreenState extends State<PackageSearchScreen> {
  String _place = "";
  String _packageType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package Search'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          const Text('Places', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), textAlign: TextAlign.left),
          SizedBox(
            height: 50.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InputChip(
                    label: const Text('Machu Picchu'),
                    selectedColor: Colors.blue,
                      selected: _place == 'S001',
                    onSelected: (bool selected) {
                      setState(() {
                        _place = selected ? 'S001' : '';
                      });
                    },
                  ),
                  InputChip(
                    label: const Text('Ayacucho'),
                    selected: _place == 'S002',
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        _place = selected ? 'S002' : '';
                      });
                    },
                  ),
                  InputChip(
                    label: const Text('Chicen Itza'),
                    selectedColor: Colors.blue,
                    selected: _place == 'S003',
                    onSelected: (bool selected) {
                      setState(() {
                        _place = selected ? 'S003' : '';
                      });
                    },
                  ),
                  InputChip(
                    label: const Text('Cristo Redentor'),
                    selected: _place == 'S004',
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        _place = selected ? 'S004' : '';
                      });
                    },
                  ),
                  InputChip(
                    label: const Text('Islas Malvinas'),
                    selectedColor: Colors.blue,
                    selected: _place == 'S005',
                    onSelected: (bool selected) {
                      setState(() {
                        _place = selected ? 'S005' : '';
                      });
                    },
                  ),
                  InputChip(
                    label: const Text('Muralla China'),
                    selectedColor: Colors.blue,
                    selected: _place == 'S006',
                    onSelected: (bool selected) {
                      setState(() {
                        _place = selected ? 'S006' : '';
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text('Package Types', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                InputChip(
                  label: const Text('Viaje'),
                  selectedColor: Colors.green,
                  selected: _packageType == '1',
                  onSelected: (bool selected) {
                    setState(() {
                      _packageType = selected ? '1' : '';
                    });
                  },
                ),
                InputChip(
                  label: const Text('Hospedaje'),
                  selected: _packageType == '2',
                  selectedColor: Colors.red,
                  onSelected: (bool selected) {
                    setState(() {
                      _packageType = selected ? '2' : '';
                      
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: PackageList(
              place: _place,
              packageType: _packageType,
            ),
          )
        ],
      ),
    );
  }
}

class PackageList extends StatefulWidget {
  const PackageList(
      {super.key, required this.place, required this.packageType});
  final String place;
  final String packageType;

  @override
  State<PackageList> createState() => _PackageListState();
}

class _PackageListState extends State<PackageList> {
  List _packages = [];
  final PackageService _packageService = PackageService();

  search() async {
    _packages = await _packageService.getByPlaceAndType(
        widget.place, widget.packageType);
    if (mounted) {
      setState(() {
        _packages = _packages;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    search();
    return ListView.builder(
      itemCount: _packages.length,
      itemBuilder: (context, index) {
        return PackageItem(package: _packages[index]);
      },
    );
  }
}
class PackageItem extends StatefulWidget {
  const PackageItem({super.key, required this.package});
  final Package package;

  @override
  State<PackageItem> createState() => _PackageItemState();
}

class _PackageItemState extends State<PackageItem> {
  bool _isFavorite = false;
  final PackageDao _packageDao = PackageDao();
  checkFavorite() {
    _packageDao.isFavorite(widget.package).then((value) {
      if (mounted) {
        setState(() {
          _isFavorite = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    checkFavorite();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            Stack(
              children:[ Image.network(
                widget.package.image,
                width: width,
                height: width/2,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: 
                IconButton(onPressed: (){
                  setState(() {
                    _isFavorite = !_isFavorite;
                    if(_isFavorite){
                      _packageDao.insert(widget.package);
                    }else{
                      _packageDao.delete(widget.package);
                    }
                  });

                }, icon: Icon(Icons.favorite_border_outlined, 
                              color: _isFavorite ? Colors.red : Colors.grey, weight: 20)),

              ),],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.package.name,
                    style:const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.package.description,
                    style:const  TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.package.location,
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}