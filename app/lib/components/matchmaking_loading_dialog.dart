import 'package:flutter/material.dart';

class MatchmakingLoadingDialog extends StatefulWidget {
  final Function onClose;

  const MatchmakingLoadingDialog({Key? key, required this.onClose})
      : super(key: key);

  @override
  State<MatchmakingLoadingDialog> createState() =>
      _MatchmakingLoadingDialogState();
}

class _MatchmakingLoadingDialogState extends State<MatchmakingLoadingDialog>
    with SingleTickerProviderStateMixin {
  var _animationController;

  var _colorTween;

  @override
  void initState() {
    _animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    _colorTween = _animationController
        .drive(ColorTween(begin: Colors.yellow, end: Colors.blue));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  dialogContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          const SizedBox(height: 16.0),
          const Text(
            'Looking for opponent...',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(
                valueColor: _colorTween,
                backgroundColor: Colors.grey,
                strokeWidth: 10,
              )),
          const SizedBox(height: 16.0),
          TextButton(
            onPressed: () => {widget.onClose.call(), Navigator.pop(context)},
            child: const Text(
              "Cancel",
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
