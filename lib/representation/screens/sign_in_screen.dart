import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/rootpage.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/sign_up_screen.dart';

import '../cubit/user_cubit.dart';
import '../cubit/user_state.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: BlocConsumer<SignInCubit, UserState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Success")),
            );
            context.read<SignInCubit>().getUserData();
            print("minooos");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RootPage(),
              ),
            );
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFEFF2F5),
            body: Stack(
              children: [
                // Top image covering the entire screen
                Container(
                  height: size.height * 0.35,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Login Card
                DraggableScrollableSheet(
                  initialChildSize: 0.7, // Start at 70% of the screen
                  minChildSize: 0.7, // Minimum size is 70%
                  maxChildSize: 1, // Can expand to full screen
                  builder: (context, scrollController) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Form(
                            key: context.read<SignInCubit>().signInFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Center(
                                  child: Text(
                                    "SmartRoad",
                                    style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  child: Text(
                                    "Hello member, ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Ravi de vous revoir sur SmartRoad!",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                // Username Field
                                TextField(
                                  controller:
                                      context.read<SignInCubit>().signInPhone,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Saisissez votre numéro de telephone ...",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 10,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF5F8FA),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Password Field
                                TextField(
                                  controller: context
                                      .read<SignInCubit>()
                                      .signInPassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Saisissez votre mot de passe...",
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 10,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xFFF5F8FA),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    suffixIcon: const Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                      size: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Remember Me & Forgot Password Row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: true,
                                          onChanged: (value) {},
                                          activeColor: const Color.fromRGBO(
                                              26, 64, 113, 1),
                                        ),
                                        const Text(
                                          "Se souvenir de moi",
                                          style: TextStyle(fontSize: 11),
                                        ),
                                      ],
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Mot de passe oublié ?",
                                        style: TextStyle(
                                          color: const Color.fromRGBO(
                                              26, 64, 113, 1),
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                // Sign-In Button
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.read<SignInCubit>().signIn();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(26, 64, 113, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: state is SignInLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "Se connecter",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w100,
                                            ),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                // Don't Have Account?
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Vous n'avez pas de compte ?",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpScreen(),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "S'inscrire",
                                          style: TextStyle(
                                            color: const Color.fromRGBO(
                                                26, 64, 113, 1),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}



// class SignInScreen extends StatelessWidget {
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: BlocConsumer<SignInCubit, UserState>(
//         listener: (context, state) {
//           if (state is SignInSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text("success"),
//               ),
//             );//
//             // context.read<SignInCubit>().getUserData();
//             // Navigator.push(
//             //   context,
//             //   MaterialPageRoute(
//             //     builder: (context) => const ProfileScreen(),
//             //   ),
//             // );
//           } else if (state is SignInFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.errMessage),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: const Color(0xffEEF1F3),
//             body: Column(
//               children: [
//                 const PageHeader(),
//                 Expanded(
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.vertical(
//                         top: Radius.circular(20),
//                       ),
//                     ),
//                     child: SingleChildScrollView(
//                       child: Form(
//                         key: context.read<SignInCubit>().signInFormKey,
//                         child: Column(
//                           children: [
//                             const PageHeading(title: 'Sign-in'),
//                             //!Email
//                             CustomInputField(
//                               labelText: 'Pohne Number',
//                               hintText: 'Your Phone Number',
//                               controller: context.read<SignInCubit>().signInPhone,
//                             ),
//                             const SizedBox(height: 16),
//                             //!Password
//                             CustomInputField(
//                               labelText: 'Password',
//                               hintText: 'Your password',
//                               obscureText: true,
//                               suffixIcon: true,
//                               controller:
//                                   context.read<SignInCubit>().signInPassword,
//                             ),
//                             const SizedBox(height: 16),
//                             ForgetPasswordWidget(size: size),
//                             const SizedBox(height: 20),
//                             state is SignInLoading
//                                 ? const CircularProgressIndicator()
//                                 : CustomFormButton(
//                                     innerText: 'Sign In',
//                                     onPressed: () {
//                                       context.read<SignInCubit>().signIn();
//                                     },   
//                                   ),
//                             const SizedBox(height: 18),
//                             //! Dont Have An Account ?
//                             DontHaveAnAccountWidget(size: size),
//                             const SizedBox(height: 20),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
