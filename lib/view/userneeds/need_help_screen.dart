import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NeedHelpScreen extends StatefulWidget {
  const NeedHelpScreen({super.key});

  @override
  State<NeedHelpScreen> createState() => _NeedHelpScreenState();
}

class _NeedHelpScreenState extends State<NeedHelpScreen> {
  List<dynamic> faqList = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchFaqs();
  }

  Future<void> _fetchFaqs() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final response = await http.get(
        Uri.parse('http://31.97.206.144:7021/api/admin/userfaq'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          faqList = data['faqs'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'No faqs added';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
        isLoading = false;
      });
    }
  }

  // Function to make a phone call
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  // Function to send an email
  Future<void> _sendEmail(String emailAddress) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Need Help - Support Request',
        'body': 'Need Your Help',
      }),
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Need Help",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFF5931DD),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                // Navigator.pushAndRemoveUntil(
                //   context,
                //   MaterialPageRoute(builder: (context) => const MainLayout()),
                //   (route) => false, // Removes all previous routes
                // );
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Colors.black,
              ),
            ),
          ),
        ),
        actions: [
          // if (!isLoading)
          //   IconButton(
          //     icon: const Icon(Icons.refresh, color: Colors.white),
          //     onPressed: _fetchFaqs,
          //     tooltip: 'Refresh FAQs',
          //   ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchFaqs,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              SizedBox(
                height: 180,
                child: Lottie.network(
                  "https://assets2.lottiefiles.com/packages/lf20_jcikwtux.json",
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "We're here to help!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                "Contact our support team anytime for assistance.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // Support options
              _contactCard(
                icon: Icons.phone,
                title: "Call Us",
                // subtitle: "+91 8309056333",
                subtitle: "+91 6300778241",

                onTap: () async {
                  try {
                    await _makePhoneCall("+916300778241");
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not launch phone app: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),
              _contactCard(
                icon: Icons.email,
                title: "Email Us",
                subtitle: "services.clynix@gmail.com",
                onTap: () async {
                  try {
                    await _sendEmail("services.clynix@gmail.com");
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Could not launch email app: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 25),

              // FAQ Section
              const Text(
                "Frequently Asked Questions",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5931DD)),
              ),
              const SizedBox(height: 12),

              // Loading, Error, or FAQ List
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (errorMessage.isNotEmpty)
                Center(
                  child: Column(
                    children: [
                      // Text(
                      //   errorMessage,
                      //   style: const TextStyle(color: Colors.black),
                      //   textAlign: TextAlign.center,
                      // ),
                      Text(
                        'Please provide your internet connection',
                        style: const TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )
              else if (faqList.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('No FAQs available at the moment.'),
                  ),
                )
              else
                ...faqList.map((faq) => Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ExpansionTile(
                        leading: const Icon(Icons.help_outline,
                            color: Color(0xFF5931DD)),
                        title: Text(
                          faq['question'] ?? 'No question',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              faq['answer'] ?? 'No answer',
                              style: const TextStyle(color: Colors.black87),
                            ),
                          )
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Color(0xFF5931DD), size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
