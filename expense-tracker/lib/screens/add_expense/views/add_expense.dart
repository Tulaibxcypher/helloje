import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  List<String> myCategoryIcons = [
    'beauty',
    'electricity',
    'fuel',
    'investment',
    'medicine',
    'school',
    'travel'
  ];
  String iconsSelected = '';
  late Color categoryColor;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "AddExpenses",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 13),
              TextFormField(
                controller: expenseController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.dollarSign,
                    color: Colors.red,
                    size: 15,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 13),

              //for Category   2 rev

              TextFormField(
                controller: categoryController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.list,
                    color: Colors.red,
                    size: 15,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Enter the item'),
                                const SizedBox(height: 10),
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),

                                //category selection
                                TextFormField(
                                  textAlignVertical: TextAlignVertical.center,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(CupertinoIcons.chevron_down),
                                    hintText: 'Icons',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text('Enter the item'),
                                              const SizedBox(height: 10),
                                              TextFormField(
                                                textAlignVertical: TextAlignVertical.center,
                                                readOnly: true,
                                                decoration: InputDecoration(
                                                  hintText: 'Name',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Container(
                                                color: Colors.grey, // Temporary color for debugging
                                                child: GridView.builder(
                                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    mainAxisSpacing: 5,
                                                    crossAxisSpacing: 5,
                                                  ),
                                                  itemCount: myCategoryIcons.length,
                                                  itemBuilder: (context, int i) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          iconsSelected = myCategoryIcons[i];
                                                        });
                                                        Navigator.pop(context); // Close dialog after selection
                                                      },
                                                      child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(12),
                                                          border: Border.all(
                                                            width: 3,
                                                            color: iconsSelected == myCategoryIcons[i] ? Colors.green : Colors.grey,
                                                          ),
                                                          image: DecorationImage(
                                                            image: AssetImage('asset_icon/${myCategoryIcons[i]}.png'),
                                                            onError: (exception, stackTrace) {
                                                              print('Error loading image: asset_icon/${myCategoryIcons[i]}.png');
                                                            },
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),



                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),

                                //color
                                const SizedBox(height: 10),
                                TextFormField(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (ctx2) {
                                        return AlertDialog(
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Text("Pick a color"),
                                              const SizedBox(height: 10),
                                              ColorPicker(
                                                pickerColor: Colors.blue,
                                                onColorChanged: (value) {
                                                  setState((){
                                                    categoryColor=value;
                                                  });
                                                },
                                              ),
                                              SizedBox(
                                                width: double.infinity,
                                                height:50,
                                                child: TextButton(
                                                  onPressed: () {
                                                    print(categoryColor);
                                                    Navigator.pop(ctx2);
                                                  },
                                                  child: const Text('Save'),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  textAlignVertical: TextAlignVertical.center,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    hintText: 'Color',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );



                      ///This is category
                      const SizedBox(height:10);
                      SizedBox(
                        width: double.infinity,
                        height:50,
                        child: TextButton(
                          onPressed: () {
                          },
                          child: const Text('Save'),
                        ),
                      );
                    },
                    icon: const Icon(
                      FontAwesomeIcons.plus,
                      color: Colors.white38,
                      size: 15,
                    ),
                  ),
                  hintText: 'Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 13),

              ///date time

              TextFormField(
                controller: dateController,
                textAlignVertical: TextAlignVertical.center,
                readOnly: true,
                onTap: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    FontAwesomeIcons.clock,
                    color: Colors.red,
                    size: 15,
                  ),
                  hintText: 'Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              ///Text button
              const SizedBox(height: 13),
              TextButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
