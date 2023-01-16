import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_json/presentation/pages/detail_user_page.dart';
import 'package:fake_json/presentation/widgets/filter_dialog_widget.dart';
import 'package:fake_json/presentation/widgets/filter_widget.dart';
import 'package:fake_json/presentation/widgets/search_bar_widget.dart';
import 'package:fake_json/presentation/widgets/styles.dart';
import 'package:fake_json/presentation/widgets/tittle_view.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50, left: 16),
                child: TitleView(
                  key: Key('title_view'),
                  title: 'User App',
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 5, right: 16),
                child: FilterWidget(
                  key: const Key('filter_widget'),
                  filterOnTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const FilterDialogWidget(
                            key: Key('filter_dialog_widget'),
                          );
                        });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 100,
              child: SearchBarWidget(
                key: const Key('searchbar_view'),
                hint: 'Tempat cari user idaman',
                searchOnTap: (val) async {},
              ),
            ),
          ),
          Expanded(
            child: showListUser(context),
          )
        ],
      ),
    );
  }

  Widget showListUser(context) {
    return ListView.separated(
        key: const Key('user_list_view'),
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
            child: GestureDetector(
              key: const Key('on_tap_detail_user_page'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DetailUserPage(
                            key: Key('detail_user_page'),
                          )),
                );
              },
              child: Card(
                elevation: 6,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10, bottom: 10),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://api.multiavatar.com/Erickson.png',
                                  fit: BoxFit.contain,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Nama',
                                style:
                                    Styles().normalSizeBoldText(Colors.black)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: const [
                                Text('Company'),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: const [
                                Text('Age'),
                              ],
                            ),
                          ),
                        ),
                          Padding(
                          padding: const EdgeInsets.only(
                              left: 20, bottom: 10, top: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: const [
                                Text('Active'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: 2);
  }
}
