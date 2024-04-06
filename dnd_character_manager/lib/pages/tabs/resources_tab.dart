import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';

class ResourceTab extends StatelessWidget {
  const ResourceTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController value = TextEditingController();
    value.text = '1';
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
      children: [
        Center(
          child: Text(
            'E.g. Spell Slots\nMax 3, Current 2',
            style: dndFont.copyWith(fontStyle: FontStyle.italic, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
          child: Text(
            'Resources',
            style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        Center(
            child: IconButton(
          iconSize: 25,
          color: blueGrey,
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {},
        )),
        const _ResourceBox(),
        const _ResourceBox(),
        const _ResourceBox(),
        const _ResourceBox(),
      ],
    );
  }
}

class _ResourceBox extends StatelessWidget {
  const _ResourceBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: blueGrey, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onLongPress: () => showDialog(
          context: context,
          builder: (context) => Center(
            child: Text(
              'hello',
              style: dndFont.copyWith(color: white),
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
  }
}
