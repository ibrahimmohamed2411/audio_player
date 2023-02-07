import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/state_management/view_state.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../generated/l10n.dart';
import '../../../../locator/locator.dart';
import '../view_models/home_view_model.dart';
import '../widgets/mini_player.dart';
import '../widgets/songs_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? selectedAudio;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (context) => locator<HomeViewModel>()..getSongs(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).app_title),
        ),
        body: SafeArea(
          child: CustomContainer(
            child: Selector<HomeViewModel, ViewState>(
              selector: (p0, p1) => p1.songsViewState,
              builder: (context, value, child) {
                final model = context.read<HomeViewModel>();
                switch (model.songsViewState) {
                  case ViewState.initial:
                  case ViewState.loading:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ViewState.error:
                    return Center(
                      child: Text(
                        model.errorMsg,
                      ),
                    );
                  case ViewState.success:
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        SongsListView(
                          songsList: model.songs,
                        ),
                        MiniPlayer(),
                      ],
                    );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
