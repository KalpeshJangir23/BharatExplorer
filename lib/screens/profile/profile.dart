// user_state.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';
import 'package:trip_show_planner/provider/user_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    final userState = ref.read(userProvider);
    _emailController = TextEditingController(text: userState.email);
    _passwordController = TextEditingController(text: userState.password);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Profile'),
        //   actions: [
        //     IconButton(
        //       icon: Icon(_isEditing ? Icons.save : Icons.edit),
        //       onPressed: () {
        //         if (_isEditing) {
        //           if (_formKey.currentState!.validate()) {
        //             ref
        //                 .read(userProvider.notifier)
        //                 .updateEmail(_emailController.text);
        //             ref
        //                 .read(userProvider.notifier)
        //                 .updatePassword(_passwordController.text);

        //           }
        //         }
        //         setState(() {
        //           _isEditing = !_isEditing;
        //         });
        //       },
        //     ),
        //   ],
        // ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  enabled: _isEditing,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  enabled: _isEditing,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                if (_isEditing) ...[
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref
                              .read(userProvider.notifier)
                              .updateEmail(_emailController.text);
                          ref
                              .read(userProvider.notifier)
                              .updatePassword(_passwordController.text);

                          setState(() {
                            _isEditing = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Profile updated successfully')),
                          );
                        }
                      },
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        if (_isEditing) {
                          if (_formKey.currentState!.validate()) {
                            ref
                                .read(userProvider.notifier)
                                .updateEmail(_emailController.text);
                            ref
                                .read(userProvider.notifier)
                                .updatePassword(_passwordController.text);
                          }
                        }
                        setState(() {
                          _isEditing = !_isEditing;
                        });
                      },
                      child: const Text(
                        "EDIT",
                        style: TextStyle(color: Appcolor.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
