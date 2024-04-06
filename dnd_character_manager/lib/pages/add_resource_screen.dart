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
    TextEditingController currentResourceValue = TextEditingController();
    TextEditingController maxResourceValue = TextEditingController();
    TextEditingController description = TextEditingController();

    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                CustomTextBox(
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'Resource name',
                  subtitle: 'Resource name',
                  obscureText: false,
                ),
                CustomTextBox(
                  padding: const EdgeInsets.all(6),
                  controller: currentResourceValue,
                  hintText: '1d20 + 5 (STR)',
                  subtitle: 'Attack Roll',
                  obscureText: false,
                ),
                CustomTextBox(
                  padding: const EdgeInsets.all(6),
                  controller: maxResourceValue,
                  hintText: '1d10 + 2 Bludgeoning',
                  subtitle: 'Damage Roll + Type',
                  obscureText: false,
                ),
                CustomTextBox(
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'Has a chance to burn target',
                  subtitle: 'Description (Optional)',
                  obscureText: false,
                ),
                TextButton(
                  onPressed: () => _addResource(
                    context: context,
                    name: name.text,
                    currentResourceValue: currentResourceValue.text,
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
    context.pop();
  }
}
