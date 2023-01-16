import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_json/presentation/widgets/styles.dart';
import 'package:flutter/material.dart';

class DetailUserPage extends StatelessWidget {
  const DetailUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
              key: const Key('data_detail'),
              children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width / 3,
              child: CachedNetworkImage(
                imageUrl: 'https://api.multiavatar.com/Erickson.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Text('Company', style: Styles().extraBigSizeBoldText(Colors.black)),
          Padding(
            padding:
                const EdgeInsets.only(top: 6, left: 16, right: 16, bottom: 10),
            child: Text(
              'QUILK',
              style: Styles().bigSizeText(Colors.black),
            ),
          ),
          Text('About', style: Styles().extraBigSizeBoldText(Colors.black)),
          const Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 6),
            child: Text(
              'Eu commodo velit eiusmod minim cillum sunt mollit sint. Irure reprehenderit et irure exercitation duis laboris labore. Officia laboris commodo adipisicing est qui amet commodo.\r\n',
              textAlign: TextAlign.justify,
            ),
          ),
          Text('Profile', style: Styles().extraBigSizeBoldText(Colors.black)),
          Row(
            children: [
              Flexible(
                child: ListTile(
                  title: const Text('Name : '),
                  subtitle: Text('ahmad'),
                ),
              ),
              Spacer(),
              Flexible(
                child: ListTile(
                  title: const Text('Age : '),
                  subtitle: Text('32'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: ListTile(
                  title: const Text('Eye Color : '),
                  subtitle: Text('black'),
                ),
              ),
              Spacer(),
              Flexible(
                child: ListTile(
                  title: const Text('Gender : '),
                  subtitle: Text('Male'),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: ListTile(
                  title: const Text('Email : '),
                  subtitle: Text('ahmad@mail.com'),
                ),
              ),
              Spacer(),
              Flexible(
                child: ListTile(
                  title: const Text('Phone : '),
                  subtitle: Text('+6288231233'),
                ),
              ),
            ],
          ),
          ListTile(
            title: const Text('Address : '),
            subtitle: Text('jl.ahmad ahmad yani'),
          ),
              ],
            ),
        ));
  }
}
