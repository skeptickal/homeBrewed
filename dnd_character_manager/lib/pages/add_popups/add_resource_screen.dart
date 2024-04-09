import 'package:dnd_character_manager/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/resource_cubit/resource_cubit.dart';
import '../../models/resource.dart';

class AddResourceScreen extends StatelessWidget {
  final Resource resource;

  const AddResourceScreen({Key? key, required this.resource}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(value: resource.name),
        'maxResourceValue': FormControl<String>(value: resource.maxResourceValue),
        'description': FormControl<String>(value: resource.description),
      });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        return ReactiveFormBuilder(
            form: buildForm,
            builder: (context, form, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ReactiveTextField<String>(
                      formControlName: 'name',
                      decoration: InputDecoration(labelText: 'Resource Name', labelStyle: dndFont),
                    ),
                    ReactiveTextField<String>(
                      keyboardType: TextInputType.number,
                      formControlName: 'maxResourceValue',
                      decoration: InputDecoration(labelText: 'Max Value', labelStyle: dndFont),
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
                        Resource updatedResource = Resource(
                          resourceID: resource.resourceID,
                          charID: resource.charID,
                          name: form.control('name').value,
                          maxResourceValue: form.control('maxResourceValue').value,
                          currentResourceValue: form.control('maxResourceValue').value ?? '0',
                          description: form.control('description').value,
                        );

                        context.read<ResourceCubit>().setResourcesData(updatedResource);
                        context.read<ResourceCubit>().readResourcesByCharID(resource.charID);
                        context.pop();
                      },
                      child: Text(
                        'Save Resource',
                        style: dndFont.copyWith(color: themeColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<ResourceCubit>().deleteResourceByResourceID(resource.resourceID!);
                        context.read<ResourceCubit>().readResourcesByCharID(resource.charID);
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
