import 'package:flutter/material.dart';
import 'package:flutter_mildang/model/login_model.dart';
import 'package:flutter_mildang/widgets/textfield.dart';
import 'package:go_router/go_router.dart';

class RowTitleRequiredField extends StatelessWidget {
  const RowTitleRequiredField({super.key, required this.title, this.required});
  final String title;
  final bool? required;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 32,
        bottom: 6,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
            child: required != null
                ? Text(
                    '*',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key, this.user});
  final tfController = TextEditingController();
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마이페이지 수정'),
        titleTextStyle: Theme.of(context).textTheme.titleLarge,
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
        ),
        // backgroundColor: ,
        forceMaterialTransparency: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('저장'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const RowTitleRequiredField(
                  title: '휴대폰 번호',
                  required: true,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextfieldCustom(
                        textEditingController: tfController,
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text('인증'))
                  ],
                ),
                const RowTitleRequiredField(
                  title: '생년월일/ 성별',
                  required: true,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextfieldCustom(
                        textEditingController: tfController,
                      ),
                    ),
                    ElevatedButton(onPressed: () {}, child: const Text('인증'))
                  ],
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.canPop() ? context.pop() : () {};
                  },
                  child: const Text('go back'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Log out'),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/edit');
                //   },
                //   child: const Text('Edit profile'),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
