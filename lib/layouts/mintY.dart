import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MintY {
  static Color currentColor = Color(0xff6db443);

  static MaterialColor currentColorTheme = green;

  static Color colors(String color) {
    switch (color) {
      case "Green":
        // return Color(0xff92b372);
        return Color(0xff6db443);
      case "Aqua":
        return Color(0xff6cabcd);
      case "Blue":
        return Color(0xff5b73c4);
      case "Brown":
        return Color(0xffaa876a);
      case "Grey":
        return Color(0xff9d9d9d);
      case "Orange":
        return Color(0xffdb9d61);
      case "Pink":
        return Color(0xffc76199);
      case "Purple":
        return Color(0xff8c6ec9);
      case "Red":
        return Color(0xffc15b58);
      case "Sand":
        return Color(0xffc8ac69);
      case "Teal":
        return Color(0xff5aaa9a);
    }
    return Color(0xff92b372);
  }

// Generated with: https://maketintsandshades.com/
  static const green = MaterialColor(
    0xff6db443,
    const <int, Color>{
      50: const Color(0xffb6daa1), //50% Hell
      100: const Color(0xffa7d28e), //40% Hell
      200: const Color(0xff99cb7b), //30% Hell
      300: const Color(0xff8ac369), //20% Hell
      400: const Color(0xff7cbc56), //10% Hell
      500: const Color(0xff62a23c), //10% Dunkel
      600: const Color(0xff579036), //20% Dunkel
      700: const Color(0xff4c7e2f), //30% Dunkel
      800: const Color(0xff416c28), //40% Dunkel
      900: const Color(0xff375a22), //50% Dunkel
    },
  );

  static const BoxDecoration colorfulBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0, 1],
      colors: [Colors.blue, Color(0xff2ab9a4)],
    ),
  );

  static const heading1White = TextStyle(
      color: Colors.white,
      fontSize: 48,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static const heading1 = TextStyle(
      color: Colors.black87,
      fontSize: 48,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static const heading2White = TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.w300,
      decoration: TextDecoration.none);

  static const heading2 = TextStyle(
      color: Colors.black87,
      fontSize: 32,
      fontWeight: FontWeight.w300,
      decoration: TextDecoration.none);

  static const paragraph = TextStyle(
      fontWeight: FontWeight.w300,
      color: Colors.black87,
      decoration: TextDecoration.none,
      fontSize: 20);

  static const paragraphWhite = TextStyle(
      fontWeight: FontWeight.w300,
      color: Colors.white,
      decoration: TextDecoration.none,
      fontSize: 20);

  static ThemeData theme() => ThemeData(
        primaryColor: currentColor,
        brightness: Brightness.light,
        backgroundColor: Colors.white70,
        textTheme: const TextTheme(
          headline1: heading1,
          headline2: heading2,
          bodyText1: paragraph,
        ),
      );

  static ThemeData themeDark() => ThemeData(
        primaryColor: currentColor,
        canvasColor: Colors.black87,
        brightness: Brightness.dark,
        backgroundColor: Colors.black87,
        textTheme: const TextTheme(
          headline1: heading1White,
          headline2: heading2White,
          bodyText1: paragraphWhite,
        ),
      );
}

class MintYPage extends StatelessWidget {
  late String title;
  late List<Widget> contentElements;
  late Widget customContentElement;
  Widget? bottom;

  MintYPage(
      {String title = "",
      List<Widget> contentElements = const [],
      Widget customContentElement = const Text(""),
      Widget? bottom}) {
    this.title = title;
    this.contentElements = contentElements;
    this.customContentElement = customContentElement;
    this.bottom = bottom;
  }

  final ScrollController scrollController = ScrollController();

  // void _scrollListener() {
  //   // you can access the height of ListView content using maxScrollExtent
  //   print(_controller.position.maxScrollExtent);

  //   // if you wanna get once you can directly removeListener
  //   // _controller.removeListener(_scrollListener);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        key: UniqueKey(),
        child: Column(
          children: [
            Container(
              decoration: MintY.colorfulBackground,
              padding: const EdgeInsets.all(26.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: MintY.heading2White,
                  ),
                ],
              ),
            ),
            Container(height: 8, color: Theme.of(context).canvasColor),
            contentElements.length != 0
                ? Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      color: Theme.of(context).canvasColor,
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: contentElements,
                        ),
                      ),
                    ),
                  )
                : customContentElement,
            Container(height: 8, color: Theme.of(context).canvasColor),
            bottom != null
                ? Container(
                    height: 80,
                    child: Center(child: bottom),
                    // color: Theme.of(context).backgroundColor,
                    color:
                        // scrollController.position.maxScrollExtent + 80.0 + 89.0 >
                        //         MediaQuery.of(context).size.height
                        //     ? Colors.red
                        //     : Colors.green,  // Does not work!
                        Theme.of(context).canvasColor,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class MintYButton extends StatelessWidget {
  late Text text;
  late Color color;
  VoidCallback? onPressed;
  late double width;
  late double height;

  MintYButton(
      {Text text = const Text(""),
      Color color = const Color.fromARGB(255, 232, 232, 232),
      VoidCallback? onPressed,
      double width = 160,
      double height = 60}) {
    this.text = text;
    this.color = color;
    this.onPressed = onPressed;
    this.width = width;
    this.height = height;
  }

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(minWidth: width, minHeight: height),
        child: ElevatedButton(
          key: UniqueKey(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[text],
          ),
          onPressed: () {
            onPressed?.call();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color),
          ),
        ),
      );
}

class MintYButtonNavigate extends StatelessWidget {
  late Widget route;
  late Text text;
  late Color color;
  late double width;
  late double height;

  MintYButtonNavigate(
      {required this.route,
      this.text = const Text("Text"),
      this.color = const Color.fromARGB(255, 232, 232, 232),
      this.width = 160,
      this.height = 60,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MintYButton(
      text: text,
      color: color,
      width: width,
      height: height,
      onPressed: () {
        if (route != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => route),
          );
        }
      },
    );
  }
}

class MintYButtonNext extends StatelessWidget {
  late Widget route;

  /// will be called before the button navigates
  late VoidCallback? onPressed;

  /// will be called before the button navigates
  late AsyncCallback? onPressedFuture;

  MintYButtonNext(
      {required this.route, this.onPressed, this.onPressedFuture, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MintYButton(
      text: Text(
        "Next",
        style: MintY.heading2White,
      ),
      color: MintY.currentColor,
      onPressed: () async {
        onPressed?.call();
        await onPressedFuture?.call();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
      },
    );
  }
}

class MintYSelectableCardWithIcon extends StatefulWidget {
  final Widget icon;
  final String title;
  final String text;
  bool selected;
  final VoidCallback? onPressed;

  MintYSelectableCardWithIcon(
      {this.icon = const Icon(Icons.umbrella),
      this.title = "Title",
      this.text = "Lorem ipsum...",
      this.selected = false,
      this.onPressed,
      super.key});

  @override
  State<MintYSelectableCardWithIcon> createState() =>
      _MintYSelectableCardWithIconState();
}

class _MintYSelectableCardWithIconState
    extends State<MintYSelectableCardWithIcon> {
  _MintYSelectableCardWithIconState();

  void localOnPressed() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() {
              widget.selected = !widget.selected;
            });
            widget.onPressed?.call();
          },
          child: Container(
            padding: EdgeInsets.all(15),
            height: 400,
            width: 350,
            child: Column(children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 30,
                child: widget.selected
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.check,
                            size: 30,
                            color: MintY.currentColor,
                          )
                        ],
                      )
                    : null,
              ),
              widget.icon,
              SizedBox(
                height: 30,
              ),
              Text(widget.title,
                  style: MintY.heading2, textAlign: TextAlign.center),
              SizedBox(
                height: 30,
              ),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: MintY.paragraph,
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class MintYSelectableEntryWithIconHorizontal extends StatefulWidget {
  late Widget icon;
  late String title;
  late String text;
  late bool selected;
  VoidCallback? onPressed;

  MintYSelectableEntryWithIconHorizontal(
      {this.icon = const Icon(Icons.umbrella),
      this.title = "Title",
      this.text = "Lorem Ipsum...",
      this.selected = false,
      this.onPressed,
      super.key});

  @override
  State<MintYSelectableEntryWithIconHorizontal> createState() =>
      _MintYSelectableEntryWithIconHorizontalState();
}

class _MintYSelectableEntryWithIconHorizontalState
    extends State<MintYSelectableEntryWithIconHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() {
              widget.selected = !widget.selected;
            });
            widget.onPressed?.call();
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [widget.icon],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        widget.title,
                        style: MintY.heading2,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.text,
                        style: MintY.paragraph,
                        maxLines: 100,
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      child: widget.selected
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.check,
                                  size: 30,
                                  color: MintY.currentColor,
                                )
                              ],
                            )
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MintYButtonBigWithIcon extends StatelessWidget {
  late Widget icon;
  late String title;
  late String text;
  VoidCallback? onPressed;

  MintYButtonBigWithIcon({
    Key? key,
    Widget icon = const Icon(Icons.umbrella),
    String title = "Title",
    String text = "Lorem ipsum...",
    VoidCallback? onPressed,
  }) : super(key: key) {
    this.icon = icon;
    this.title = title;
    this.text = text;
    this.onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          onPressed?.call();
        },
        child: Container(
          padding: EdgeInsets.all(15),
          height: 400,
          width: 300,
          child: Column(
            children: [
              SizedBox(height: 15),
              icon,
              SizedBox(height: 20),
              Text(title, style: MintY.heading2, textAlign: TextAlign.center),
              SizedBox(height: 20),
              Text(
                text,
                textAlign: TextAlign.center,
                style: MintY.paragraph,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MintYCardWithIconAndAction extends StatelessWidget {
  late Widget icon;
  late String title;
  late String text;
  late String buttonText;
  VoidCallback? onPressed;

  MintYCardWithIconAndAction({
    Key? key,
    Widget icon = const Text(""),
    String title = "Title",
    String text = "Lorem ipsum...",
    String buttonText = "Button",
    VoidCallback? onPressed,
  }) : super(key: key) {
    this.icon = icon;
    this.title = title;
    this.text = text;
    this.buttonText = buttonText;
    this.onPressed = onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  icon,
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        SizedBox(height: 8),
                        Text(
                          text,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Center(
                child: MintYButton(
                  text: Text(
                    buttonText,
                    style: MintY.heading2White,
                  ),
                  color: MintY.currentColor,
                  onPressed: () {
                    onPressed?.call();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MintYProgressIndicatorCircle extends StatelessWidget {
  const MintYProgressIndicatorCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: CircularProgressIndicator(color: MintY.currentColor),
        height: 80,
        width: 80,
      ),
    );
  }
}
