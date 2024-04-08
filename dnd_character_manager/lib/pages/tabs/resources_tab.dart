import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../client/spacing.dart';
import '../../constants/theme_data.dart';
import '../../cubits/resource_cubit/resource_cubit.dart';
import '../../models/resource.dart';
import '../add_resource_screen.dart';
import '../edit_resource_screen.dart';

class ResourcesTab extends StatelessWidget {
  final String charID;
  const ResourcesTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          _ResourcesList(charID: charID),
        ],
      ),
    );
  }
}

class _ResourcesList extends StatelessWidget {
  final String? charID;
  const _ResourcesList({required this.charID});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResourceCubit, ResourceState>(
      builder: (context, state) {
        context.read<ResourceCubit>().readResourcesByCharID(charID);

        print('Jackson List: ${state.resources}');
        List<Container> resources = state.resources!.map(
          (resource) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: themeColor, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onLongPress: () => _showPostEditPanel(context, resource),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(resource.name ?? ''),
                    Text(
                      resource.maxResourceValue ?? '0',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: themeColor),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            int? resourceValueAsInt = int.tryParse(resource.currentResourceValue ?? '0')! - 1;
                            context.read<ResourceCubit>().setResourcesData(resource.copyWith(
                                  currentResourceValue: resourceValueAsInt.toString(),
                                ));
                            context.read<ResourceCubit>().readResourcesByCharID(charID);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Flexible(
                            child: TextField(
                          enabled: false,
                          controller: TextEditingController(text: resource.currentResourceValue ?? '0'),
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                            hintStyle: TextStyle(fontSize: 16),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        )),
                        IconButton(
                          onPressed: () {
                            int? resourceValueAsInt = int.tryParse(resource.currentResourceValue ?? '0')! + 1;
                            context.read<ResourceCubit>().setResourcesData(resource.copyWith(currentResourceValue: resourceValueAsInt.toString()));
                            context.read<ResourceCubit>().readResourcesByCharID(charID);
                          },
                          icon: const Icon(
                            Icons.add,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ).toList();
        return GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            children: [
              const Center(
                child: SizedBox(),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      'Resources\n',
                      style: dndFont.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
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
                          color: themeColor,
                          icon: const Icon(Icons.add),
                          onPressed: () => _showEditPanel(context, charID!),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(),
              ...resources
            ]);
      },
    );
  }
}

// ignore: unused_element
class _AddResource extends StatelessWidget {
  final String charID;
  const _AddResource({required this.charID});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () => _showEditPanel(context, charID),
          icon: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
        seperation,
      ],
    );
  }
}

void _showEditPanel(BuildContext context, String charID) {
  const uuid = Uuid();
  Resource resource = Resource(charID: charID, resourceID: uuid.v4());
  context.read<ResourceCubit>().setResourcesData(resource);
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(child: SingleChildScrollView(child: AlertDialog(title: AddResourceScreen(resource: resource))));
      });
}

void _showPostEditPanel(BuildContext context, Resource resource) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: EditResourceScreen(resource: resource),
        ),
      ),
    ),
  );
}
