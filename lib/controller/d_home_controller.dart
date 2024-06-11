

import '../Model/d_home_model.dart';

class AppointmentController {
  final AppointmentModel appointmentModel;

  AppointmentController(this.appointmentModel);

  void loadAppointments() {
    appointmentModel.fetchAppointments();
  }
}
