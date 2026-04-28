import 'package:expense_tracker_app/bar_graph/individual_bar.dart';
import 'package:expense_tracker_app/database/expenses_db.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBarGraph extends StatefulWidget {
  final Map<String, double> monthlySymmary;

  const MyBarGraph({Key? key, required this.monthlySymmary}) : super(key: key);

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  List<IndividualBar> barData = [];

  void initializeData() {
    barData = List.generate(
        widget.monthlySymmary.length,
        (index) => IndividualBar(
            x: int.parse(widget.monthlySymmary.keys.toList()[index][0]),
            y: widget.monthlySymmary.values.toList()[index].roundToDouble()));
  }

  double getMax() {
    double max = 500;

    final maxExpense = widget.monthlySymmary.values.toList();
    maxExpense.sort();
    max = maxExpense.isNotEmpty ? maxExpense.last * 1.05 : max;
    if (max < 500) {
      return 500;
    } else {
      return max;
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeData();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: widget.monthlySymmary.length * 50,
        child: BarChart(
          BarChartData(
            barTouchData: BarTouchData(
              handleBuiltInTouches: true,
              touchCallback: (p0, p1) {
                if (p0 is FlTapUpEvent && p1?.spot != null) {
                  final touchedSpot = p1!.spot!;

                  context
                      .read<ExpensesDb>()
                      .selectMonth(touchedSpot.touchedBarGroup.x);
                }
              },
            ),
            alignment: BarChartAlignment.center,
            groupsSpace: 15,
            minY: 0,
            maxY: getMax(),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: getTitlesWidget,
                  reservedSize: 35,
                ))),
            barGroups: barData
                .map(
                  (data) => BarChartGroupData(
                    x: data.x,
                    barRods: [
                      BarChartRodData(
                        toY: data.y,
                        width: 20,
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(4),
                        backDrawRodData: BackgroundBarChartRodData(
                            color: Colors.white, show: true, toY: getMax()),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget getTitlesWidget(double value, TitleMeta meta) {
    String text = '';

    switch ((value.toInt() % 12)) {
      case 1:
        text = 'Jan';
        break;
      case 2:
        text = 'Feb';
        break;
      case 3:
        text = 'Mar';
        break;
      case 4:
        text = 'Apr';
        break;
      case 5:
        text = 'May';
        break;
      case 6:
        text = 'Jun';
        break;
      case 7:
        text = 'Jul';
        break;
      case 8:
        text = 'Aug';
        break;
      case 9:
        text = 'Sep';
        break;
      case 10:
        text = 'Oct';
        break;
      case 11:
        text = 'Nov';
        break;
      case 0:
        text = 'Dec';
        break;
      default:
        text = '';
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(
        text,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}
