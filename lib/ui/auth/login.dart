import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prep_pro/ui/home/Pages/page_details.dart';
import 'package:prep_pro/ui/widgets/spacing.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../controllers/auth_controller.dart';
import '../widgets/floating_hero.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ctrl = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF8A9091),
                  // AppColors.primary,
                  Color(0xFF8A9091),
                  // AppColors.primary.withOpacity(0.99),
                  // AppColors.primary.withOpacity(0.95),
                  // AppColors.primary.withOpacity(0.94),
                  // AppColors.primary.withOpacity(0.95),
                  // AppColors.primary.withOpacity(0.99),
                ],
              ),
            ),
          ),
          Column(
            children: [
              const Spacer(),
              const Spacer(),
              const UpDownAnimation(),
              const Spacer(),
              const Spacer(),
              Row(
                children: [
                  hs(35),
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        ctrl.googleSignIn();
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      color: Colors.black,
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.g_mobiledata,
                            color: Colors.white,
                            size: 35,
                          ),
                          Text(
                            "Sign in with Google",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 18.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  hs(35),
                ],
              ),
              vs(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SignInWithAppleButton(
                  onPressed: () async {
                    ctrl.appleSignIn();
                  },
                ),
              ),
              vs(15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: TextButton(
                  child: const Text("Test Sign In"),
                  onPressed: () async {
                    ctrl.testSignIn();
                  },
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(() =>
                          const PageDetails(slug: "terms-and-conditions"));
                    },
                    child: Text(
                      "Terms and Conditions",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    color: Colors.white,
                    width: 1,
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const PageDetails(slug: "privacy-policy"));
                    },
                    child: Text(
                      "Privacy Policy",
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              vs(50),
            ],
          )
        ],
      ),
    );
  }
}
