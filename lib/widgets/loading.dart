import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  Loading({
    this.loadingText,
    this.canShow = false,
  });
  final String loadingText;
  final bool canShow;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return canShow
        ? Container(
            color: Colors.black12,
            height: height,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation(Colors.black12),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 200, top: 16),
                  child: Text(
                    loadingText,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
