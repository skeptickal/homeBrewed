import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/cubit/resource_cubit.dart';

class EditResourceScreen extends StatelessWidget {
  final Resource resource;
  const EditResourceScreen({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    name.text = resource.name ?? '';
    TextEditingController currentResourceValue = TextEditingController();
    currentResourceValue.text = resource.currentResourceValue ?? '';
    TextEditingController maxResourceValue = TextEditingController();
    maxResourceValue.text = resource.maxResourceValue ?? '';
    TextEditingController description = TextEditingController();
    description.text = resource.description ?? '';
    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        return Form(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                BigTextBox(
                  onTapOutside: (clickOut) => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: currentResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  onEditingComplete: () => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: currentResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'Resource name',
                  subtitle: 'Resource name',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: currentResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  onEditingComplete: () => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: currentResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: currentResourceValue,
                  hintText: '1d20 + 5 (STR)',
                  subtitle: 'Attack Roll',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: currentResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  onEditingComplete: () => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: currentResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: maxResourceValue,
                  hintText: '1d10 + 2 Bludgeoning',
                  subtitle: 'Damage Roll + Type',
                ),
                BigTextBox(
                  onTapOutside: (clickOut) => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: currentResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  onEditingComplete: () => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: currentResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: description,
                  hintText: 'Has a chance to burn target',
                  subtitle: 'Description (Optional)',
                  minLines: 5,
                ),
                TextButton(
                  onPressed: () {
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
