import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trip_show_planner/core/config/assets/vector_images.dart';
import 'package:trip_show_planner/provider/user_provider.dart';
import 'package:trip_show_planner/screens/login/password_screen.dart';

class EmailScreen extends ConsumerStatefulWidget {
  const EmailScreen({super.key});

  @override
  _EmailScreenState createState() => _EmailScreenState();
}

class _EmailScreenState extends ConsumerState<EmailScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isValidInput = false;

  void _onTextChanged(String value) {
    setState(() {
      // Update the validity of the input
      _isValidInput = value.isNotEmpty; // Add more checks here if needed
    });
  }

  void _onNextPressed() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const PasswordScreen(),
    ));
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
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
              VectorImages.email,
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            // Labels
            const Text(
              'Email Address',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'What is your Email Address?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Text field
            TextFormField(
              validator: validateEmail,
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.emailAddress,
              controller: _controller,
              onChanged: _onTextChanged,
              decoration: const InputDecoration(hintText: 'Email Address')
                  .applyDefaults(Theme.of(context).inputDecorationTheme),
            ),
            const SizedBox(height: 16),
            // Next Button
            if (_isValidInput)
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(userProvider.notifier)
                      .updateEmail(_controller.text);
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
    _controller.dispose();
    super.dispose();
  }
}
