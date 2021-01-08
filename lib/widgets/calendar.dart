import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatelessWidget {
  Calendar({
    this.initialDate,
    this.onDateSelected,
  });

  final String initialDate;
  final Function(DateTime) onDateSelected;

  String getFormattedDate(String stringDate) {
    return DateFormat('dd/MM/y').format(DateTime.parse(stringDate));
  }

  Future<DateTime> openCalendar(BuildContext context, DateTime initialDate) async {
    return await showDatePicker(
      locale: Locale('pt', 'BR'),
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text('Data de início: '),
                  Text(
                    '${getFormattedDate(initialDate)}',
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: () {
                openCalendar(context, DateTime.parse(initialDate)).then((value) {
                  onDateSelected(value);
                });
              },
              child: Text('Alterar data inicial'),
            )
          ],
        ),
      ),
    );
  }
}
