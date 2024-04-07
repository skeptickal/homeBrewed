import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../client/spacing.dart';
import '../../constants/theme_data.dart';
import '../../cubits/cubit/resource_cubit.dart';
import '../../models/resource.dart';
import '../add_resource_screen.dart';
import '../edit_resource_screen.dart';

class ResourcesTab extends StatelessWidget {
  final String charID;
  const ResourcesTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                onLongPress: () => showDialog(
                  context: context,
                  builder: (context) => Center(
                    child: Text(
                      'hello',
                      style: dndFont.copyWith(color: white),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(resource.name ?? ''),
                    Text('MAX : ${resource.maxResourceValue ?? '0'}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            int? resourceValueAsInt = int.tryParse(resource.currentResourceValue ?? '0')! - 1;
                            context.read<ResourceCubit>().setResourcesData(
                                  state.resource!.copyWith(
                                    currentResourceValue: resourceValueAsInt.toString(),
                                  ),
                                );
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Flexible(
                            child: TextField(
                          enabled: false,
                          controller: TextEditingController(text: resource.currentResourceValue ?? '0'),
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                            hintStyle: TextStyle(fontSize: 18),
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        )),
                        IconButton(
                          onPressed: () {
                            int? resourceValueAsInt = int.tryParse(resource.currentResourceValue ?? '0')! + 1;
                            context.read<ResourceCubit>().setResourcesData(
                                  state.resource!.copyWith(
                                    currentResourceValue: resourceValueAsInt.toString(),
                                  ),
                                );
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
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
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
              ]),
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
            context.read<ResourceCubit>().deleteResourceByResourceID(resourceID).then((result) {
              context.read<ResourceCubit>().readResourcesByCharID(charID);
              context.pop();
            });
          },
        ),
      ],
    ),
  );
}

void _onPressedTile({required BuildContext context, required String name, required String description}) {
  showDialog(
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          title: Text(
            '$name\n\n$description',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: white),
          ),
          backgroundColor: themeColor,
          surfaceTintColor: themeColor,
          actions: [
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(color: white),
              ),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    ),
  );
}

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
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: AddResourceScreen(charID: charID),
        );
      });
}

void _showPostEditPanel(BuildContext context, Resource resource) {
  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: EditResourceScreen(resource: resource),
        );
      });
}
