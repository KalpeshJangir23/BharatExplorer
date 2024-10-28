import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/assets/vector_images.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/provider/user_provider.dart';
import 'package:trip_show_planner/screens/bottom_nav.dart';

class PasswordScreen extends ConsumerStatefulWidget {
  const PasswordScreen({super.key});

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends ConsumerState<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isValidInput = false;

  void _onTextChanged(String value) {
    setState(() {
      _isValidInput = value.isNotEmpty; // Add more checks here if needed
    });
  }

  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
     _passwordVisible = false;
  }
 

  void _onNextPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const BottomNavBar(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(
              VectorImages.password,
            ),
            // Labels
            const SizedBox(height: 8),
            const SizedBox(height: 8),

            const Text(
              'Password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select your desired password',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Text field
            TextFormField(
              onChanged: _onTextChanged,
              keyboardType: TextInputType.text,
              controller: _passwordController,
              obscureText:
                  !_passwordVisible, //This will obscure text dynamically
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                // Here is key idea
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Appcolor.white,
                  ),
                  onPressed: () {
                    // Update the state i.e. toogle the state of passwordVisible variable
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Next Button
            if (_isValidInput)
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(userProvider.notifier)
                      .updateEmail(_passwordController.text);
                  _onNextPressed();
                },
                child: const Text('Next'),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }
}
