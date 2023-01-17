import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_json/data/data.dart';
import 'package:fake_json/presentation/widgets/styles.dart';
import 'package:flutter/material.dart';

class DetailUserPage extends StatelessWidget {
  final User? user;
  const DetailUserPage({this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            title: const Text("Detail Profile"),
            centerTitle: true,
            ),
        body: SingleChildScrollView(
          child: Column(
            key: const Key('data_detail'),
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 3,
                  child: CachedNetworkImage(
                    imageUrl: user!.profile!.picture!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text('Company',
                  style: Styles().extraBigSizeBoldText(Colors.black)),
              Padding(
                padding: const EdgeInsets.only(
                    top: 6, left: 16, right: 16, bottom: 10),
                child: Text(
                  user!.company ?? "-",
                  style: Styles().bigSizeText(Colors.black),
                ),
              ),
              Text('About', style: Styles().extraBigSizeBoldText(Colors.black)),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                child: Text(
                  user!.about ?? "-",
                  textAlign: TextAlign.justify,
                ),
              ),
              Text('Profile',
                  style: Styles().extraBigSizeBoldText(Colors.black)),
              Row(
                children: [
                  Flexible(
                    child: ListTile(
                      title: const Text('Name : '),
                      subtitle: Text(user!.profile!.name ?? "-"),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: ListTile(
                      title: const Text('Age : '),
                      subtitle: Text(user!.profile!.age.toString()),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: ListTile(
                      title: const Text('Eye Color : '),
                      subtitle: Text(user!.profile!.eyeColor ?? "-"),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: ListTile(
                      title: const Text('Gender : '),
                      subtitle: Text(user!.profile!.gender ?? "-"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: ListTile(
                      title: const Text('Email : '),
                      subtitle: Text(user!.profile!.email ?? "-"),
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    child: ListTile(
                      title: const Text('Phone : '),
                      subtitle: Text(user!.profile!.phone ?? "-"),
                    ),
                  ),
                ],
              ),
              ListTile(
                title: const Text('Address : '),
                subtitle: Text(user!.profile!.address ?? "-"),
              ),
            ],
          ),
        ));
  }
}
