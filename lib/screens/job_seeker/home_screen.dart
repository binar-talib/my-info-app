import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_vacancy/custom_widgets/auth_bottom_sheet.dart';
import 'package:job_vacancy/custom_widgets/custom_app_bar.dart';
import 'package:job_vacancy/custom_widgets/custom_icon_button.dart';
import 'package:job_vacancy/custom_widgets/custom_texts.dart';
import 'package:job_vacancy/custom_widgets/filter_sheet.dart';
import 'package:job_vacancy/custom_widgets/job_cards.dart';
import 'package:job_vacancy/custom_widgets/profile_button.dart';
import 'package:job_vacancy/custom_widgets/search_field.dart';
import 'package:job_vacancy/modules/necessary_methods.dart';
import 'package:job_vacancy/networking/jobs.dart';
import 'package:job_vacancy/networking/models/job.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:job_vacancy/screens/job_seeker/job_details_screen.dart';
import 'package:job_vacancy/screens/job_seeker/user_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Job> allJobs;
  late List<Job> searchedJobs = [];
  @override
  void initState() {
    super.initState();
    getAllJobs();
  }

  void getAllJobs() {
    setState(() async {
      allJobs = await Jobs().getAllJobs();
      searchedJobs = allJobs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: CustomIconButton(
          icon: Icons.menu,
          onPressed: () {},
        ),
        title: 'tory_kar'.tr(),
        trailing: ProfileButton(
          onPressed: () async {
            final prefs = await SharedPreferences.getInstance();
            if (prefs.getString('role') == 'jobSeeker') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfileScreen(
                    token: prefs.getString('token'),
                  ),
                ),
              );
            } else {
              showModalBottomSheet(
                context: context,
                builder: (context) => const AuthBottomSheet(
                  title: ' You need to sign up or\nlogin to see your profile',
                ),
              );
            }
          },
          image: 'assets/images/binar.jpg',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => getAllJobs(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SearchField(
                      hintText: 'Search Job..',
                      icon: Icons.search,
                      leftMargin: 0.0,
                      rightMargin: 0.0,
                      onChanged: (String query) {
                        final searchedJobs = search(
                          query: query,
                          list: allJobs,
                        );
                        setState(() {
                          this.searchedJobs = searchedJobs;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20.0),
                  CustomIconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return const FilterSheet();
                        },
                      );
                    },
                    icon: Icons.filter_list,
                    bgColor: const Color(0xFF2D7171),
                    iconColor: Colors.white,
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
              child: AutoSizeText15(
                text: 'Available Jobs',
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 60.0,
                ),
                itemCount: searchedJobs.length,
                itemBuilder: (context, index) {
                  if (searchedJobs.isNotEmpty) {
                    return JobCards(
                        title: searchedJobs[index].name,
                        company: searchedJobs[index].jobProviderName,
                        salary: searchedJobs[index].salary,
                        type: searchedJobs[index].jobType,
                        location: searchedJobs[index].formattedAddress,
                        deadline: searchedJobs[index].deadline,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetailsScreen(
                                title: searchedJobs[index].name,
                                salary: searchedJobs[index].salary,
                                jobType: searchedJobs[index].jobType,
                                location: searchedJobs[index].formattedAddress,
                                deadline: searchedJobs[index].deadline,
                                qualification:
                                    searchedJobs[index].jobQualifications,
                                description: searchedJobs[index].jobDescription,
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//child: FutureBuilder<List<Job>>(
//   future: searchedJobs,
//   builder: (context, snapshot) {
//     if (snapshot.hasData) {
//       return ListView.builder(
//         padding: const EdgeInsets.only(
//           top: 10.0,
//           left: 20.0,
//           right: 20.0,
//           bottom: 60.0,
//         ),
//         itemCount: snapshot.data!.length,
//         itemBuilder: (context, index) {
//           return JobCards(
//             title: snapshot.data![index].name,
//             company: snapshot.data![index].jobProviderName,
//             salary: snapshot.data![index].salary,
//             type: snapshot.data![index].jobType,
//             location: snapshot.data![index].formattedAddress,
//             deadline: snapshot.data![index].deadline,
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => JobDetailsScreen(
//                     title: snapshot.data![index].name,
//                     salary: snapshot.data![index].salary,
//                     jobType: snapshot.data![index].jobType,
//                     location:
//                         snapshot.data![index].formattedAddress,
//                     deadline: snapshot.data![index].deadline,
//                     qualification:
//                         snapshot.data![index].jobQualifications,
//                     description:
//                         snapshot.data![index].jobDescription,
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       );
//     } else {
//       Center(
//         child: Text('${snapshot.error}'),
//       );
//     }
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   },
// ),
//),
