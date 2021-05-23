import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/coach_registration_vm.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/dimensions.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/media_query.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/styles/text_style.dart';
import 'package:fullstackdiv_material/app/screens/coach_registration/view/basic_child_view.dart';

class CoachProfilePictureView extends StatefulWidget {
  const CoachProfilePictureView({Key key, this.viewModel}) : super(key: key);
  final CoachRegistrationVM viewModel;
  @override
  _CoachProfilePictureViewState createState() =>
      _CoachProfilePictureViewState();
}

class _CoachProfilePictureViewState extends State<CoachProfilePictureView> {
  AppSpacer _appSpacer;
  AppQuery _appQuery;
  AppTextStyle _appTextStyle;

  File selectedFile;
  String selectedImagePath;

  @override
  Widget build(BuildContext context) {
    _appSpacer ??= AppSpacer(context: context);
    _appQuery ??= AppQuery(context);
    _appTextStyle ??= AppTextStyle(context: context);

    return CoachBasicChildView(
      parentBuildContext: widget.viewModel.widgetScaffoldContext,
      title: 'Profile Picture',
      child: _contentView,
      onSubmit: _ctaSubmit,
      onCancel: _ctaCancel,
    );
  }

  Widget get _contentView {
    return Column(
      children: <Widget>[
        _appSpacer.vHxxl,
        _profilePictureView,
        _appSpacer.vHsm,
        _uploadButtonView,
        _appSpacer.vHsm,
      ],
    );
  }

  Widget get _profilePictureView {
    Widget _profilePicture = Container();
    if (selectedFile == null) {
      _profilePicture = Icon(
        Icons.person_outline,
        size: _appQuery.width / 3,
      );
    } else {
      _profilePicture = ClipOval(
        child: Image.file(
          selectedFile,
          width: _appQuery.width / 2,
          height: _appQuery.width / 2,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      width: _appQuery.width / 2,
      padding: _appSpacer.edgeInsets.all.sm,
      decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.grey.shade200),
      child: _profilePicture,
    );
  }

  Widget get _uploadButtonView => Container(
        width: _appQuery.width / 3,
        child: RaisedButton(
          padding: _appSpacer.edgeInsets.y.xs,
          onPressed: _ctaUpload,
          color: Colors.indigo,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Text(
            'Upload',
            style: _appTextStyle.primaryPL.copyWith(color: Colors.white),
          ),
        ),
      );

  Future<void> _ctaUpload() async {
    final File file = await widget.viewModel.selectFile();
    if (file != null) {
      setState(() {});
    }
  }

  void _ctaSubmit() {
    if (_isValid) {
      widget.viewModel.ctaNext();
    } else {
      /// Show error display
    }
  }

  void _ctaCancel() {
    widget.viewModel.ctaBack();
  }

  bool get _isValid => true;
}
