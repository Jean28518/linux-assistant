import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MintY {
  static Color currentColor = const Color(0xff6db443);

  static Color secondaryColor = const Color(0xff2ab9a4);

  static bool dark = false;
  static MaterialColor currentColorTheme = green;

  static Color colors(String color) {
    switch (color) {
      case "Green":
        // return Color(0xff92b372);
        return const Color(0xff6db443);
      case "Aqua":
        return const Color(0xff6cabcd);
      case "Blue":
        return const Color(0xff5b73c4);
      case "Brown":
        return const Color(0xffaa876a);
      case "Grey":
        return const Color(0xff9d9d9d);
      case "Orange":
        return const Color(0xffdb9d61);
      case "Pink":
        return const Color(0xffc76199);
      case "Purple":
        return const Color(0xff8c6ec9);
      case "Red":
        return const Color(0xffc15b58);
      case "Sand":
        return const Color(0xffc8ac69);
      case "Teal":
        return const Color(0xff5aaa9a);
    }
    return const Color(0xff92b372);
  }

// Generated with: https://maketintsandshades.com/
  static const green = MaterialColor(
    0xff6db443,
    <int, Color>{
      50: Color(0xffb6daa1), //50% Hell
      100: Color(0xffa7d28e), //40% Hell
      200: Color(0xff99cb7b), //30% Hell
      300: Color(0xff8ac369), //20% Hell
      400: Color(0xff7cbc56), //10% Hell
      500: Color(0xff62a23c), //10% Dunkel
      600: Color(0xff579036), //20% Dunkel
      700: Color(0xff4c7e2f), //30% Dunkel
      800: Color(0xff416c28), //40% Dunkel
      900: Color(0xff375a22), //50% Dunkel
    },
  );

  static BoxDecoration colorfulBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: const [0, 1],
      colors: [currentColor, secondaryColor],
    ),
  );

  static const Color _white = Color.fromARGB(255, 255, 255, 255);

  static const heading1White = TextStyle(
      color: _white,
      fontSize: 32,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);

  static const heading1 = TextStyle(
      color: Colors.black87,
      fontSize: 32,
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.none);

  static const heading2White = TextStyle(
      color: _white,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static const heading2 = TextStyle(
      color: Colors.black87,
      fontSize: 24,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static const heading3White = TextStyle(
      color: _white,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static const heading3 = TextStyle(
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static const heading4White = TextStyle(
      color: _white,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static const heading4 = TextStyle(
      color: Colors.black87,
      fontSize: 17,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.none);

  static const paragraph = TextStyle(
      fontWeight: FontWeight.w300,
      color: Colors.black87,
      decoration: TextDecoration.none,
      fontSize: 15);

  static const paragraphWhite = TextStyle(
    fontWeight: FontWeight.w300,
    color: _white,
    decoration: TextDecoration.none,
    fontSize: 15,
  );

  static ThemeData theme() => ThemeData(
      useMaterial3: true,
      primaryColor: currentColor,
      brightness: Brightness.light,
      // backgroundColor: Colors.white70,
      textTheme: const TextTheme(
        displayLarge: heading1,
        headlineLarge: heading2,
        headlineMedium: heading3,
        headlineSmall: heading4,
        bodyMedium: paragraph,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MintY.currentColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: MintY.currentColor, width: 2, style: BorderStyle.solid),
        ),
      ),
      textSelectionTheme:
          TextSelectionThemeData(selectionColor: MintY.currentColor));

  static ThemeData themeDark() => ThemeData(
      useMaterial3: true,
      primaryColor: currentColor,
      canvasColor: const Color.fromARGB(255, 31, 31, 31),
      brightness: Brightness.dark,
      // backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      cardColor: const Color.fromARGB(255, 45, 45, 45),
      highlightColor: _white,
      textTheme: const TextTheme(
        displayLarge: heading1White,
        headlineLarge: heading2White,
        headlineMedium: heading3White,
        headlineSmall: heading4White,
        bodyMedium: paragraphWhite,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: MintY.currentColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: MintY.currentColor, width: 2, style: BorderStyle.solid),
        ),
      ),
      textSelectionTheme:
          TextSelectionThemeData(selectionColor: MintY.currentColor));

  static void showMessage(
      BuildContext context, String message, VoidCallback? callback) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      message,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  MintYButton(
                    text: Text(
                      AppLocalizations.of(context)!.close,
                      style: MintY.heading3,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      callback?.call();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MintYPage extends StatelessWidget {
  late String title;
  late List<Widget> contentElements;
  late Widget customContentElement;
  Widget? bottom;

  MintYPage(
      {super.key,
      String title = "",
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
            Container(height: 8),
            contentElements.isNotEmpty
                ? Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: ListView(
                          shrinkWrap: true,
                          children: contentElements,
                        ),
                      ),
                    ),
                  )
                : customContentElement,
            Container(height: 8),
            bottom != null
                ? SizedBox(
                    height: 80,
                    child: Center(child: bottom),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class MintYButton extends StatelessWidget {
  late Widget text;
  late IconData? icon;

  /// deprecated, use [textColor] and [backgroundColor] instead
  late Color color;
  late Color backgroundColor;

  /// Only used for icon color currently:
  late Color textColor;
  VoidCallback? onPressed;
  late double width;
  late double height;
  late String? tooltip;

  MintYButton(
      {super.key,
      this.text = const Text(""),
      this.icon,

      /// deprecated, use [textColor] and [backgroundColor] instead
      Color color = const Color.fromARGB(0, 0, 0, 0),
      this.backgroundColor = const Color.fromARGB(0, 0, 0, 0),

      /// Only used for icon color currently:
      this.textColor = const Color.fromARGB(255, 255, 255, 255),
      this.tooltip,
      VoidCallback? onPressed,
      double width = 110,
      double height = 40}) {
    text = text;
    this.color = color;
    this.onPressed = onPressed;
    this.width = width;
    this.height = height;

    if (backgroundColor == const Color.fromARGB(0, 0, 0, 0)) {
      this.backgroundColor = color;
    } else {
      this.backgroundColor = backgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    var buttonChildren = <Widget>[];

    if (icon != null) {
      buttonChildren.add(
        Icon(
          icon,
          color: textColor,
        ),
      );
      if (text is Text && (text as Text).data.toString().isNotEmpty) {
        buttonChildren.add(const SizedBox(width: 8));
      } else if (text is String && text.toString().isNotEmpty) {
        buttonChildren.add(const SizedBox(width: 8));
      }
    }

    if (text is Text) {
      buttonChildren.add(
        text as Text,
      );
    } else {
      buttonChildren.add(text);
    }

    Widget button = Container(
      constraints: BoxConstraints(minWidth: width, minHeight: height),
      child: ElevatedButton(
        key: UniqueKey(),
        onPressed: () {
          onPressed?.call();
        },
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(backgroundColor),
        ),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonChildren),
      ),
    );

    if (tooltip != null && tooltip!.isNotEmpty) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    } else {
      return button;
    }
  }
}

class MintYButtonNavigate extends StatelessWidget {
  late Widget route;

  /// will be called before the button navigates
  late VoidCallback? onPressed;

  late Text text;
  late Color color;
  late double width;
  late double height;

  MintYButtonNavigate(
      {required this.route,
      this.text = const Text("Text"),
      this.color = const Color.fromARGB(255, 232, 232, 232),
      this.width = 110,
      this.height = 40,
      this.onPressed,
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
        onPressed?.call();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => route),
        );
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
        AppLocalizations.of(context)!.next,
        style: MintY.heading4White,
      ),
      color: MintY.currentColor,
      onPressed: () async {
        onPressed?.call();
        if (onPressedFuture != null) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const MintYLoadingPage(),
          ));
          await onPressedFuture!.call();
        }
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
            padding: const EdgeInsets.all(15),
            height: 400,
            width: 350,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(10),
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
              const SizedBox(
                height: 30,
              ),
              Text(widget.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 16,
              ),
              Text(
                widget.text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
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

  /// Shows only info text if [selected] == [showInfoTextAtThisSelectionState]
  late Text? infoText;

  /// Shows only info text if [selected] == [showInfoTextAtThisSelectionState]
  bool showInfoTextAtThisSelectionState = false;

  VoidCallback? onPressed;

  MintYSelectableEntryWithIconHorizontal(
      {this.icon = const Icon(Icons.umbrella),
      this.title = "Title",
      this.text = "Lorem Ipsum...",
      this.selected = false,
      this.onPressed,
      this.infoText,
      this.showInfoTextAtThisSelectionState = false,
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
      padding: const EdgeInsets.all(8),
      child: Card(
        child: InkWell(
          onTap: () {
            setState(() {
              widget.selected = !widget.selected;
            });
            widget.onPressed?.call();
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [widget.icon],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        widget.text,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 100,
                      ),
                      widget.infoText != null &&
                              widget.showInfoTextAtThisSelectionState ==
                                  widget.selected
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: widget.infoText!,
                            )
                          : Container(),
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
          padding: const EdgeInsets.all(15),
          height: 400,
          width: 300,
          child: Column(
            children: [
              const SizedBox(height: 15),
              icon,
              const SizedBox(height: 20),
              Text(title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: 20),
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
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
  late Widget? customWidgetBetweenButtonAndText;
  VoidCallback? onPressed;

  MintYCardWithIconAndAction({
    Key? key,
    this.icon = const Text(""),
    this.title = "Title",
    this.text = "Lorem ipsum...",
    this.buttonText = "Button",
    this.customWidgetBetweenButtonAndText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  icon,
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          text,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              if (customWidgetBetweenButtonAndText != null)
                customWidgetBetweenButtonAndText!,
              if (customWidgetBetweenButtonAndText == null)
                const SizedBox(height: 8),
              Center(
                child: MintYButton(
                  text: Text(
                    buttonText,
                    style: MintY.heading4White,
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

class MintYGrid extends StatelessWidget {
  List<Widget> children;
  double padding;
  double ratio;
  double widgetSize;
  MintYGrid(
      {super.key,
      required this.children,
      this.padding = 10.0,
      this.ratio = 350 / 150,
      this.widgetSize = 450});

  @override
  Widget build(BuildContext context) {
    List<Widget> childrenCopy = List.from(children);
    int columsCount =
        ((MediaQuery.of(context).size.width - (2 * padding)) / (widgetSize))
            .round();

    // Insert space Elements for last row, that the elements are something like centered
    if ((childrenCopy.length % columsCount) != 0) {
      int spacingCounts =
          ((columsCount - (childrenCopy.length % columsCount)) / 2).floor();
      for (int i = 0; i < spacingCounts; i++) {
        childrenCopy.insert(
            childrenCopy.length - childrenCopy.length % columsCount,
            Container());
      }
    }
    return Expanded(
      child: GridView.count(
        // mainAxisAlignment: MainAxisAlignment.center,
        padding: EdgeInsets.all(padding),
        crossAxisCount: columsCount,
        childAspectRatio: ratio,
        children: childrenCopy,
      ),
    );
  }
}

/// Icon on the left side, on the right side heading with description.
class MintYFeature extends StatelessWidget {
  String heading;
  String description;
  Widget icon;
  MintYFeature(
      {super.key,
      required this.heading,
      required this.description,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: icon,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                heading,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class MintYProgressIndicatorCircle extends StatelessWidget {
  const MintYProgressIndicatorCircle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80,
        width: 80,
        child: CircularProgressIndicator(color: MintY.currentColor),
      ),
    );
  }
}

/// data should be a 2D list of strings
/// First row are headings
class MintYTable extends StatelessWidget {
  List<List<dynamic>> data;
  MintYTable({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = [];
    for (int i = 0; i < data.length; i++) {
      List<TableCell> cells = [];
      for (int j = 0; j < data[i].length; j++) {
        cells.add(
          TableCell(
            child: Text(
              data[i][j].toString(),
              style: i == 0
                  ? Theme.of(context).textTheme.headlineMedium
                  : Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      tableRows.add(
        TableRow(
          children: cells,
        ),
      );
    }
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: tableRows,
    );
  }
}

/// As default text "Loading..." will be taken.
class MintYLoadingPage extends StatelessWidget {
  final String text;
  const MintYLoadingPage({Key? key, this.text = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 80,
              width: 80,
              child: MintYProgressIndicatorCircle(),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              text == "" ? AppLocalizations.of(context)!.loading : text,
              style: Theme.of(context).textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}

class MintYCheckboxSetting extends StatefulWidget {
  late String text;
  late bool value;

  /// Callback function that takes as parameter the new value of the setting
  late Function(bool) onChanged;

  MintYCheckboxSetting(
      {super.key,
      required this.text,
      required this.value,
      required this.onChanged});

  @override
  State<MintYCheckboxSetting> createState() => _MintYCheckboxSettingState();
}

class _MintYCheckboxSettingState extends State<MintYCheckboxSetting> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Checkbox(
            value: widget.value,
            onChanged: (bool? newValue) {
              setState(() {
                widget.value = newValue!;
                widget.onChanged.call(newValue);
              });
            },
            activeColor: MintY.currentColor,
          ),
        ],
      ),
    );
  }
}

class MintYTextSetting extends StatefulWidget {
  late String text;
  late String value;
  late TextAlign textAlign;
  late Function(String) onChanged;

  MintYTextSetting(
      {super.key,
      required this.text,
      required this.value,
      required this.textAlign,
      required this.onChanged});

  @override
  State<MintYTextSetting> createState() => _MintYTextSettingState();
}

class _MintYTextSettingState extends State<MintYTextSetting> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          SizedBox(
            width: 200,
            child: TextField(
              controller: controller,
              onChanged: (String newValue) {
                widget.onChanged.call(newValue);
              },
              textAlign: widget.textAlign,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: MintY.currentColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: MintY.currentColor,
                      width: 2,
                      style: BorderStyle.solid),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
