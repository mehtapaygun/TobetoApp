import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto_app/api/blocs/exam_bloc/exam_bloc.dart';
import 'package:tobeto_app/api/blocs/exam_bloc/exam_event.dart';
import 'package:tobeto_app/api/blocs/exam_bloc/exam_state.dart';
import 'package:tobeto_app/config/constant/core/widget/background_image.dart';
import 'package:tobeto_app/config/constant/core/widget/neu_box.dart';
import 'package:tobeto_app/config/constant/core/widget/top_bar_widget.dart';
import 'package:tobeto_app/config/constant/core/widget/top_bar_widget_interval.dart';
import 'package:tobeto_app/config/constant/theme/text.dart';
import 'package:tobeto_app/config/constant/theme/text_theme.dart';
import 'package:tobeto_app/models/exam_model.dart';

class ExamPage extends StatelessWidget {
  const ExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            TopBarWidgetInterval(
              titleText: "Sinavlar",
              leadingIcon: const Icon(Icons.quiz_outlined),
              iconButton: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            ),
            const SizedBox(height: 40),
            BlocBuilder<ExamBloc, ExamState>(
              builder: (context, state) {
                if (state is ExamInitial) {
                  // İlk durumda sınavları getirme işlemini başlat
                  context.read<ExamBloc>().add(GetExam());
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ExamLoading) {
                  // Yükleme durumunda ilerleme çubuğunu göster
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ExamLoaded) {
                  // Veri yüklendikten sonra UI'ı güncelle
                  final List<Exam> exams = state.exam;
                  return Column(
                    children: exams.map((exam) {
                      return GestureDetector(
                        onTap: () {
                          // Tıklandığında showDialog fonksiyonunu kullanarak bir dialog göster
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // AlertDialog oluşturun
                              return AlertDialog(
                                title: AppTextTheme.small(exam.name, context,
                                    textAlign: TextAlign.center),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: Text(exam.content),
                                    ),
                                    AppTextTheme.xSmall(
                                        "Sınav Süresi : ${exam.time}", context,
                                        fontWeight: FontWeight.normal),
                                    AppTextTheme.xSmall(
                                        "Soru sayısı : ${exam.questionNumber}",
                                        context,
                                        fontWeight: FontWeight.normal),
                                    AppTextTheme.xSmall(
                                        "Soru tipi : ${exam.examType}", context,
                                        fontWeight: FontWeight.normal),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text("Başla")),
                                  TextButton(
                                    onPressed: () {
                                      // Dialog kapatılacak
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Kapat"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: NeuBox(
                          width: 250,
                          height: 200,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                child: AppTextTheme.concertOne(
                                    exam.name, context,
                                    textAlign: TextAlign.center, fontSize: 20),
                              ),
                              const Icon(
                                Icons.keyboard_double_arrow_right_rounded,
                                size: 30,
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }
                if (state is ExamError) {
                  // Hata durumunda hata mesajını göster
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}