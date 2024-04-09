import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/item_cubit/item_cubit.dart';
import '../../models/item.dart';

class AddItemScreen extends StatelessWidget {
  final Item item;

  const AddItemScreen({Key? key, required this.item}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(value: item.name),
        'amount': FormControl<String>(value: item.amount),
        'description': FormControl<String>(value: item.description),
      });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemCubit, ItemState>(
      builder: (context, state) {
        return ReactiveFormBuilder(
            form: buildForm,
            builder: (context, form, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'name',
                      decoration: textInputDecoration.copyWith(labelText: 'Item Name'),
                      //InputDecoration(labelText: 'Item Name', labelStyle: dndFont),
                    ),
                    ReactiveTextField<String>(
                      formControlName: 'amount',
                      decoration: InputDecoration(labelText: 'Amount', labelStyle: dndFont),
                    ),
                    ReactiveTextField<String>(
                      minLines: 1,
                      maxLines: 10,
                      formControlName: 'description',
                      decoration: InputDecoration(labelText: 'Description', labelStyle: dndFont),
                    ),
                    TextButton(
                      onPressed: () {
                        print('Jeff ${form.control('name').value}');
                        Item updatedItem = Item(
                          itemID: item.itemID,
                          charID: item.charID,
                          name: form.control('name').value,
                          amount: form.control('amount').value,
                          description: form.control('description').value,
                        );

                        context.read<ItemCubit>().setItemsData(updatedItem);
                        context.read<ItemCubit>().readItemsByCharID(item.charID);
                        context.pop();
                      },
                      child: Text(
                        'Save Item',
                        style: dndFont.copyWith(color: themeColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<ItemCubit>().deleteItemByItemID(item.itemID!);
                        context.read<ItemCubit>().readItemsByCharID(item.charID);
                        context.pop();
                      },
                      child: Text(
                        'Cancel',
                        style: dndFont.copyWith(color: themeColor),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }
}
