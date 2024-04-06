import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';

class ResourceTab extends StatelessWidget {
  const ResourceTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController value = TextEditingController();
    value.text = '1';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
        children: [
          const Center(
            child: SizedBox(),
          ),
          Center(
            child: Column(
              children: [
                Text(
                  'Resources\n',
                  style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      iconSize: 25,
                      color: themeColor,
                      icon: const Icon(Icons.add),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(),
          const _ResourceBox(),
          const _ResourceBox(),
          const _ResourceBox(),
          const _ResourceBox(),
        ],
      ),
    );
  }
}

class _ResourceBox extends StatelessWidget {
  const _ResourceBox();

  @override
  Widget build(BuildContext context) {
    Widget box = Container(
      decoration: BoxDecoration(
        border: Border.all(color: themeColor, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onLongPress: () => showDialog(
          context: context,
          builder: (context) => Center(
            child: Text(
              'hello',
              style: dndFont.copyWith(color: black),
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('ResourceName'),
            const Text('MAX : 4'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.remove),
                ),
                const Flexible(
                    child: TextField(
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '1',
                    hintStyle: TextStyle(fontSize: 18),
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                    ))
              ],
            ),
          ],
        ),
      ),
    );

    return box;
  }
}
