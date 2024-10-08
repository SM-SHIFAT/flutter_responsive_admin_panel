import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/constrains.dart';
import '../../dashboard/views/components/header.dart';
import '../controllers/transaction_controller.dart';
import 'components/datatable.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Header(),
          SizedBox(height: defaultPadding),
          Expanded(child: TransactionDataTable()),
          SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
