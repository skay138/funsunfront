import 'package:flutter/material.dart';
import 'package:funsunfront/screens/faq_screen.dart';
import 'package:funsunfront/widgets/profile.dart';

import '../widgets/fundingcard_horizon.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    List<String> imgUrls = [];
    imgUrls.add(
        'https://flexible.img.hani.co.kr/flexible/normal/970/970/imgdb/original/2023/0619/20230619501341.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnSNkiSUcQ1o4jzsNDFSNYE1Bt3xmRZK3joQ&usqp=CAU');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const Profile(
                    userName: '안녕',
                    following: 12,
                    follower: 10,
                    //이렇게 하는게 맞는지 정확히는 모르겠음
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      print('말랑버튼 누르지마세요...버튼이아파해요');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: sizeX,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFF80C0),
                      ),
                      child: const Text(
                        '내 펀딩 만들기',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: FundingCardHorizon(
                sizeX: sizeX,
                imgUrls: imgUrls,
                title: '내 펀딩',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 35),
              child: FundingCardHorizon(
                sizeX: sizeX,
                imgUrls: imgUrls,
                title: '서포트한 펀딩',
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FaqScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(left: 30),
                child: const Row(
                  children: [
                    Icon(Icons.help_outline_rounded),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'FAQ',
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: .5,
              width: sizeX,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(left: 30),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.exit_to_app_rounded,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '로그아웃',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.only(right: 30),
                    child: const Row(
                      children: [
                        Text(
                          '회원탈퇴',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}