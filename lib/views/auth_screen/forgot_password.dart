import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  bool _isLoading = false;

  Future<void> requestPasswordReset(String email) async {
    setState(() {
      _isLoading = true;
    });

    final url =
        Uri.parse("https://dma-inc.net/wp-login.php?action=lostpassword");
    try {
      final response = await http.post(
        url,
        body: {
          'user_login': email,
        },
      );

      setState(() {
        _isLoading = false;
      });
      print(response.body);
      if (response.statusCode == 200) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  "Password reset link sent if the email exists, Please Check your email.")),
        );
      } else {
        // Failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  "Password reset link sent if the email exists, Please Check your email.")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: _isLoading
          ? const CircularProgressIndicator() // Show loading indicator when loading
          : TextButton(
              onPressed: () async {
                // Prompt the user for their email
                final emailController = TextEditingController();
                final email = await showDialog<String?>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Enter Email"),
                      content: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          hintText: "Enter your registered email",
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text("Submit"),
                          onPressed: () {
                            Navigator.of(context).pop(emailController.text);
                          },
                        ),
                      ],
                    );
                  },
                );

                if (email != null && email.isNotEmpty) {
                  await requestPasswordReset(email);
                }
              },
              child: const Text("Forgot Password?"),
            ),
    );
  }
}
