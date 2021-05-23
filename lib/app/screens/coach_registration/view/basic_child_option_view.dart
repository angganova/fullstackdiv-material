import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';

class BasicChildOptionView extends StatelessWidget {
  const BasicChildOptionView(
      {Key key, this.onSubmit, this.onCancel, this.submitText, this.cancelText})
      : super(key: key);

  final String submitText;
  final String cancelText;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _bindButton(context, submitText, onSubmit),
        AppSpacer(context: context).vHsm,
        _bindButton(context, cancelText, onCancel),
      ],
    );
  }

  Widget _bindButton(BuildContext context, String text, VoidCallback callback) {
    return Container(
      width: AppQuery(context).width / 3,
      child: RaisedButton(
        elevation: 0,
        onPressed: callback,
        child: Text(
          text,
          style: const TextStyle(color: Colors.indigo),
        ),
        padding: AppSpacer(context: context).edgeInsets.y.xs,
        color: Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
