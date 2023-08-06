import 'package:flutter/material.dart';

import '../widgets/home_header.dart';

class ProfileScreen extends StatelessWidget {
   
  const ProfileScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: HomeHeaderDelegate(),
            ),
            
          ],
        ),
    );
  }
}