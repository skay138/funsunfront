import 'package:flutter/material.dart';
import 'package:funsunfront/screens/bottom_nav_shortcuts.dart';
import 'package:funsunfront/screens/edit_screen.dart';
import 'package:funsunfront/screens/explore_screen.dart';
import 'package:funsunfront/screens/funding_screen.dart';
import 'package:funsunfront/screens/mysupport_screen.dart';
import 'package:funsunfront/screens/public_screen.dart';
import 'package:funsunfront/screens/searchresult_screen.dart';
import 'package:funsunfront/screens/user_screen.dart';
import '../services/kakao_login_button.dart';

import 'faq_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              children: [
                const Text(
                  '즐거운\n펀딩플랫폼\nFunSun',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                KakaoLoginButton(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExploreScreen()),
                    );
                  },
                  child: const Text('ExploreScreen 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditScreen()),
                    );
                  },
                  child: const Text('editPage로 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FundingScreen(
                                id: '1',
                              )),
                    );
                  },
                  child: const Text('FundingPage로 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FaqScreen()),
                    );
                  },
                  child: const Text('FAQ로 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchResultScreen()),
                    );
                  },
                  child: const Text('SearchResultScreen 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomNavShortcuts()),
                    );
                  },
                  child: const Text('메인화면 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PublicSupportScreen(
                                page: '1',
                              )),
                    );
                  },
                  child: const Text('PublicSupportScreen 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MySupportScreen(
                                page: '1',
                              )),
                    );
                  },
                  child: const Text('MySupportScreen 이동 임시테스트'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserScreen()),
                    );
                  },
                  child: const Text('UserScreen 이동 임시테스트'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
