import 'package:flutter/material.dart';

class MessagingScreen extends StatelessWidget {
  const MessagingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'MESSAGES',
                style: TextStyle(fontSize: 24.0),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.red,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF777777),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1.0,
                color: Colors.black26,
              ),
              Expanded(
                flex: 1,
                child: Container(
                    //color: Colors.black26,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
