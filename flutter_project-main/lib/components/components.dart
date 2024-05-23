import 'package:flutter/material.dart';
import 'package:semster_project/components/validatorFucntions.dart';
import '../constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.buttonText,
      this.isOutlined = false,
      required this.onPressed,
      this.width = 280});

  final String buttonText;
  final bool isOutlined;
  final Function onPressed;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Material(
        borderRadius: BorderRadius.circular(8),
        elevation: 4,
        child: Container(
          width: width,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.white : kTextColor,
            border: Border.all(color: kTextColor, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: isOutlined ? kTextColor : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopScreenImage extends StatelessWidget {
  const TopScreenImage({super.key, required this.screenImageName});
  final String screenImageName;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage('assets/images/$screenImageName'),
          ),
        ),
      ),
    );
  }
}

class appbarTitle extends StatelessWidget {
  const appbarTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.normal, color: kBackgroundColor),
    );
  }
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 38, fontWeight: FontWeight.w500, color: kTextColor),
    );
  }
}

class CustomTitle extends StatelessWidget {
  const CustomTitle({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: "Roboto",
        color: kBackgroundColor,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.textField});
  final TextField textField;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 2,
          color: kTextColor,
        ),
      ),
      child: textField,
    );
  }
}

class CustomFormField extends StatefulWidget {
  CustomFormField({
    super.key,
    required this.textFormField,
  });

  final TextFormField textFormField;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      widget.textFormField
    ]);
  }
}

class CustomBottomScreen extends StatelessWidget {
  const CustomBottomScreen({
    super.key,
    required this.textButton,
    required this.question,
    this.heroTag = '',
    required this.buttonPressed,
    required this.questionPressed,
  });
  final String textButton;
  final String question;
  final String heroTag;
  final Function buttonPressed;
  final Function questionPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              questionPressed();
            },
            child: Text(
              question,
              style: TextStyle(color: kTextColor),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Hero(
            tag: heroTag,
            child: CustomButton(
              buttonText: textButton,
              width: 150,
              onPressed: () {
                buttonPressed();
              },
            ),
          ),
        ),
      ],
    );
  }
}

Alert signUpAlert({
  required Function onPressed,
  required String title,
  String desc = "",
  required String btnText,
  required BuildContext context,
}) {
  return Alert(
    closeIcon: Container(),
    context: context,
    title: title,
    style: AlertStyle(
        backgroundColor: kBackgroundColor,
        descStyle: TextStyle(
          fontSize: 20,
        ),
        titleStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
    desc: desc,
    buttons: [
      DialogButton(
        onPressed: () {
          onPressed();
        },
        width: 120,
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    ],
  );
}

Alert showAlert({
  required Function onPressed,
  required String title,
  required String desc,
  required BuildContext context,
  AlertType alertType = AlertType.error,
}) {
  return Alert(
    context: context,
    type: alertType,
    title: title,
    desc: desc,
    style: AlertStyle(backgroundColor: kBackgroundColor),
    buttons: [
      DialogButton(
        onPressed: () {
          onPressed();
        },
        width: 120,
        child: const Text(
          "OK",
          style: TextStyle(color: kBackgroundColor, fontSize: 20),
        ),
      )
    ],
  );
}

Container CustomContainer({required String title, required IconData icon}) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 15, 50, 15),
    width: 320,
    height: 150,
    decoration: BoxDecoration(
      color: kTextColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        CustomTitle(title: title),
        SizedBox(
          width: 60,
        ),
        Icon(
          icon,
          color: kBackgroundColor,
          size: 34,
        ),
      ],
    ),
  );
}

void PushNextScreen({required BuildContext context, required Widget widget}) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
