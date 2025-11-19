import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/res/resource.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const WassetAppBar(
        title: 'عن وسيط',
      ),
      body: FutureBuilder(
        future: context.read<HomeRepository>().getAboutUs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.data is ResourceSuccess) {
              final aboutUs = snapshot.data!.data;
              return Scaffold(
                body: Column(
                  children: [
                    Image.network(
                      'https://huest.nyc3.digitaloceanspaces.com/${aboutUs!.logo}',
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      aboutUs.description,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              );
            }
            return const Scaffold(
              body: Center(
                child: Text('خطأ'),
              ),
            );
          }
        },
      ),
    );
  }
}
