import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_switch/app.dart';
import '../../widgets/widgets.dart';
import '../pages/pages.dart';
import 'screens.dart';

class HomeScreen extends StatefulWidget {


  const HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ValueNotifier<int> pageIndex = ValueNotifier(0);
  final ValueNotifier<String> title = ValueNotifier("Messages");
  final pages = const [
    MessagesPage(),
    NotificationsPage(),
    CallsPage(),
    ContactsPage()
  ];
  final titles = ["Messages", "Notification", "Calls", "Contacts"];

  void _onNavItemsSelected(i) {
    title.value = titles[i];
    pageIndex.value = i;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        toolbarHeight: 100,
        leading: IconBackground(
          icon: CupertinoIcons.search,
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 35.0),
            child: Hero(
              tag: 'hero-profile-image',
              child: Avatar.medium(
                onPressed: (){Get.to(()=> const ProfileScreen());},
                url: user.image,
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: ValueListenableBuilder(
            valueListenable: title,
            builder: (BuildContext context, String value, _) {
              return Text(value);
            }),
      ),
      body: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (BuildContext context, int value, _) {
            return pages[value];
          }),
      bottomNavigationBar:
          _BottomNavigationBar(onItemSelected: _onNavItemsSelected),
    );
  }
}

class _BottomNavigationBar extends StatefulWidget {
  const _BottomNavigationBar({
    Key key,
    this.onItemSelected,
  }) : super(key: key);

  final ValueChanged onItemSelected;

  @override
  State<_BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<_BottomNavigationBar> {
  var selectedIndex = 0;
  void handleItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onItemSelected(index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavigationBarItems(
              icon: CupertinoIcons.bubble_left_bubble_right_fill,
              label: "Messages",
              index: 0,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 0),
            ),
            _NavigationBarItems(
              icon: CupertinoIcons.bell_fill,
              label: "Notifications",
              index: 1,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: GlowingActionButton(
                size: 35,
                icon: CupertinoIcons.plus,
                color: Colors.blue.shade800,
                onPressed: () {},
              ),
            ),
            _NavigationBarItems(
              icon: CupertinoIcons.phone_fill,
              label: "Calls",
              index: 2,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 2),
            ),
            _NavigationBarItems(
              icon: CupertinoIcons.person_2_fill,
              label: "Contacts",
              index: 3,
              onTap: handleItemSelected,
              isSelected: (selectedIndex == 3),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationBarItems extends StatelessWidget {
  const _NavigationBarItems(
      {Key key,
      this.icon,
      this.label,
      this.index,
      this.onTap,
      this.isSelected = false})
      : super(key: key);

  final ValueChanged<int> onTap;
  final IconData icon;
  final String label;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onDoubleTap: () {
        onTap(index);
      },
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.blue.shade800 : null,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(label,
                style: isSelected
                    ? TextStyle(color: Colors.blue.shade800, fontSize: 12)
                    : const TextStyle(fontSize: 12))
          ],
        ),
      ),
    );
  }
}
