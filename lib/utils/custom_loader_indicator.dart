import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_loader.dart';

bool _isShowing = false;
BuildContext _context, _dismissingContext;

// ignore: must_be_immutable
class _Body extends StatefulWidget {
  _State _dialog = _State();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _dialog;
  }

  update() {
    _dialog.update();
  }
}

class _State extends State<_Body> {
  update() {
    setState(() {});
  }

  @override
  void dispose() {
    _isShowing = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.50),
      // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Center(
        child: CustomScreenLoader(
          height: 150,
          width: 150,
        ),
      ),
    );
  }
}

class CustomScreenLoader extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;

  const CustomScreenLoader(
      {Key key,
        this.backgroundColor = const Color(0xfff8f8f8),
        this.height = 30,
        this.width = 30})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Loader(),
      ),
    );
  }
}

class CustomLoader {
  _Body _dialog;

  CustomLoader(BuildContext context) {
    _context = context;
  }

  bool isShowing() {
    return _isShowing;
  }

  Future<bool> hideLoader() {
    return Future.delayed(const Duration(milliseconds: 100), () {
      if (_isShowing) {
        try {
          _isShowing = false;
          if (Navigator.of(_dismissingContext).canPop())
            Navigator.of(_dismissingContext).pop();

          return Future.value(true);
        } catch (_) {
          return Future.value(false);
        }
      } else {
        return Future.value(false);
      }
    });
  }

  void showLoader() {
    new Future.delayed(const Duration(milliseconds: 50), () {
      _show();
    });
  }

  void _show() {
    if (!_isShowing) {
      _dialog = new _Body();
      _isShowing = true;

      showGeneralDialog(
        barrierDismissible: false,
        barrierColor: Colors.white.withOpacity(0.50),
        transitionDuration: const Duration(milliseconds: 200),
        context: _context,
        pageBuilder: (BuildContext context, Animation animation,
            Animation secondaryAnimation) {
          _dismissingContext = context;

          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: _dialog,
          );
        },
      );
    }
  }
}
