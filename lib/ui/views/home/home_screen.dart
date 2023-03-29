import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ropstam_poc/constants/strings.dart';
import 'package:ropstam_poc/ui/shared/ui_helpers.dart';
import 'package:ropstam_poc/ui/views/base_widget.dart';
import 'package:ropstam_poc/ui/views/home/add_edit_car.dart';
import 'package:ropstam_poc/viewmodels/views/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
        model: HomeViewModel(Provider.of(context)),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Dashboard"),
            ),
            body: ListView.builder(
              itemCount: model.cars.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Text(model.cars[index].name ?? ""),
                  subtitle: Text(model.cars[index].category ?? ""),
                  trailing: Wrap(
                    children: [
                      IconButton(
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEditCar(
                                    homeViewModelmodel: model,
                                    selectedIndex: index),
                              ));
                          model.setBusy(false);
                        },
                        icon: const Icon(Icons.edit_note),
                        color: Colors.blue,
                      ),
                      IconButton(
                        onPressed: () {
                          model.deleteCar(model.cars[index].registrationNo!);
                        },
                        icon: const Icon(Icons.delete),
                        color: Colors.blue,
                      ),
                      const IconButton(
                          onPressed: null, icon: Icon(Icons.arrow_drop_down))
                    ],
                  ),
                  childrenPadding: UIHelper.pagePaddingSmall,
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  expandedAlignment: Alignment.topLeft,
                  children: [
                    Text("$labelColor : ${model.cars[index].color}"),
                    const Divider(),
                    Text("$labelModel : ${model.cars[index].model}"),
                    const Divider(),
                    Text("$labelRegNo : ${model.cars[index].registrationNo}"),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                model.clearController();
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddEditCar(homeViewModelmodel: model),
                    ));
                model.setBusy(false);
              },
              child: Icon(Icons.add),
            ),
          );
        });
  }
}
