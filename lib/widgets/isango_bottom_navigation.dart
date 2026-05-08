import 'package:flutter/material.dart';
import 'package:isango_app/core/constants/app_routes.dart';

class IsangoBottomNavigation extends StatelessWidget {
  const IsangoBottomNavigation({
    super.key, required this.currentIndex
});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index){
        final routes = <String>[
          AppRoutes.home,
          AppRoutes.saved,
          AppRoutes.submitEvent,
          AppRoutes.settings
        ];
        
        if(routes[index] != ModalRoute.of(context)?.settings.name){
          Navigator.pushReplacementNamed(context, routes[index]);
        }
      },
      destinations: const [
        NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "Home"
        ),
        NavigationDestination(
            icon: Icon(Icons.bookmark_outline),
            label: "Saved"
        ),

        NavigationDestination(
            icon: Icon(Icons.add_circle_outline),
            label: "Submit"
        ),
        NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            label: "Settings"
        ),
      ],
    );
    
  }

}
