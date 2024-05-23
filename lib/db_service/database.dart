import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  Future addYearlyTask(Map<String, dynamic> userYearlyMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Yearly")
        .doc(id)
        .set(userYearlyMap);
  }

  Future addMonthlyTask(Map<String, dynamic> userMonthlyMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Monthly")
        .doc(id)
        .set(userMonthlyMap);
  }

  Future addWeeklyTask(Map<String, dynamic> userWeeklyMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Weekly")
        .doc(id)
        .set(userWeeklyMap);
  }

  Future addDailyTask(Map<String, dynamic> userDailyMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Daily")
        .doc(id)
        .set(userDailyMap);
  }

  Future<Stream<QuerySnapshot>> getTask(String task) async {
    return await FirebaseFirestore.instance.collection(task).snapshots();
  }

  tickMethod(String id, String task) async {
    return await FirebaseFirestore.instance
        .collection(task)
        .doc(id)
        .update({"Yes": true});
  }

  removeMethod(String id, String task) async {
    await FirebaseFirestore.instance.collection(task).doc(id).delete();

    // Remove the task from higher frequencies
    switch (task) {
      case 'Daily':
        await FirebaseFirestore.instance.collection('Weekly').doc(id).delete();
        await FirebaseFirestore.instance.collection('Monthly').doc(id).delete();
        await FirebaseFirestore.instance.collection('Yearly').doc(id).delete();
        break;
      case 'Weekly':
        await FirebaseFirestore.instance.collection('Monthly').doc(id).delete();
        await FirebaseFirestore.instance.collection('Yearly').doc(id).delete();
        break;
      case 'Monthly':
        await FirebaseFirestore.instance.collection('Yearly').doc(id).delete();
        break;
      default:
        break;
    }
  }
}
