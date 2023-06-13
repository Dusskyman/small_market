import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:small_market/consts/app_consts.dart';
import 'package:small_market/pages/main_page/bloc/main_bloc.dart';
import 'package:small_market/pages/main_page/bloc/main_event.dart';
import 'package:small_market/pages/main_page/bloc/main_state.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: listener,
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: MediaQuery.of(context).size.height * 0.75,
                flexibleSpace: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SvgPicture.asset(AppConsts.marketImageRoute),
                  ),
                ),
              ),
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(border: Border.all()),
                      child: Text(
                        items[i],
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                  childCount: items.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 1,
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context
                        .read<MainBloc>()
                        .add(MainAddItemEvent(item: 'Item${items.length + 1}'));
                  },
                  child: const Icon(Icons.add),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    context.read<MainBloc>().add(const MainRemoveItemEvent());
                  },
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void listener(BuildContext context, MainState state) {
    if (state is MainSuccessfullyAddedState) {
      items.add(state.item);
    }
    if (state is MainSuccessfullyRemovedState) {
      if (items.isNotEmpty) {
        items.removeLast();
      }
    }
    if (state is MainLoadingState) {
      showDialog(
        context: context,
        useSafeArea: false,
        useRootNavigator: true,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
    if (state is MainLoadCompleteState) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
