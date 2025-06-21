import 'package:equatable/equatable.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportSuccess extends ReportState {
  final String message;
  const ReportSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class ReportFailure extends ReportState {
  final String errMessage;
  const ReportFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}

class ReportImagePicked extends ReportState {}

class ReportVideoPicked extends ReportState {}
