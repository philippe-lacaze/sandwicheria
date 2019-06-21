import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:sandwicheria/core/viewmodels/commander_stepper_model.dart';
import 'package:sandwicheria/ui/widgets/my_form_builder_checkbox_list.dart';
import 'package:sandwicheria/ui/widgets/my_form_builder_radio.dart';

menuField(CommanderStepperModel model) => MyFormBuilderRadio(
      attribute: "menu",
      leadingInput: true,
      onChanged: (value) {
        model.choixMenu = value;
        model.setFormValue("menu", value);
        model.nextStepDelayed();
      },
      validators: [FormBuilderValidators.required()],
      initialValue: model.choixMenu,
      options: model.configService
          .getMenus()
          .map((val) => FormBuilderFieldOption(value: val))
          .toList(growable: false),
    );

platField(CommanderStepperModel model) => MyFormBuilderRadio(
      attribute: "plat",
      leadingInput: true,
      onChanged: (value) {
        model.choixPlat = value;
        model.setFormValue("plat", value);
        model.nextStepDelayed();
      },
      validators: [FormBuilderValidators.required()],
      initialValue: model.choixPlat,
      options: model.configService
          .getPlats(model.choixMenu)
          .map((val) => FormBuilderFieldOption(value: val))
          .toList(growable: false),
    );

genericRadioField(String name, CommanderStepperModel model) {
  return radioFields(
      model,
      name,
      model.configService
          .getOptionsPlat(model.choixMenu, model.choixPlat, name));
}

genericCheckboxesField(String name, CommanderStepperModel model) {
  return checkboxesFields(
      model,
      name,
      model.configService
          .getOptionsPlat(model.choixMenu, model.choixPlat, name));
}

radioFields(CommanderStepperModel model, String name, List<String> options) =>
    (options == null)
        ? Container()
        : MyFormBuilderRadio(
            attribute: "$name",
            leadingInput: true,
            onChanged: (value) {
              model.setFormValue(name, value);
              model.nextStepDelayed();
            },
            validators: [FormBuilderValidators.required()],
            initialValue: model.getFormValue(name),
            options: options
                .map((val) => FormBuilderFieldOption(value: val))
                .toList(growable: false));

checkboxesFields(
        CommanderStepperModel model, String name, List<String> options) =>
    (options == null)
        ? Container()
        : MyFormBuilderCheckboxList(
            attribute: "$name",
            initialValue: model.getFormValue(name),
            onChanged: (value) {
              model.setFormValue(name, value);
            },
            options: options
                .map((val) => FormBuilderFieldOption(value: val))
                .toList(growable: false),
          );
