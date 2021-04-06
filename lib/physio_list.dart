// import 'package:flutter/material.dart';
// import 'package:flutter_app_casestudy/models/physio.dart';
// import 'package:flutter_app_casestudy/physio_tile.dart';
// import 'package:provider/provider.dart';

// class PhysioList extends StatefulWidget {
//   @override
//   _PhysioListState createState() => _PhysioListState();
// }

// class _PhysioListState extends State<PhysioList> {
//   @override
//   Widget build(BuildContext context) {
//     final brews = Provider.of<List<Physio>>(context) ?? [];

//     return ListView.builder(
//       itemCount: brews.length,
//       itemBuilder: (context, index) {
//         return PhysioTile(physio: brews[index]);
//       },
//     );
//   }
// }
