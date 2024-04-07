import 'package:dnd_character_manager/constants/text_fields.dart';
import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:dnd_character_manager/models/resource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubits/resource_cubit/resource_cubit.dart';

class AddResourceScreen extends StatelessWidget {
  final Resource resource;
  const AddResourceScreen({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    name.text = resource.name ?? '';
    TextEditingController maxResourceValue = TextEditingController();
    maxResourceValue.text = resource.maxResourceValue ?? '0';
    TextEditingController description = TextEditingController();
    description.text = resource.description ?? '';
    context.read<ResourceCubit>().setResourcesData(
          resource.copyWith(
            name: name.text,
            currentResourceValue: '0',
            maxResourceValue: '0',
            description: description.text,
          ),
        );
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
                          currentResourceValue: maxResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  onEditingComplete: () => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: maxResourceValue.text,
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
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: StatTextBox(
                    onTapOutside: (clickOut) => context.read<ResourceCubit>().setResourcesData(
                          resource.copyWith(
                            name: name.text,
                            currentResourceValue: maxResourceValue.text,
                            maxResourceValue: maxResourceValue.text,
                            description: description.text,
                          ),
                        ),
                    onEditingComplete: () => context.read<ResourceCubit>().setResourcesData(
                          resource.copyWith(
                            name: name.text,
                            currentResourceValue: maxResourceValue.text,
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
                          currentResourceValue: maxResourceValue.text,
                          maxResourceValue: maxResourceValue.text,
                          description: description.text,
                        ),
                      ),
                  onEditingComplete: () => context.read<ResourceCubit>().setResourcesData(
                        resource.copyWith(
                          name: name.text,
                          currentResourceValue: maxResourceValue.text,
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
                    'Add Resource',
                    style: dndFont.copyWith(color: black),
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
