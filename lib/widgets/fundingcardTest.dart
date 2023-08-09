// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:funsunfront/provider/profile_provider.dart';
import 'package:funsunfront/provider/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/funding_model.dart';
import '../provider/fundings_provider.dart';
import '../screens/funding_screen.dart';
import '../services/api_funding.dart';

class FundingCardTest extends StatefulWidget {
  FundingCardTest({
    super.key,
    required this.sizeX,
    required this.title,
    required this.fundingType,

    ///'mySupport', 'myFunding', 'public', 'userFunding', 'friendFunding'
  });
  final double sizeX;
  final String title;
  final String fundingType;

  @override
  State<FundingCardTest> createState() => _FundingCardTestState();
}

class _FundingCardTestState extends State<FundingCardTest> {
  int page = 1;
  List<FundingModel> fundings = [];
  late FundingsProvider fundingsProvider;
  late UserProvider userProvider;
  late ProfileProvider profileProvider;

  Future<List<FundingModel>>? fetchFunding(
      //fundingType에 따라 다른 api 호출
      String fundingType,
      int page) async {
    switch (fundingType) {
      case 'mySupport':
        return await Funding.getJoinedFunding(page: page.toString());
      case 'myFunding':
        return await Funding.getUserFunding(
            page: page.toString(), id: userProvider.user!.id);
      case 'public':
        return await Funding.getPublicFunding(page: page.toString());
      case 'userFunding':
        return await Funding.getUserFunding(
            page: page.toString(), id: profileProvider.profile!.id);
      case 'friendFunding':
        return await Funding.getFriendFunding(page: page.toString());
      default:
        return Future<List<FundingModel>>.value([]);
    }
  }

  void getMoreFn(String fundingType, int page) async {
    List<FundingModel> tmpFunding;

    switch (fundingType) {
      case 'mySupport':
        tmpFunding = await Funding.getJoinedFunding(page: page.toString());
        break;
      case 'myFunding':
        tmpFunding = await Funding.getUserFunding(
            page: page.toString(), id: userProvider.user!.id);
        break;
      case 'public':
        tmpFunding = await Funding.getPublicFunding(page: page.toString());
        break;
      case 'userFunding':
        tmpFunding = await Funding.getUserFunding(
            page: page.toString(), id: profileProvider.profile!.id);
        break;
      case 'friendFunding':
        tmpFunding = await Funding.getFriendFunding(page: page.toString());
        break;
      default:
        tmpFunding = [];
        break;
    }
    setState(() {
      fundings.addAll(tmpFunding);
    });
  }

  void initFunding() async {
    List<FundingModel>? tmpFundings =
        await fetchFunding(widget.fundingType, page);
    setState(() {
      fundings.addAll(tmpFundings!);
    });
  }

  @override
  initState() {
    super.initState();
    initFunding();
  }

  @override
  Widget build(BuildContext context) {
    const imgBaseUrl = 'http://projectsekai.kro.kr:5000/';
    fundingsProvider = Provider.of<FundingsProvider>(context, listen: true);
    userProvider = Provider.of<UserProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    return (fundings.isNotEmpty)
        ? NotificationListener<ScrollNotification>(
            onNotification: (scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                setState(() {
                  page++;
                });
                getMoreFn(widget.fundingType, page);

                return true;
              }
              return false;
            },
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 20),
              itemCount: fundings.length,
              physics: const AlwaysScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, //1 개의 행에 보여줄 item 개수
                childAspectRatio: 1 / 1.4, //item 의 가로 1, 세로 1 의 비율
                mainAxisSpacing: 10, //수평 Padding
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                //만료확인변수
                final bool isExpired = DateTime.parse(fundings[index].expireOn)
                    .isBefore(DateTime.now());
                final bool public = fundings[index].public!;
                final String? imgUrl = fundings[index].image;
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
                                flex: 1,
                                child: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: (imgUrl != null)
                                              ? NetworkImage(
                                                  '$imgBaseUrl$imgUrl',
                                                )
                                              : Image.asset(
                                                      'assets/images/default_profile.jpg')
                                                  .image,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text('${fundings[index].authorName}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  width: widget.sizeX,
                                  height: widget.sizeX,
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
                              Expanded(
                                flex: 2,
                                child: Container(
                                  width: widget.sizeX,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          fundings[index].title,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              '펀딩종료일',
                                              style: TextStyle(
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              style: const TextStyle(
                                                fontSize: 16,
                                              ),
                                              DateFormat.yMMMd('en_US').format(
                                                  DateTime.parse(fundings[index]
                                                      .expireOn)),
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
                        Positioned(
                          top: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (public == true)
                                    ? const SizedBox()
                                    : Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            //윤선아
                                            color: Colors.lightBlue.shade200
                                                .withOpacity(0.6)),
                                        child: const Text(
                                          '친구의\n비밀펀딩',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10),
                                        ),
                                      ),
                                (isExpired == true)
                                    ? Container(
                                        alignment: Alignment.center,
                                        width: 50,
                                        height: 50,
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
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        )
                      ],
                    ));
              },
            ),
          )
        : Center(
            child: Text('${widget.title}이 없습니다.'),
          );
  }
}
