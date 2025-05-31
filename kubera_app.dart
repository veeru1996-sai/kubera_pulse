import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'router/routeprovider.dart';
import 'themes/app_theme.dart';
import 'providers/user_provider.dart';
import 'providers/onboarding_provider.dart';

class KuberaApp extends ConsumerStatefulWidget {
  const KuberaApp({super.key});

  @override
  ConsumerState<KuberaApp> createState() => _KuberaAppState();
}

class _KuberaAppState extends ConsumerState<KuberaApp> {
  @override
  void initState() {
    super.initState();
    // Initialize Google Mobile Ads SDK
    MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingAsync = ref.watch(onboardingProvider);
    final userAsync = ref.watch(userServiceProvider);

    final isLoading =
        onboardingAsync is AsyncLoading || userAsync is AsyncLoading;

    if (isLoading) {
      return const MaterialApp(
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Kubera Pulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
