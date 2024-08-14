import 'package:project/modules/social_app/social-app_login_screen/social_app_login_screen.dart';
import 'package:project/shared/network/local/cache_helper.dart';

import 'components.dart';

void sinout(context)
{
  CacheHelper.clearData(key: 'token').then((value)
      {
      if(value == true)
    navigatefisnh(context, SocialLoginScreen()) ;
  });
}
void printFullText( String? text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}
String? token = '';

String? uid = '' ;