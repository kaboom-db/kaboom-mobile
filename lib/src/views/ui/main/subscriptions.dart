import 'package:flutter/material.dart';
import 'package:kaboom_dart/kaboom_dart.dart';
import 'package:kaboom_mobile/src/business_logic/api.dart';

class ComicSubsPage extends StatefulWidget {
  const ComicSubsPage({Key? key}) : super(key: key);

  @override
  State<ComicSubsPage> createState() => _ComicSubsPageState();
}

class _ComicSubsPageState extends State<ComicSubsPage> {
  List<Widget> elements = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Comics",
        ),
      ),
      body: Center(
        child: ListView(
          children: elements,
        ),
      ),
    );
  }

  Future<dynamic> getComics() async {
    print(KaboomAPI.accessToken);
    var results = await KaboomAPI.client?.accounts?.getComicSubs(KaboomAPI.accessToken);
    var comics = results?.results;
    var widgets = <Widget>[];

    comics?.forEach((element) {
      // Load all the progress elements
      var el = ProgressElement(sub: element);
      widgets.add(el);
    });

    setState(() {
      elements = widgets;
    });
  }
}

// --------------------------------------------------------------------

class CartoonSubsPage extends StatefulWidget {
  const CartoonSubsPage({Key? key}) : super(key: key);

  @override
  State<CartoonSubsPage> createState() => _CartoonSubsPageState();
}

class _CartoonSubsPageState extends State<CartoonSubsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: const [Text("Cartoon Subscriptions")],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------

class ProgressElement extends StatefulWidget {
  final ComicSubscription sub;
  const ProgressElement({Key? key, required this.sub}) : super(key: key);

  @override
  State createState() => _ProgressElementState();
}

class _ProgressElementState extends State<ProgressElement> {
  _ProgressElementState();

  @override
  Widget build(BuildContext context) {
    String? seriesName = widget.sub.series?.seriesName;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Image(
            image: Image.network('https://comicvine.gamespot.com/a/uploads/scale_small/6/67663/6418939-01.jpg').image,
            width: 75.0,
            // height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  seriesName!,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    child: const Text(
                      'Indicator',
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    padding: const EdgeInsets.all(5),
                  ),
                ),
                const Text(
                  '36%',
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.done,
                  ),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
            ),
          ),
        ],
        // mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
      ),
    );
  }
}
