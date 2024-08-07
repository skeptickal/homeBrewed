import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../constants/spacing.dart';
import '../../constants/theme_data.dart';
import '../../cubits/resource_cubit/resource_cubit.dart';
import '../../models/resource.dart';
import '../add_popups/add_resource_screen.dart';
import '../edit_popups/edit_resource_screen.dart';

class ResourcesTab extends StatelessWidget {
  final String charID;
  const ResourcesTab({super.key, required this.charID});

  @override
  Widget build(BuildContext context) {
    return _ResourcesList(charID: charID);
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
                    Text(
                      resource.name ?? '',
                      textAlign: TextAlign.center,
                    ),
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
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              resource.currentResourceValue ?? '0',
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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
        return Column(
          children: [
            seperation,
            Text(
              'Resources',
              style: dndFont.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            seperation,
            _AddResource(charID: charID!),
            seperation,
            seperation,
            Expanded(
              child: GridView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  children: [...resources]),
            ),
          ],
        );
      },
    );
  }
}

class _AddResource extends StatelessWidget {
  final String charID;
  const _AddResource({required this.charID});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: themeColor,
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
        color: white,
        icon: const Icon(Icons.add),
        onPressed: () => _showEditPanel(context, charID),
      ),
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
        return Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              backgroundColor: backgroundColor,
              surfaceTintColor: backgroundColor,
              title: AddResourceScreen(resource: resource),
            ),
          ),
        );
      });
}

void _showPostEditPanel(BuildContext context, Resource resource) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          backgroundColor: backgroundColor,
          surfaceTintColor: backgroundColor,
          title: EditResourceScreen(resource: resource),
        ),
      ),
    ),
  );
}
