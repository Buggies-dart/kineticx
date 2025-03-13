

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column( crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      CircleAvatar( radius: 60, backgroundImage: AssetImage('assets/images/gym.png'),),
      SizedBox( height: 10),
      Text('John Doe', style: Theme.of(context).textTheme.titleLarge!.copyWith( color: Theme.of(context).primaryColorDark),),
      SizedBox( height: 10),
      InkWell( onTap: () {
      },
        child: Row( crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Text('Logout', style: Theme.of(context).textTheme.bodyMedium),
        SizedBox( width: 5  ),
        Icon(Icons.logout, color: Theme.of(context).colorScheme.onPrimaryFixedVariant)
        ],),
      )
      ],
      );
  }
}