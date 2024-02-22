import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto_app/api/blocs/profile_bloc/profile_bloc.dart';
import 'package:tobeto_app/api/blocs/profile_bloc/profile_state.dart';
import 'package:tobeto_app/pages/profile/personal_widget.dart';

class Education extends StatelessWidget {
  const Education({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          final user = state.user;
          return ProfilWidget(
              text: "Eğitim",
              widget: user.educationHistory != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: user.educationHistory!.length,
                      itemBuilder: (context, index) {
                        final education = user.educationHistory![index];
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(education.schoolName!),
                                Text(education.department!),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(education.city!),
                                Text(education.educationStatus!),
                              ],
                            ),
                            Text(
                                "${education.startDate} - ${education.endDate}"),
                          ],
                        );
                      },
                    )
                  : const SizedBox());
        }
        return Container();
      },
    );
  }
}