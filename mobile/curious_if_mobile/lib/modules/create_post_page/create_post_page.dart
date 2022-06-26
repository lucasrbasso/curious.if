import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/core.dart';
import '../../../../domain/login/model/user_model.dart';
import '../../shared/bottom_text_navigation_bar/bottom_text_navigation_bar.dart';
import '../home/widgets/app_bar_home/app_bar_home.dart';
import 'create_post_controller.dart';
import 'form_create_post/form_create_post.dart';

class CreatePostPage extends StatefulWidget {
  final UserModel user;
  final VoidCallback onSuccess;
  const CreatePostPage({
    Key? key,
    required this.user,
    required this.onSuccess,
  }) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  late CreatePostController _createPostController;
  @override
  void initState() {
    _createPostController = CreatePostController();
    _createPostController.autoRun(context, widget.onSuccess);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("ta aq?");
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppThemeController().colorStatus,
      sized: false,
      child: Scaffold(
        backgroundColor: AppTheme.colors.background,
        appBar: AppBarHome(
          statusBarHeight: statusBarHeight,
          createPost: () {},
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 70, left: 38, right: 38),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            Center(
                child: Text("Envie sua Mensagem",
                    style: AppTheme.textStyles.textHeadingThree)),
            const SizedBox(height: 50),
            Text("Para:", style: AppTheme.textStyles.subtitleTextPost),
            const SizedBox(height: 2),
            FormCreatePostWidget(
              onSaved: (Map<String, dynamic> map) async {
                print(map);
                return await _createPostController.createPost(
                    user: widget.user,
                    content: map["message"],
                    to: map['name']);
              },
            )
          ],
        ),
        bottomNavigationBar: BottomTextNavigationBar(
          icon: Icon(Icons.arrow_back, color: AppTheme.colors.text, size: 18),
          onTap: () => Navigator.pop(context),
          text: "Voltar para a home",
        ),
      ),
    );
  }
}
