import 'package:flutter/material.dart';
import 'package:flutter_app/entities/Bird/model/Bird.cubit.dart';
import 'package:flutter_app/entities/Bird/model/Bird.model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'dart:io';

class AddBirdScreen extends StatefulWidget {
  final LatLng position;
  final File? image;

  const AddBirdScreen({super.key, required this.position, required this.image});

  @override
  State<AddBirdScreen> createState() => _AddBirdScreenState();
}

class _AddBirdScreenState extends State<AddBirdScreen> {
  final _formKey = GlobalKey<FormState>();
  late final FocusNode _descriptionFocusNode;

  String? name;
  String? description;

  void _submit({required BuildContext context}) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    final BirdModel birdModel = BirdModel(
      image: widget.image!,
      longitude: widget.position.longitude,
      latitude: widget.position.latitude,
      birdDescription: description,
      birdName: name,
    );

    context.read<BirdPostCubit>().addBirdPost(birdModel);

    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _descriptionFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bird'),
        // leading: ,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 1.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(widget.image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Enter a bird name"),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(
                        context,
                      ).requestFocus(_descriptionFocusNode);
                    },
                    onSaved: (value) {
                      name = value?.trim();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a name...";
                      }

                      if (value.length < 2) {
                        return "Please enter a longer name";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    focusNode: _descriptionFocusNode,
                    decoration: InputDecoration(
                      hintText: "Enter a bird description",
                    ),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) {
                      _submit(context: context);
                    },
                    onSaved: (value) {
                      description = value?.trim();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a description...";
                      }

                      if (value.length < 2) {
                        return "Please enter a longer description";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _submit(context: context);
        },
        child: Icon(Icons.check, size: 32),
      ),
    );
  }
}
