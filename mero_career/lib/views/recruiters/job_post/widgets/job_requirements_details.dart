import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class JobRequirementsDetails extends StatefulWidget {
  @override
  _JobRequirementsDetailsState createState() => _JobRequirementsDetailsState();
}

class _JobRequirementsDetailsState extends State<JobRequirementsDetails> {
  final QuillController _controller = QuillController.basic();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Page Title
        Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 18, top: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Add Job Requirements",
                style: TextStyle(fontSize: 20.5, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Text(
                "Please provide detailed job requirements to help candidates understand the role better.",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),

        SizedBox(height: 16),
        Divider(
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        // Toolbar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: QuillSimpleToolbar(
            controller: _controller,
            configurations: const QuillSimpleToolbarConfigurations(
                showBoldButton: true,
                showItalicButton: true,
                showUnderLineButton: true,
                showAlignmentButtons: true,
                showListBullets: true,
                showListNumbers: true,
                showQuote: false,
                showCodeBlock: false,
                showHeaderStyle: false,
                showUndo: false,
                showRedo: false,
                showClearFormat: false,
                showClipboardCopy: false,
                showClipboardCut: false,
                showClipboardPaste: false,
                showIndent: false,
                showStrikeThrough: false,
                showLink: false,
                showFontFamily: false,
                showFontSize: false,
                showSearchButton: false,
                showSubscript: false,
                showSuperscript: false),
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Divider(
          color: Theme.of(context).colorScheme.surfaceContainer,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Expanded(
            child: QuillEditor.basic(
              controller: _controller,
              configurations: const QuillEditorConfigurations(
                  placeholder: "Job requirements description.."),
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
