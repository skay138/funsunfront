import 'package:flutter/cupertino.dart';
import 'package:funsunfront/provider/provider.dart';
import 'package:funsunfront/services/api_account.dart';
import 'package:funsunfront/services/kakao_login_api.dart';
import 'package:provider/provider.dart';

class KakaoLoginButton extends StatelessWidget {
  KakaoLoginButton({
    super.key,
  });

  late SignInProvider _signInProvider;

  void kakaobtn() async {
    String kakaotoken = await getKakaoToken();
    if (kakaotoken != 'error') {
      final user = await Account.accessTokenLogin(2);
      _signInProvider.setCurrentUser(user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    _signInProvider = Provider.of<SignInProvider>(context, listen: true);
    return GestureDetector(
      onTap: kakaobtn,
      child: Center(
        heightFactor: 5,
        child: Image.asset(
          'assets/images/kakaologin.png',
        ),
      ),
    );
  }
}
