import 'package:flutter/material.dart';

//text field
class MyTextField extends StatelessWidget{

  final String label;
  final bool isPassword;
  final TextEditingController controller;

  const MyTextField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false
  }); 

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder()
        ),
    );
  }

}



//button
class MyButton extends StatelessWidget{

    final String label;
    final VoidCallback onPressed;

    const MyButton({
        super.key,
        required this.label,
        required this.onPressed
    });
    
    @override
    Widget build(BuildContext context) {
        return ElevatedButton(
            onPressed: onPressed, 
            child: Text(label)
    );
    }
    
}


//appbar signin and signup
class SignInUpAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const SignInUpAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 21, 28, 32),
      foregroundColor: Colors.amber,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


//appbar profile
class ProfileAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ProfileAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 21, 28, 32),
      foregroundColor: Colors.amber,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}



//appbar dashboard
class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const DashboardAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          const Icon(Icons.notifications),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}