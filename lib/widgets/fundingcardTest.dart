import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../provider/fundings_provider.dart';
import '../screens/funding_screen.dart';
import 'loading_circle.dart';

class FundingCardTest extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  final double sizeX;
  final String title;
  final String fundingType;
  late FundingsProvider fundingsProvider;
  int page = 1;

  FundingCardTest({
    super.key,
    required this.sizeX,
    required this.title,
    required this.fundingType,
  });

  Future<List<FundingModel>>? fetchFunding(String fundingType, int page) {
    switch (fundingType) {
      case 'mySupport':
        return fundingsProvider.joinedFundings;
      case 'myFunding':
        return fundingsProvider.myFundings;
      case 'public':
        return fundingsProvider.publicFundings;
      case 'userFunding':
        return fundingsProvider.myFundings;
      default:
        return Future<List<FundingModel>>.value([]);
    }
  }

  void fetchMoreData() {
    page++;
    fetchFunding(fundingType, page);
    print('fetch호출');
  }

  @override
  Widget build(BuildContext context) {
    const imgBaseUrl = 'http://projectsekai.kro.kr:5000/';
    fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);

    return FutureBuilder<List<FundingModel>>(
      future: fetchFunding(fundingType, page),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingCircle();
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              '$title이 없습니다.',
              style: const TextStyle(
                fontSize: 13,
              ),
            ),
          );
        } else {
          List<FundingModel> fundings = snapshot.data!;

          return ListView.builder(
            controller: _scrollController,
            itemCount: fundings.length,
            itemBuilder: (BuildContext context, int index) {
              if (index < fundings.length) {
                GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
                  itemCount: fundings.length,
                  physics: const AlwaysScrollableScrollPhysics(),

                  // shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, //1 개의 행에 보여줄 item 개수
                    childAspectRatio: 1 / 1.6, //item 의 가로 1, 세로 1 의 비율
                    mainAxisSpacing: 10, //수평 Padding
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    //만료확인변수
                    final bool isExpired =
                        DateTime.parse(fundings[index].expireOn)
                            .isBefore(DateTime.now());
                    return InkWell(
                        onTap: () {
                          fundingsProvider
                              .getFundingDetail(fundings[index].id.toString());

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FundingScreen(
                                      id: fundings[index].id.toString(),
                                    )),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0,
                                        blurRadius: 5.0,
                                        offset: const Offset(1, .8))
                                  ]),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: SizedBox(
                                      width: sizeX,
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: (fundings[index].image != null)
                                            ? Image.network(
                                                '$imgBaseUrl${fundings[index].image}',
                                                //펀딩이미지
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/images/default_funding.jpg',
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              fundings[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      '펀딩종료일',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                      ),
                                                    ),
                                                    Text(
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                      DateFormat.yMMMd('en_US')
                                                          .format(DateTime
                                                              .parse(fundings[
                                                                      index]
                                                                  .expireOn)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            (isExpired == true)
                                ? Positioned(
                                    top: 5,
                                    right: 5,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .primaryColorLight
                                              .withOpacity(0.6)),
                                      child: const Text(
                                        '만료된 \n펀딩',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10),
                                      ),
                                    ))
                                : const SizedBox(
                                    width: 10,
                                  ),
                          ],
                        ));
                  },
                );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingCircle();
                } else {
                  fetchMoreData(); // 끝에 도달하면 더 많은 데이터를 가져오도록 호출
                  return const LoadingCircle();
                }
              }
              return null;
            },
          );
        }
      },
    );
  }
}
