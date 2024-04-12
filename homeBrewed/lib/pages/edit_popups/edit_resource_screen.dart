import 'package:homeBrewed/client/spacing.dart';
import 'package:homeBrewed/constants/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../cubits/resource_cubit/resource_cubit.dart';
import '../../models/resource.dart';

class EditResourceScreen extends StatelessWidget {
  final Resource resource;

  const EditResourceScreen({Key? key, required this.resource}) : super(key: key);
  FormGroup buildForm() => fb.group(<String, Object>{
        'name': FormControl<String>(value: resource.name),
        'currentResourceValue': FormControl<String>(value: resource.currentResourceValue),
        'maxResourceValue': FormControl<String>(value: resource.maxResourceValue),
        'description': FormControl<String>(value: resource.description),
      });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        return ReactiveFormBuilder(
          form: buildForm,
          builder: (context, formGroup, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ReactiveTextField<String>(
                    formControlName: 'name',
                    decoration: InputDecoration(labelText: 'Resource Name', labelStyle: dndFont),
                  ),
                  ReactiveTextField<String>(
                    keyboardType: TextInputType.number,
                    formControlName: 'currentResourceValue',
                    decoration: InputDecoration(labelText: 'Current Value', labelStyle: dndFont),
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
                  seperation,
                  TextButton(
                    onPressed: () {
                      Resource updatedResource = Resource(
                        resourceID: resource.resourceID,
                        charID: resource.charID,
                        name: formGroup.control('name').value,
                        currentResourceValue: formGroup.control('currentResourceValue').value,
                        maxResourceValue: formGroup.control('maxResourceValue').value,
                        description: formGroup.control('description').value,
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
                  horizontalLine,
                  seperation,
                  seperation,
                  TextButton(
                    onPressed: () {
                      context.read<ResourceCubit>().deleteResourceByResourceID(resource.resourceID!);
                      context.read<ResourceCubit>().readResourcesByCharID(resource.charID);
                      context.pop();
                    },
                    child: Text(
                      'Delete Resource?',
                      style: dndFont.copyWith(color: Colors.red),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
