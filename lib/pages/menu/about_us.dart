import "package:flutter/material.dart";
import 'package:Roughnote/widgets/header.dart';
import 'package:Roughnote/widgets/progress.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutUsPage extends StatefulWidget {
  final String? currentUserId;

  const AboutUsPage({Key? key, this.currentUserId}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
      duration: const Duration(milliseconds: 300),
      data: Theme.of(context),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: header(context,
            titleText: AppLocalizations.of(context)!.about_us,
            removeBackButton: false),
        body: isLoading
            ? circularProgress()
            : ListView(children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Roughnote is a flagship entity of Aathi Infotech Private Limited, based in India. \nOur mission is - To give people the power to build community and bring the world closer together.\nOur principles -  They embody what we stand for and guide our approach to how we build technology for people and their relationships.\nGive People a Voice: People deserve to be heard and to have a voice — even when that means defending the right of people we disagree with.\nBuild Connection and Community:  Our services help people connect, and when they’re at their best, they bring people closer together.\nServe Everyone: We work to make technology accessible to everyone, and our business model is ads so our services can be free.\nKeep People Safe and Protect Privacy: We have a responsibility to promote the best of what people can do together by keeping people safe and preventing harm.\nPromote Economic Opportunity: Our tools level the playing field so businesses grow, create jobs and strengthen the economy. ',
                        style: Theme.of(context).textTheme.bodyText1,
                      )
                    ],
                  ),
                ),
              ]),
      ),
    );
  }
}
