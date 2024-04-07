import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../cubits/cubit/resource_cubit.dart';

import '../models/resource.dart';

class AddResourceScreen extends StatelessWidget {
  final String charID;
  const AddResourceScreen({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController maxResourceValue = TextEditingController();
    TextEditingController description = TextEditingController();

    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                BigTextBox(
                  maxLength: 15,
                  maxLines: 1,
                  enabled: true,
                  onEditingComplete: () {},
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'e.g. Spell Splots',
                  subtitle: 'Resource name',
                ),
                BigTextBox(
                  enabled: true,
                  onEditingComplete: () {},
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  controller: maxResourceValue,
                  hintText: 'e.g. 5',
                  subtitle: 'Max Value',
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                ),
                BigTextBox(
                  minLines: 5,
                  onEditingComplete: () {},
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'E.g. expend to cast a leveled spell',
                  subtitle: 'Description (Optional)',
                ),
                TextButton(
                  onPressed: () => _addResource(
                    context: context,
                    name: name.text,
                    currentResourceValue: maxResourceValue.text,
                    maxResourceValue: maxResourceValue.text,
                    description: description.text,
                    charID: charID,
                  ),
                  child: Text(
                    'Add Resource',
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

  void _addResource(
      {required BuildContext context, String? name, String? currentResourceValue, String? maxResourceValue, String? charID, String? description}) {
    const uuid = Uuid();
    Resource newResource = Resource(
      resourceID: uuid.v4(),
      charID: charID,
      name: name,
      currentResourceValue: currentResourceValue,
      maxResourceValue: maxResourceValue,
      description: description,
    );
    context.read<ResourceCubit>().setResourcesData(newResource);
    context.read<ResourceCubit>().readResourcesByCharID(charID);
    context.pop();
  }
}
