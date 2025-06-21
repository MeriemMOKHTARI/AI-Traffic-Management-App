import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/report_state.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/user_report_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/core/static/colors.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<ReportCubit, ReportState>(
        listener: (context, state) {
          if (state is ReportSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ));
          } else if (state is ReportFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.errMessage),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: context.read<ReportCubit>().reportFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeader(),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.primary,
                          ),
                          child: Row(
                            children: [
                              Text("Historique", style: TextStyle(color: Colors.white,fontSize: 12),),
                              IconButton(
                                icon: const Icon(Icons.history, color: Colors.white,),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                                      ),
                            ],
                          ))
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildDropdown(
                      context,
                      label: 'Choisissez la catégorie...',
                      controller: context.read<ReportCubit>().reportCategory,
                      items: ['Accident de la route', 'Travaux en cours', 'Violation de feu rouge'],
                    ),
                    const SizedBox(height: 12),
                    _buildDropdown(
                      context,
                      label: 'Choisissez la gravité...',
                      controller: context.read<ReportCubit>().reportSeverity,
                      items: ['Faible', 'Moyenne', 'Élevée'],
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      context,
                      hintText: 'Saisissez le titre...',
                      maxLines: 1,
                      controller: context.read<ReportCubit>().reportTitle,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      context,
                      hintText: 'Saisissez la description...',
                      maxLines: 5,
                      controller: context.read<ReportCubit>().reportDescription,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      context,
                      hintText: 'Latitude',
                      maxLines: 1,
                      controller: context.read<ReportCubit>().latitude,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      context,
                      hintText: 'Longitude',
                      maxLines: 1,
                      controller: context.read<ReportCubit>().longitude,
                    ),
                    const SizedBox(height: 12),
                    _buildTextField(
                      context,
                      hintText: 'Numéro de téléphone',
                      maxLines: 1,
                      controller: context.read<ReportCubit>().reportPhone,
                    ),
                    const SizedBox(height: 12),
                    _buildUploadSection(
                      context,
                      title: 'Déposez une image',
                      onTap: () => context.read<ReportCubit>().pickImage(),
                      icon: Icons.photo_camera,
                      fileName: context.read<ReportCubit>().reportImage?.path,
                    ),
                    const SizedBox(height: 12),
                    _buildUploadSection(
                      context,
                      title: 'Déposez une vidéo',
                      onTap: () => context.read<ReportCubit>().pickVideo(),
                      icon: Icons.video_camera_back,
                      fileName: context.read<ReportCubit>().reportVideo?.path,
                    ),
                    const SizedBox(height: 20),
                    _buildSubmitButton(context, state),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return const Text(
      'Remplissez les informations\n ci-dessous !',
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String label,
    required TextEditingController controller,
    required List<String> items,
  }) {
    return DropdownButtonFormField<String>(
      value: controller.text.isNotEmpty ? controller.text : null,
      hint: Text(label, style: const TextStyle(color: Colors.grey)),
      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
      isExpanded: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.primary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      dropdownColor: AppColors.primary,
      style: const TextStyle(color: Colors.white),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.text = value;
        }
      },
      validator: (value) => controller.text.isEmpty ? 'Veuillez choisir une option' : null,
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String hintText,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: AppColors.primary.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
      validator: (value) => value!.isEmpty ? 'Ce champ est obligatoire' : null,
    );
  }

  Widget _buildUploadSection(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
    required IconData icon,
    String? fileName,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Icon(
              fileName != null ? Icons.check_circle : icon,
              color: AppColors.primary.withOpacity(0.5),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                fileName != null
                    ? 'Fichier sélectionné: ${fileName.split('/').last}'
                    : title,
                style: TextStyle(color: AppColors.primary, fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSubmitButton(BuildContext context, ReportState state) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: state is! ReportLoading 
          ? () => context.read<ReportCubit>().createReport() 
          : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: state is ReportLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : const Text(
              'Envoyer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
      ),
    );
  }
}

