import 'package:dnd_character_manager/client/spacing.dart';
import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/resource_cubit/resource_cubit.dart';

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
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                  maxLength: 15,
                  enabled: true,
                  padding: const EdgeInsets.all(6),
                  controller: name,
                  hintText: 'Resource name',
                  subtitle: 'Resource name',
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: StatTextBox(
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
                    maxLength: 3,
                    enabled: true,
                    padding: const EdgeInsets.all(6),
                    controller: currentResourceValue,
                    hintText: '5',
                    subtitle: 'Current Value',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: StatTextBox(
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
                    maxLength: 3,
                    enabled: true,
                    padding: const EdgeInsets.all(6),
                    controller: maxResourceValue,
                    hintText: '5',
                    subtitle: 'Max Value',
                  ),
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
                    context.read<ResourceCubit>().readResourcesByCharID(resource.charID);
                    context.pop();
                  },
                  child: Text(
                    'Done Editing',
                    style: dndFont.copyWith(color: black),
                  ),
                ),
                horizontalLine,
                seperation,
                TextButton(
                  onPressed: () {
                    _onPressedDeleteIcon(
                      context: context,
                      charID: resource.charID!,
                      name: resource.name ?? '',
                      resourceID: resource.resourceID!,
                    );
                  },
                  child: Text(
                    'Delete ${resource.name}?',
                    style: dndFont.copyWith(color: themeColor),
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

void _onPressedDeleteIcon({required BuildContext context, required String resourceID, required String name, required String charID}) {
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
            context.read<ResourceCubit>().deleteResourceByResourceID(resourceID);
            context.read<ResourceCubit>().readResourcesByCharID(charID);
            context.pop();
            context.pop();
          },
        ),
      ],
    ),
  );
}
