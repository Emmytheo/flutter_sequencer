import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_sequencer/track.dart';
import 'package:flutter_sequencer_example/models/step_sequencer_state.dart';

import 'grid/grid.dart';
import 'volume_slider.dart';

class DrumMachineWidget extends StatefulWidget {
  const DrumMachineWidget({
    super.key,
    required this.track,
    required this.stepCount,
    required this.currentStep,
    required this.rowLabels,
    required this.columnPitches,
    required this.volume,
    required this.stepSequencerState,
    required this.handleVolumeChange,
    required this.handleVelocitiesChange,
  });

  final Track track;
  final int stepCount;
  final int currentStep;
  final List<String> rowLabels;
  final List<int> columnPitches;
  final double volume;
  final StepSequencerState? stepSequencerState;
  final Function(double) handleVolumeChange;
  final Function(int, int, int, double) handleVelocitiesChange;

  @override
  State<StatefulWidget> createState() => _DrumMachineWidgetState();
}

class _DrumMachineWidgetState extends State<DrumMachineWidget> with SingleTickerProviderStateMixin {
  Ticker? ticker;

  double? getVelocity(int step, int col) {
    return widget.stepSequencerState!.getVelocity(step, widget.columnPitches[col]);
  }

  void handleVelocityChange(int col, int step, double velocity) {
    widget.handleVelocitiesChange(widget.track.id, step, widget.columnPitches[col], velocity);
  }

  void handleVolumeChange(double nextVolume) {
    widget.handleVolumeChange(nextVolume);
  }

  void handleNoteOn(int col) {
    widget.track.startNoteNow(noteNumber: widget.columnPitches[col], velocity: .75);
  }

  void handleNoteOff(int col) {
    widget.track.stopNoteNow(noteNumber: widget.columnPitches[col]);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.fromLTRB(32, 16, 32, 0),
        decoration: BoxDecoration(color: Colors.black54),
        child: Column(
          children: [
            VolumeSlider(value: widget.volume, onChange: handleVolumeChange),
            Expanded(
              child: Grid(
                columnLabels: widget.rowLabels,
                getVelocity: getVelocity,
                stepCount: widget.stepCount,
                currentStep: widget.currentStep,
                onChange: handleVelocityChange,
                onNoteOn: handleNoteOn,
                onNoteOff: handleNoteOff,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
