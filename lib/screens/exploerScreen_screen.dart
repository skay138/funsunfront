import 'package:flutter/material.dart';
import 'package:funsunfront/screens/public_screen.dart';
import 'package:funsunfront/screens/searchresult_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> imgUrls = [];
    imgUrls.add(
        'https://flexible.img.hani.co.kr/flexible/normal/970/970/imgdb/original/2023/0619/20230619501341.jpg');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnSNkiSUcQ1o4jzsNDFSNYE1Bt3xmRZK3joQ&usqp=CAU');
    imgUrls.add(
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtviSR-KwPyKiV_mJTGqtjgzzVV8r3Z5tRmXTjoypCsKLpVZPa4OuENBO5xcJ6mva1Sxc&usqp=CAU');
    imgUrls.add(
        'https://img2.daumcdn.net/thumb/R658x0.q70/?fname=https://t1.daumcdn.net/news/202303/19/starnews/20230319084657800lhwc.jpg');

    List<String> joined = [];
    joined.add('값이 있을 때 테스트');
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 150,
          elevation: 0.0,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SearchResultScreen()),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(15),
                ),
                height: 48,
                // width: 320,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '검색',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16),
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: Colors.grey.shade600,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          ///////////////////////////////////////////////////////펀딩
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '전체공개펀딩',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PublicScreen(
                                      page: '1',
                                    )),
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(imgUrls[0], //펀딩이미지
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 160,
                        height: 160,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(imgUrls[1], //펀딩이미지
                            fit: BoxFit.cover),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '서포트한 펀딩',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  // margin: const EdgeInsets.symmetric(horizontal: 15),
                  width: 400,
                  child: joined.isEmpty
                      ? Container(
                          alignment: Alignment.center,
                          height: 150,
                          child: const Text('서포트한 펀딩이 없습니다.'))
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 160,
                                height: 160,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Image.network(imgUrls[0], //펀딩이미지
                                    fit: BoxFit.cover),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              joined.length < 2
                                  ? const SizedBox(
                                      width: 20,
                                    )
                                  : Container(
                                      width: 160,
                                      height: 160,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Image.network(imgUrls[1], //펀딩이미지
                                          fit: BoxFit.cover),
                                    ),
                            ],
                          ),
                        ),
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}