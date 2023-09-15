import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
    MainDrawer({super.key,required this.setScreen,required this.useremail});
  final void Function(String) setScreen;
final String useremail;

  @override
  Widget build(BuildContext context) {
    
    return  Drawer(
      child: 
      Column(
        children: [
          const DrawerHeader(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blueGrey,Colors.black
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight)
            ),
            child: 
          Row(
            children: [
              Icon(Icons.food_bank),
              SizedBox(width: 10,),
              Text("DISH TUTS",style: TextStyle(color: Colors.white)),

            ],
          )),
          ListTile(
            leading: const Icon(Icons.restaurant_rounded,),
            title: const Text('Meals',style: TextStyle(color: Colors.white),),
            onTap: (){
              setScreen('meals');
            },
          ),
          const SizedBox(height:10,),
           ListTile(
            leading: const Icon(Icons.settings,),
            title: const Text('Filters',style: TextStyle(color: Colors.white)),
            onTap: (){
              setScreen('filters');
            },
          )
        ],
      ),
    );
  }
}