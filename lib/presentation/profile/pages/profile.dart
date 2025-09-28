// presentation/profile/pages/profile_page.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/common/widgets/appbar/app_bar.dart';
import 'package:musicapp/common/widgets/button/helpers/is_dark_mode.dart';
import 'package:musicapp/core/config/theme/app_colors.dart';
import 'package:musicapp/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:musicapp/presentation/profile/bloc/profile_info_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: const Text('Profile'),
        backgroundColor: AppColors.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context),
          const SizedBox(height: 30),
          // Add more profile options here if needed
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    final isDark = context.isDarkMode;

    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileInfoLoaded) {
              final user = state.userEntity;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Picture
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(user.imageURL ?? ''),
                    backgroundColor: AppColors.grey.withOpacity(0.2),
                  ),
                  const SizedBox(height: 12),

                  // Email
                  Text(
                    user.email ?? 'No email',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Full Name
                  Text(
                    user.fullName ?? 'Unknown User',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryLight,
                    ),
                  ),
                ],
              );
            }

            if (state is ProfileInfoFailure) {
              return Center(
                child: Text(
                  'Failed to load user info',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.red),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
