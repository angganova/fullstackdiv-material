import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/components/button/basic_button.dart';
import 'package:fullstackdiv_material/app/components/text_field/rect_text_field.dart';
import 'package:fullstackdiv_material/app/components/text_field/text_field_type.dart';
import 'package:fullstackdiv_material/system/global_extensions.dart';
import 'package:fullstackdiv_material/system/global_styles.dart';

class DialogAddNotesView extends StatefulWidget {
  const DialogAddNotesView({
    Key key,
    this.title,
    this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  _DialogAddNotesViewState createState() => _DialogAddNotesViewState();
}

class _DialogAddNotesViewState extends State<DialogAddNotesView> {
  final TextEditingController _notesTC = TextEditingController();

  AppTextStyle _appTextStyle;
  AppSpacer _appSpacer;
  AppQuery _appQuery;

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    _appQuery ??= AppQuery(context);
    _appTextStyle ??= AppTextStyle(context: context, color: Colors.black);

    return Dialog(
      insetPadding: _appSpacer.edgeInsets.all.standard,
      backgroundColor: kAppClearWhite,
      elevation: 0,
      child: Center(
        child: Container(
          width: _appQuery.width,
          padding: _appSpacer.edgeInsets.all.standard,
          decoration: BoxDecoration(
            color: kAppWhite,
            borderRadius: AppRadius.createExceptBotLeftRadius(
                kBorderRadiusMed, kBorderRadiusExtraTiny),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _appSpacer.vHsm,
              if (widget.title != null) _titleView,
              if (widget.title != null) _appSpacer.vHsm,
              if (widget.subtitle != null) _subtitleView,
              if (widget.subtitle != null) _appSpacer.vHsm,
              _textBoxView,
              _appSpacer.vHsm,
              Row(
                children: <Widget>[
                  Expanded(child: _cancelButtonView(context)),
                  _appSpacer.vWsm,
                  Expanded(child: _confirmButtonView(context)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _titleView {
    if (widget.title.isNullOrEmpty) {
      return Container();
    } else {
      return Text(widget.title,
          textAlign: TextAlign.center, style: _appTextStyle.primaryH2);
    }
  }

  Widget get _subtitleView {
    if (widget.subtitle.isNullOrEmpty) {
      return Container();
    } else {
      return Text(widget.subtitle,
          textAlign: TextAlign.center,
          style: widget.title.isNullOrEmpty
              ? _appTextStyle.primaryPL
              : _appTextStyle.primaryLabel1);
    }
  }

  Widget get _textBoxView {
    return AppRectangleBorderTextField(
      label: 'Notes',
      textEditingController: _notesTC,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.sentences,
      inputType: TextInputType.text,
      textFieldType: TextFieldType.largeField,
    );
  }

  Widget _confirmButtonView(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    return Container(
      padding: _appSpacer.edgeInsets.top.xs,
      child: BasicButton(
          margin: _appSpacer.edgeInsets.all.none,
          padding: _appSpacer.edgeInsets.all.sm,
          onPressed: () => Navigator.of(context).pop(_notesTC.text),
          title: 'Add Notes',
          fullWidth: true,
          shadowStrokeType: ShadowStrokeType.stroke2px),
    );
  }

  Widget _cancelButtonView(BuildContext context) {
    final AppSpacer _appSpacer = AppSpacer(context: context);
    return Container(
      padding: _appSpacer.edgeInsets.top.xs,
      child: BasicButton(
          margin: _appSpacer.edgeInsets.all.none,
          padding: _appSpacer.edgeInsets.all.sm,
          onPressed: () => Navigator.of(context).pop(),
          title: 'Cancel',
          fullWidth: true,
          widgetTheme: WidgetTheme.whitePrimary,
          shadowStrokeType: ShadowStrokeType.stroke2px),
    );
  }
}
