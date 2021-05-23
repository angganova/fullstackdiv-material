import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/list_view/no_overscroll_list_view.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/auto_hide_footer.dart';

class CoachBasicChildView extends StatefulWidget {
  const CoachBasicChildView(
      {Key key,
      this.title,
      this.onSubmit,
      this.onCancel,
      this.child,
      this.parentBuildContext,
      this.scrollable = true})
      : super(key: key);

  final String title;
  final Widget child;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final BuildContext parentBuildContext;
  final bool scrollable;
  @override
  _CoachBasicChildViewState createState() => _CoachBasicChildViewState();
}

class _CoachBasicChildViewState extends State<CoachBasicChildView> {
  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    _appQuery ??= AppQuery(context);
    _appTextStyle ??= AppTextStyle(context: context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _appSpacer.vHsm,
          _titleView,
          _appSpacer.vHsm,
          Expanded(child: _contentView),
          _footerButtonView,
          _appSpacer.vHsm,
        ],
      ),
    );
  }

  Widget get _titleView => Container(
        width: _appQuery.width,
        padding: _appSpacer.edgeInsets.x.sm,
        child: Text(
          widget.title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: _appQuery.width / 22, fontWeight: FontWeight.bold),
        ),
      );

  Widget get _contentView => Container(
        padding: _appSpacer.edgeInsets.x.sm,
        alignment: widget.scrollable ? Alignment.topCenter : Alignment.center,
        child:
            NoOverScrollView(child: SingleChildScrollView(child: widget.child)),
      );

  Widget get _footerButtonView {
    return AppAutoHideFooter(
      parentContext: widget.parentBuildContext ?? context,
      child: Column(
        children: <Widget>[
          if (widget.onSubmit != null) _appSpacer.vHxs,
          if (widget.onSubmit != null) _submitButtonView,
          if (widget.onSubmit == null || widget.onCancel != null)
            _appSpacer.vHxs,
          if (widget.onCancel != null) _cancelButtonView,
        ],
      ),
    );
  }

  Widget get _submitButtonView {
    if (widget.onSubmit != null) {
      return Container(
        width: _appQuery.width,
        padding:
            EdgeInsets.symmetric(vertical: 0, horizontal: _appQuery.width / 5),
        child: RaisedButton(
          elevation: 0,
          padding: _appSpacer.edgeInsets.y.xs,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          color: Colors.indigo,
          onPressed: widget.onSubmit,
          child: Text(
            'Next',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: _appQuery.width / 20),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget get _cancelButtonView {
    if (widget.onCancel != null) {
      return Container(
        width: _appQuery.width,
        padding:
            EdgeInsets.symmetric(vertical: 0, horizontal: _appQuery.width / 5),
        child: FlatButton(
          onPressed: widget.onCancel,
          padding: _appSpacer.edgeInsets.y.xs,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            'Previous',
            style: TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.w600,
                fontSize: _appQuery.width / 20),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
