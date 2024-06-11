import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:screenshot/screenshot.dart';
import 'package:provider/provider.dart';
import '../Theam/theme.dart';
import '../provider/prescrioptionsheet.dart';
import 'd2_today_appointment.dart';

class PrescriptionSheet extends StatelessWidget {
  final String name;
  final String age;
  final String place;
  final String date;
  final String appointmentId;
  final String userId; // Add the userId parameter

  const PrescriptionSheet({
    super.key,
    required this.name,
    required this.age,
    required this.place,
    required this.date,
    required this.appointmentId,
    required this.userId, // Initialize the userId parameter
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrescriptionModel(),
      child: PrescriptionSheetContent(
        name: name,
        age: age,
        place: place,
        date: date,
        appointmentId: appointmentId,
        userId: userId,
      ),
    );
  }
}

class PrescriptionSheetContent extends StatefulWidget {
  final String name;
  final String age;
  final String place;
  final String date;
  final String appointmentId;
  final String userId; // Add the userId parameter

  const PrescriptionSheetContent({
    super.key,
    required this.name,
    required this.age,
    required this.place,
    required this.date,
    required this.appointmentId,
    required this.userId, // Initialize the userId parameter
  });

  @override
  State<PrescriptionSheetContent> createState() => _PrescriptionSheetContentState();
}

class _PrescriptionSheetContentState extends State<PrescriptionSheetContent> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController placeController;
  late TextEditingController dateController;

  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.name);
    ageController = TextEditingController(text: widget.age);
    placeController = TextEditingController(text: widget.place);
    dateController = TextEditingController(
        text: widget.date.split("T")[0]); // Display only date part
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    placeController.dispose();
    dateController.dispose();
    super.dispose();
  }

  Future<void> _captureAndUploadScreenshot(PrescriptionModel model) async {
    model.setUploading(true);

    try {
      // Capture the screenshot
      final image = await screenshotController.capture();

      if (image == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to capture screenshot')),
        );
        return;
      }

      // Upload the screenshot to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('screenshots/${widget.userId}/${widget.appointmentId}.png');
      final uploadTask = storageRef.putData(image);
      final snapshot = await uploadTask;

      // Get the download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // Store the download URL in Firestore under the user's appointment
      await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.userId)
          .collection('appointments')
          .doc(widget.appointmentId)
          .set({'prescription': downloadUrl}, SetOptions(merge: true));

      // Move the appointment data to success_appointments collection
      final appointmentData = await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.userId)
          .collection('appointments')
          .doc(widget.appointmentId)
          .get();

      await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.userId)
          .collection('success_appointments')
          .doc(widget.appointmentId)
          .set(appointmentData.data()!);

      // Delete the appointment from the appointments collection
      await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.userId)
          .collection('appointments')
          .doc(widget.appointmentId)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Screenshot stored successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to store screenshot: $e')),
      );
    } finally {
      model.setUploading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppThemeData.primaryColor,
            width: 5.0,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Screenshot(
              controller: screenshotController,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/Images/logo.jpg"),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Medi-Care Clinic",
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: AppThemeData.primaryColor),
                          ),
                          Row(
                            children: [
                              Text(
                                'Dr. Sarah Johnson ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    'M.B.B.S , M.D',
                                    style:
                                    TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Number 186/165,9th Main Road,14th Cross',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        'Ph: 9956982567 , 9946989015',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppThemeData.primaryColor,
                          width: 5.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text("Name:"),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    widget.name,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text("Age:"),
                                const SizedBox(width: 10),
                                Text(
                                  widget.age,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Text("Place:"),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    widget.place,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text("Date:"),
                                const SizedBox(width: 10),
                                Text(
                                  widget.date.split("T")[0],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                              height: 10,
                              color: AppThemeData.primaryColor,
                              thickness: 5,
                            ),
                            const SizedBox(height: 10),
                            const TextField(
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: 'Prescribe Medicine...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Consumer<PrescriptionModel>(
              builder: (context, model, child) {
                return model.isUploading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      await _captureAndUploadScreenshot(model);
                      await Future.delayed(
                          const Duration(seconds: 2)); // Delay for 2 seconds
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorAppointmentsPage(
                            context: context,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      backgroundColor: AppThemeData.primaryColor,
                    ),
                    child: const Text(
                      "Stop Consultation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
