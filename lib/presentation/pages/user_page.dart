import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_json/data/models/user.dart';
import 'package:fake_json/presentation/bloc/user_bloc.dart';
import 'package:fake_json/presentation/pages/detail_user_page.dart';
import 'package:fake_json/presentation/widgets/filter_dialog_widget.dart';
import 'package:fake_json/presentation/widgets/filter_widget.dart';
import 'package:fake_json/presentation/widgets/search_bar_widget.dart';
import 'package:fake_json/presentation/widgets/styles.dart';
import 'package:fake_json/presentation/widgets/tittle_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  UserBloc? userBloc;
  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    userBloc!.add(GetUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          body: BlocConsumer<UserBloc, UserState>(listener: (context, state) {
        if (state is UserError) {
          SnackBar(
            content: Text(state.message),
          );
        }
      }, builder: (context, state) {
        if (state is UserInitial) {
          return buildInitialView();
        } else if (state is UserLoading) {
          return buildLoading();
        } else if (state is UserLoaded) {
          return buildMainView(state.user);
        } else {
          return buildInitialView();
        }
      })),
    );
  }

  Widget buildLoading() {
    return Column(
      children: <Widget>[
        buildAppBarView(),
        buildSearchBar(),
        const Expanded(child: Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget buildMainView(List<User> users) {
    return Column(
      children: <Widget>[
        buildAppBarView(),
        buildSearchBar(),
        Expanded(
          child: showListUser(context, users),
        )
      ],
    );
  }

  Widget buildInitialView() {
    return Column(
      children: <Widget>[
        buildAppBarView(),
        buildSearchBar(),
        const Expanded(
          child: Center(
            child: Text('Tidak Ada Data'),
          ),
        )
      ],
    );
  }

  Widget showListUser(context, List<User> users) {
    return LazyLoadScrollView(
      onEndOfPage: () {
        userBloc!.add(LoadMore());
      },
      scrollOffset: 100,
      child: RefreshIndicator(
        onRefresh: (() => refreshList()),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.separated(
              key: const Key('user_list_view'),
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: ((BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
                  child: GestureDetector(
                    key: const Key('on_tap_detail_user_page'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailUserPage(
                                  key: const Key('detail_user_page'),
                                  user: users[index],
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
                                        imageUrl: users
                                            .elementAt(index)
                                            .profile!
                                            .picture!,
                                        fit: BoxFit.contain,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: users.elementAt(index).profile!.gender ==
                                        'male'
                                    ? const Icon(Icons.male)
                                    : const Icon(Icons.female),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      users.elementAt(index).profile!.name ??
                                          "",
                                      style: Styles()
                                          .normalSizeBoldText(Colors.black)),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6),
                                              child: Icon(Icons.business)),
                                          Text(users.elementAt(index).company ??
                                              ""),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Row(
                                        children: [
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6),
                                              child:
                                                  Icon(Icons.account_circle)),
                                          Text(users
                                              .elementAt(index)
                                              .profile!
                                              .age
                                              .toString()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, bottom: 10, top: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: users.elementAt(index).isActive == true
                                      ? Row(
                                          children: const [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 6),
                                                child: Icon(
                                                    Icons.check_box_outlined)),
                                            Text("Active"),
                                          ],
                                        )
                                      : Row(
                                          children: const [
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(right: 6),
                                                child: Icon(
                                                    Icons.cancel_outlined)),
                                            Text("Inactive"),
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
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemCount: users.length),
        ),
      ),
    );
  }

  Future<void> refreshList() async {
    userBloc!.add(RefreshList());
  }

  Widget buildAppBarView() {
    return Row(
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
                    return FilterDialogWidget(
                      ctx: context,
                      bloc: userBloc,
                      key: const Key('filter_dialog_widget'),
                    );
                  });
            },
          ),
        ),
      ],
    );
  }

  Widget buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: SizedBox(
        height: 100,
        child: SearchBarWidget(
          key: const Key('searchbar_view'),
          hint: 'Tempat cari user idaman',
          searchOnTap: (val) async {
            userBloc!.add(SearchUser(val));
          
          },
        ),
      ),
    );
  }
}
