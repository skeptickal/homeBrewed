import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../client/spacing.dart';
import '../../constants/theme_data.dart';
import '../../cubits/item_cubit/item_cubit.dart';
import '../../models/item.dart';
import '../add_popups/add_item_screen.dart';
import '../edit_popups/edit_item_screen.dart';

class ItemsTab extends StatelessWidget {
  final String charID;
  const ItemsTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _ItemsList(charID: charID),
          seperation,
          _AddItem(charID: charID),
        ],
      ),
    );
  }
}

class _ItemsList extends StatelessWidget {
  final String? charID;
  const _ItemsList({required this.charID});

  @override
  Widget build(BuildContext context) {
    context.read<ItemCubit>().readItemsByCharID(charID);
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        List<Padding> items = state.items!.map(
          (item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: themeColor), borderRadius: BorderRadius.circular(20)),
                child: ListTile(
                  onTap: () => _onPressedTile(context: context, description: item.description ?? '', name: item.name ?? ''),
                  leading: IconButton(
                    onPressed: () {
                      _showPostEditPanel(context, item);
                    },
                    icon: const Icon(Icons.handyman),
                  ),
                  title: Text(
                    item.name ?? '',
                    style: dndFont.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'x${item.amount ?? ''}',
                    style: dndFont.copyWith(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete_forever_outlined,
                      color: black,
                    ),
                    onPressed: () => _onPressedDeleteIcon(
                      context: context,
                      itemID: item.itemID!,
                      name: item.name!,
                      charID: charID!,
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList();
        return Column(children: [
          seperation,
          SelectableText(
            'Items',
            style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          seperation,
          ...items
        ]);
      },
    );
  }
}

void _onPressedDeleteIcon({required BuildContext context, required String itemID, required String name, required String charID}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        'Are you sure you want to delete $name?',
        style: TextStyle(color: white, fontSize: 18),
      ),
      backgroundColor: themeColor,
      surfaceTintColor: themeColor,
      actions: [
        TextButton(
          child: Text(
            'Delete Permanently',
            style: TextStyle(color: white),
          ),
          onPressed: () {
            context.read<ItemCubit>().deleteItemByItemID(itemID).then((result) {
              context.read<ItemCubit>().readItemsByCharID(charID);
              context.pop();
            });
          },
        ),
      ],
    ),
  );
}

void _onPressedTile({required BuildContext context, required String name, required String description}) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text(
            '$name\n\n$description',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: white),
          ),
          backgroundColor: themeColor,
          surfaceTintColor: themeColor,
          actions: [
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(color: white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

class _AddItem extends StatelessWidget {
  final String charID;
  const _AddItem({required this.charID});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeColor,
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
          color: white,
          icon: const Icon(Icons.add),
          onPressed: () => _showEditPanel(context, charID),
        ),
      ),
    );
  }
}

void _showEditPanel(BuildContext context, String charID) {
  const uuid = Uuid();
  Item item = Item(charID: charID, itemID: uuid.v4(), name: '', description: '', amount: '');
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              surfaceTintColor: backgroundColor,
              backgroundColor: backgroundColor,
              title: AddItemScreen(item: item),
            ),
          ),
        );
      });
}

void _showPostEditPanel(BuildContext context, Item item) {
  showDialog(
    barrierDismissible: false,
    //barrierColor: black,
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: backgroundColor,
          title: EditItemScreen(item: item),
        ),
      ),
    ),
  );
}
