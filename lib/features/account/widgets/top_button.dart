import 'package:amazon_clone/features/account/widgets/account_button.dart';
import 'package:flutter/cupertino.dart';

class TopButton extends StatefulWidget {
  const TopButton({Key? key}) : super(key: key);

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: 'Your orders', onTap: (){}),

            AccountButton(text: 'Turn seller', onTap: (){}),


          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: [
            AccountButton(text: 'Log out', onTap: (){}),
            AccountButton(text: 'Your wish list', onTap: (){}),


          ],
        ),
      ],
    );
  }
}
