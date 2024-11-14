import 'dart:developer';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quote_app/screens/home/data/models/quote_model.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class QuoteItem extends StatefulWidget {
  const QuoteItem({super.key, required this.data});

  final QuoteModel data;

  @override
  State<QuoteItem> createState() => _QuoteItemState();
}

class _QuoteItemState extends State<QuoteItem> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: screenshotController,
      child: Stack(
        fit: StackFit.expand,
        children: [
          drawImg(widget.data.imageLink!),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0, .6, 1],
                colors: [
                  Colors.blueGrey[800]!.withAlpha(70),
                  Colors.blueGrey[800]!.withAlpha(220),
                  Colors.blueGrey[800]!.withAlpha(255),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: widget.data.quote != null ? '“ ' : "",
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                    children: [
                      TextSpan(
                        text: widget.data.quote ?? "",
                        style: const TextStyle(
                          fontFamily: "Ic",
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      TextSpan(
                        text: widget.data.quote != null ? '”' : "",
                        style: const TextStyle(
                          fontFamily: "Ic",
                          fontWeight: FontWeight.w700,
                          color: Colors.green,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.data.author ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: "Ic",
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 40,
            right: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => copyQuote(context),
                  icon: const Icon(
                    Icons.copy,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () => shareQuote(),
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  shareQuote() async {
    final directory = (await getApplicationDocumentsDirectory()).path;
    screenshotController
        .captureAndSave(directory,
            fileName: 'screenshot_${DateTime.now().toIso8601String()}.png')
        .then((imagePath) async {
      if (imagePath != null) {
        await Share.shareXFiles([XFile(imagePath)], text: widget.data.quote);
      } else {
        log("Screenshot capture failed.");
      }
    }).catchError((onError) {
      log("Error: $onError");
    });
  }

  copyQuote(BuildContext context) {
    FlutterClipboard.copy(
      "${widget.data.quote} - ${widget.data.author}",
    ).then(
      (value) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Text Copied"),
        ),
      ),
    );
  }

  drawImg(String imageLink) {
    if (imageLink.isEmpty) {
      return const SizedBox();
    } else {
      return Image.network(imageLink, fit: BoxFit.cover);
    }
  }
}
