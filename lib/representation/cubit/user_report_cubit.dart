import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/data/models/get_report_model.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/report_state.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/api/api_consumer.dart';
import '../../core/api/end_ponits.dart';
import '../../core/errors/exceptions.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit(this.api) : super(ReportInitial());
  final ApiConsumer api;

  GlobalKey<FormState> reportFormKey = GlobalKey();
  TextEditingController reportTitle = TextEditingController();
  TextEditingController reportDescription = TextEditingController();
  TextEditingController reportSeverity = TextEditingController();
  TextEditingController reportCategory = TextEditingController();
  TextEditingController longitude = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController reportPhone = TextEditingController();
  XFile? reportImage;
  XFile? reportVideo;

  Future<void> createReport() async {
    if (!reportFormKey.currentState!.validate()) {
      emit(ReportFailure(errMessage: 'Please fill all required fields'));
      return;
    }

    try {
      emit(ReportLoading());
      final response = await api.post(
        EndPoint.reports,
        isFromData: true,
        data: {
          ApiKey.title: reportTitle.text,
          ApiKey.description: reportDescription.text,
          ApiKey.severity: reportSeverity.text,
          ApiKey.category: reportCategory.text,
          ApiKey.latitude: latitude.text,  
          ApiKey.longitude: longitude.text,
          ApiKey.image: reportImage != null ? await reportImage!.readAsBytes() : null,
          ApiKey.video: reportVideo != null ? await reportVideo!.readAsBytes() : null,
          ApiKey.user: reportPhone.text,
        },
      );

      final reportModel = ReportModel.fromJson(response); 
      emit(ReportSuccess(message: reportModel.description));
    } on ServerException catch (e) {
      emit(ReportFailure(errMessage: e.errModel.errorMessage));
    } catch (e) {
      emit(ReportFailure(errMessage: 'An unexpected error occurred'));
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      reportImage = pickedFile;
      emit(ReportImagePicked());
    }
  }

  Future<void> pickVideo() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      reportVideo = pickedFile;
      emit(ReportVideoPicked());
    }
  }
}
