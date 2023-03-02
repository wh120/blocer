
import 'package:flutter/material.dart';
import 'base_error_widget.dart';

class NoDataWidget extends StatelessWidget {
  final String? message;
  const NoDataWidget({Key? key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseErrorWidget(
      onTap: null,
      title: message ?? 'No Data',
      subtitle: '',
      icon: const Icon(Icons.find_replace_sharp),
    );
  }
}
