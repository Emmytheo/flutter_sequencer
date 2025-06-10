import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TempoSelector extends StatefulWidget {
  TempoSelector({super.key, required this.selectedTempo, required this.handleChange}) {
    // TODO: implement TempoSelector
    // throw UnimplementedError();
  }

  final double selectedTempo;
  final Function(double nextTempo) handleChange;

  @override
  State<StatefulWidget> createState() => _TempoSelectorState();
}

class _TempoSelectorState extends State<TempoSelector> {
  late TextEditingController controller;

  @override
  void didUpdateWidget(TempoSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedTempo != widget.selectedTempo) {
      controller.text = widget.selectedTempo.toInt().toString();
    }
  }

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.selectedTempo.toInt().toString());
  }

  void handleTextChange(String input) {
    final parsedValue = double.tryParse(input);

    if (parsedValue != null && parsedValue > 0) {
      widget.handleChange(parsedValue);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(margin: EdgeInsets.only(right: 16.0), child: Text('Tempo:')),
        SizedBox(
          width: 50,
          height: 50,
          child: TextField(
            controller: controller,
            maxLines: 1,
            keyboardType: TextInputType.number,
            onSubmitted: handleTextChange,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(hintText: "..."),
          ),
        ),
      ],
    );
  }
}
