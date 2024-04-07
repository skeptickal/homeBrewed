import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/item_cubit/item_cubit.dart';
import '../models/item.dart';

class EditItemScreen extends StatelessWidget {
  final Item item;
  const EditItemScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    print('Jeff ${item.itemID}');
    TextEditingController name = TextEditingController(text: item.name);
    TextEditingController amount = TextEditingController(text: item.amount);
    TextEditingController description = TextEditingController(text: item.description);

    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<ItemCubit>().setItemsData(item.copyWith(
                          name: name.text,
                          description: description.text,
                          amount: amount.text,
                        ));
                    context.read<ItemCubit>().readItemsByCharID(item.charID);
                  },
                  onEditingComplete: () {
                    context.read<ItemCubit>().setItemsData(item.copyWith(
                          name: name.text,
                          description: description.text,
                          amount: amount.text,
                        ));
                    context.read<ItemCubit>().readItemsByCharID(item.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'Item name',
                  subtitle: 'Item name',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<ItemCubit>().setItemsData(item.copyWith(
                          name: name.text,
                          description: description.text,
                          amount: amount.text,
                        ));
                    context.read<ItemCubit>().readItemsByCharID(item.charID);
                  },
                  onEditingComplete: () {
                    context.read<ItemCubit>().setItemsData(item.copyWith(
                          name: name.text,
                          description: description.text,
                          amount: amount.text,
                        ));
                    context.read<ItemCubit>().readItemsByCharID(item.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  controller: amount,
                  hintText: '2',
                  subtitle: 'Amount',
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                ),
                BigTextBox(
                  onTapOutside: (clickOut) {
                    context.read<ItemCubit>().setItemsData(item.copyWith(
                          name: name.text,
                          description: description.text,
                          amount: amount.text,
                        ));
                    context.read<ItemCubit>().readItemsByCharID(item.charID);
                  },
                  onEditingComplete: () {
                    context.read<ItemCubit>().setItemsData(item.copyWith(
                          name: name.text,
                          description: description.text,
                          amount: amount.text,
                        ));
                    context.read<ItemCubit>().readItemsByCharID(item.charID);
                  },
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'Has a chance to burn target',
                  subtitle: 'Description (Optional)',
                  minLines: 5,
                ),
                TextButton(
                  onPressed: () {
                    context.read<ItemCubit>().readItemsByCharID(item.charID);
                    context.pop();
                  },
                  child: Text(
                    'Done Editing',
                    style: dndFont,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
