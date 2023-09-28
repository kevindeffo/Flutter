import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddCarWidget extends StatelessWidget {
  final User? user;
  const AddCarWidget({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(
          [Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Salut'),
                    Text(user!.displayName!, style: const TextStyle(
                      fontWeight: FontWeight.bold
                    ),)
                  ],
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        height:40,
                        width: 40,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.4),
                          shape: BoxShape.circle
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.search, size: 30,),
                      ),
                      Container(
                        height:40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.4),
                            shape: BoxShape.circle
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.add, size: 30,),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
          ]
        )
    );
  }
}
