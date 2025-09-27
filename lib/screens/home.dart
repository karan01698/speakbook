// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:image_picker/image_picker.dart';
// import '../constants/appcolorsconst.dart';
// import '../constants/imagesconst.dart';
// import '../widget/cutom_drawer.dart';
// import '../widget/reusable_button.dart';
//
// class TranslateSpeakScreen extends StatefulWidget {
//   const TranslateSpeakScreen({Key? key}) : super(key: key);
//
//   @override
//   State<TranslateSpeakScreen> createState() => _TranslateSpeakScreenState();
// }
//
// class _TranslateSpeakScreenState extends State<TranslateSpeakScreen> {
//   final TextEditingController _textController = TextEditingController();
//   String selectedLanguage = "Hindi";
//
//   bool _isMicOn = false; // ✅ mic default mute state
//
//   final List<String> indianLanguages = [
//     "Hindi",
//     "Bengali",
//     "Telugu",
//     "Marathi",
//     "Tamil",
//     "Gujarati",
//     "Kannada",
//     "Odia",
//     "Punjabi",
//     "Malayalam",
//     "Urdu",
//     "Assamese",
//     "Maithili",
//     "Sanskrit",
//   ];
//
//   final ImagePicker _picker = ImagePicker();
//   File? _selectedImage;
//
//   final FlutterTts _flutterTts = FlutterTts();
//
//   @override
//   void dispose() {
//     _flutterTts.stop(); // ✅ stop TTS when leaving screen
//     super.dispose();
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//       await _extractTextFromImage(_selectedImage!);
//     }
//   }
//
//   Future<void> _extractTextFromImage(File image) async {
//     final textRecognizer = TextRecognizer();
//     final inputImage = InputImage.fromFile(image);
//     final RecognizedText recognizedText =
//     await textRecognizer.processImage(inputImage);
//
//     String scannedText = recognizedText.text;
//     if (scannedText.isNotEmpty) {
//       setState(() {
//         _textController.text = scannedText;
//       });
//     }
//
//     textRecognizer.close();
//   }
//
//   Future<void> _speakText(String text) async {
//     if (text.isEmpty) return;
//
//     Map<String, String> langMap = {
//       "Hindi": "hi-IN",
//       "Bengali": "bn-IN",
//       "Telugu": "te-IN",
//       "Marathi": "mr-IN",
//       "Tamil": "ta-IN",
//       "Gujarati": "gu-IN",
//       "Kannada": "kn-IN",
//       "Odia": "or-IN",
//       "Punjabi": "pa-IN",
//       "Malayalam": "ml-IN",
//       "Urdu": "ur-IN",
//       "Assamese": "as-IN",
//       "Maithili": "hi-IN",
//       "Sanskrit": "sa-IN",
//     };
//
//     String languageCode = langMap[selectedLanguage] ?? "hi-IN";
//
//     await _flutterTts.setLanguage(languageCode);
//     await _flutterTts.setPitch(1.0);
//     await _flutterTts.awaitSpeakCompletion(true);
//     await _flutterTts.speak(text);
//   }
//
//   void _toggleMic() async {
//     if (_isMicOn) {
//       // ✅ currently speaking → stop
//       await _flutterTts.stop();
//       setState(() {
//         _isMicOn = false;
//       });
//     } else {
//       // ✅ start speaking
//       setState(() {
//         _isMicOn = true;
//       });
//       await _speakText(_textController.text);
//       // ✅ after speaking, auto mute
//       setState(() {
//         _isMicOn = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const CustomDrawer(),
//
//       body: Stack(
//         children: [
//
//           // ✅ Full-screen background image
//           SizedBox.expand(
//             child: Image.network(
//               'https://tse4.mm.bing.net/th/id/OIP.dSzAS7uKvdfhoDsR_Upp2wHaEZ?pid=Api&P=0&h=180',
//               fit: BoxFit.fill,
//             ),
//           ),
//
//           // ✅ Foreground UI with SafeArea + Padding
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // 🔹 Top Row → Logo + Dropdown
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Image.asset(AppImages.appLogo2, height: 100),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         decoration: BoxDecoration(
//                           color: AppColors.greencolor,
//                           borderRadius: BorderRadius.circular(25),
//                           border: Border.all(
//                             color: Colors.white,
//                             width: 1,
//                           ),
//
//                         ),
//                         child: DropdownButtonHideUnderline(
//                           child: DropdownButton<String>(
//                             value: selectedLanguage,
//                             dropdownColor: Colors.black, // 🔥 Dropdown list background black
//                             icon: Icon(
//                               Icons.arrow_drop_down,
//                               color: Colors.white, // 🔥 Icon white
//                               size: 30, // 🔥 Thoda bada icon
//                             ),
//                             style: GoogleFonts.poppins(
//                               fontSize: 18,
//                               color: Colors.white, // 🔥 Selected text white
//                             ),
//                             items: indianLanguages
//                                 .map(
//                                   (lang) => DropdownMenuItem(
//                                 value: lang,
//                                 child: Text(
//                                   lang,
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 18,
//                                     color: Colors.white, // 🔥 Dropdown item text white
//                                   ),
//                                 ),
//                               ),
//                             )
//                                 .toList(),
//                             onChanged: (val) {
//                               setState(() => selectedLanguage = val!);
//                             },
//                           ),
//                         ),
//
//
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 20),
//
//                   // 🔹 Text + Image Box
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.8),
//                               border: Border.all(color: Colors.grey.shade400),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Column(
//                               children: [
//                                 TextField(
//                                   controller: _textController,
//                                   maxLines: null,
//                                   decoration: const InputDecoration(
//                                     hintText:
//                                     "Enter text in English or pick image...",
//                                     border: InputBorder.none,
//                                   ),
//                                 ),
//                                 if (_selectedImage != null)
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 8.0),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(8),
//                                       child: Image.file(
//                                         _selectedImage!,
//                                         height: 150,
//                                         width: double.infinity,
//                                         fit: BoxFit.fill,
//                                       ),
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 20),
//
//                           // 🔹 Gallery + Camera buttons
//                           Align(
//                             alignment: Alignment.centerRight,
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 _buildActionButton(
//                                   text: "Gallery",
//                                   onPressed: () =>
//                                       _pickImage(ImageSource.gallery),
//                                   backgroundColor: AppColors.greencolor,
//                                   textColor: Colors.white,
//
//                                 ),
//                                 const SizedBox(width: 10),
//                                 _buildActionButton(
//                                   text: "Camera",
//                                   onPressed: () =>
//                                       _pickImage(ImageSource.camera),
//                                   backgroundColor: AppColors.greencolor,
//                                   textColor: Colors.white,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   // 🔹 Speak circular button
//                   Center(
//                     child: GestureDetector(
//                       onTap: _toggleMic,
//                       child: Container(
//                         width: 70,
//                         height: 70,
//                         decoration: BoxDecoration(
//                           color: _isMicOn
//                               ? AppColors.greenOverlay
//                               : Colors.red, // ✅ red when active
//                           shape: BoxShape.circle,
//                         ),
//                         child: Icon(
//                           _isMicOn ? Icons.mic : Icons.mic_off, // ✅ toggle icon
//                           color: Colors.white,
//                           size: 36,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton({
//     required String text,
//     required VoidCallback onPressed,
//     required Color backgroundColor,
//     required Color textColor,
//     IconData? icon,
//   }) {
//     return ReusableButton(
//       text: text,
//       isShimmer: true,
//       shimmerDuration: const Duration(seconds: 3),
//       onPressed: onPressed,
//       width: 100,
//       height: 40,
//       borderRadius: 25,
//       fontSize: 14,
//       backgroundColor: backgroundColor,
//       textColor: textColor,
//       borderColor: Colors.white,
//       borderWidth: 0,
//       icon: icon,
//       fontFamily: GoogleFonts.poppins().fontFamily,
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import '../constants/appcolorsconst.dart';
import '../constants/imagesconst.dart';
import '../widget/cutom_drawer.dart';
import '../widget/reusable_button.dart';

class TranslateSpeakScreen extends StatefulWidget {
  const TranslateSpeakScreen({Key? key}) : super(key: key);

  @override
  State<TranslateSpeakScreen> createState() => _TranslateSpeakScreenState();
}

class _TranslateSpeakScreenState extends State<TranslateSpeakScreen> {
  final TextEditingController _textController = TextEditingController();
  String selectedLanguage = "Hindi";

  bool _isMicOn = false;

  final List<String> indianLanguages = [
    "Hindi",
    "Bengali",
    "Telugu",
    "Marathi",
    "Tamil",
    "Gujarati",
    "Kannada",
    "Odia",
    "Punjabi",
    "Malayalam",
    "Urdu",
    "Assamese",
    "Maithili",
    "Sanskrit",
  ];

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final FlutterTts _flutterTts = FlutterTts();

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await _extractTextFromImage(_selectedImage!);
    }
  }

  Future<void> _extractTextFromImage(File image) async {
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFile(image);
    final RecognizedText recognizedText =
    await textRecognizer.processImage(inputImage);

    String scannedText = recognizedText.text;
    if (scannedText.isNotEmpty) {
      setState(() {
        _textController.text = scannedText;
      });
    }

    textRecognizer.close();
  }

  Future<void> _speakText(String text) async {
    if (text.isEmpty) return;

    Map<String, String> langMap = {
      "Hindi": "hi-IN",
      "Bengali": "bn-IN",
      "Telugu": "te-IN",
      "Marathi": "mr-IN",
      "Tamil": "ta-IN",
      "Gujarati": "gu-IN",
      "Kannada": "kn-IN",
      "Odia": "or-IN",
      "Punjabi": "pa-IN",
      "Malayalam": "ml-IN",
      "Urdu": "ur-IN",
      "Assamese": "as-IN",
      "Maithili": "hi-IN",
      "Sanskrit": "sa-IN",
    };

    String languageCode = langMap[selectedLanguage] ?? "hi-IN";

    await _flutterTts.setLanguage(languageCode);
    await _flutterTts.setPitch(1.0);
    await _flutterTts.awaitSpeakCompletion(true);
    await _flutterTts.speak(text);
  }

  void _toggleMic() async {
    if (_isMicOn) {
      await _flutterTts.stop();
      setState(() {
        _isMicOn = false;
      });
    } else {
      setState(() {
        _isMicOn = true;
      });
      await _speakText(_textController.text);
      setState(() {
        _isMicOn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:  CustomDrawer(), // ✅ Custom drawer use
      body: Stack(
        children: [
          // ✅ Background image
          SizedBox.expand(
            child: Image.network(
              'https://tse4.mm.bing.net/th/id/OIP.dSzAS7uKvdfhoDsR_Upp2wHaEZ?pid=Api&P=0&h=180',
              fit: BoxFit.fill,
            ),
          ),

          // ✅ Foreground UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🔹 Top Row → Menu + Logo + Dropdown
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Menu + Logo
                      Row(
                        children: [
                          Builder(
                            builder: (context) => IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 32,
                              ),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          Image.asset(AppImages.appLogo2, height: 80),
                        ],
                      ),

                      // Dropdown
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.greencolor,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedLanguage,
                            dropdownColor: Colors.black,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.white,
                              size: 30,
                            ),
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            items: indianLanguages
                                .map(
                                  (lang) => DropdownMenuItem(
                                value: lang,
                                child: Text(
                                  lang,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                                .toList(),
                            onChanged: (val) {
                              setState(() => selectedLanguage = val!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 🔹 Text + Image Box
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 400,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  controller: _textController,
                                  maxLines: null,
                                  decoration: const InputDecoration(
                                    hintText:
                                    "Enter text in English or pick image...",
                                    border: InputBorder.none,
                                  ),
                                ),
                                if (_selectedImage != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        _selectedImage!,
                                        height: 150,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 🔹 Gallery + Camera buttons
                          // Align(
                          //   alignment: Alignment.centerRight,
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       _buildActionButton(
                          //         text: "Gallery",
                          //         onPressed: () =>
                          //             _pickImage(ImageSource.gallery),
                          //         backgroundColor: AppColors.greencolor,
                          //         textColor: Colors.white,
                          //       ),
                          //       const SizedBox(width: 10),
                          //       _buildActionButton(
                          //         text: "Camera",
                          //         onPressed: () =>
                          //
                          //         backgroundColor: AppColors.greencolor,
                          //         textColor: Colors.white,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔹 Speak Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap:(){
                          _pickImage(ImageSource.camera);
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.greenOverlay,

                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _toggleMic,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: _isMicOn
                                ? AppColors.greenOverlay
                                : Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isMicOn ? Icons.mic : Icons.mic_off,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap:(){
                          _pickImage(ImageSource.gallery);
                        },
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: AppColors.greenOverlay,

                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.image,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
  }) {
    return ReusableButton(
      text: text,
      isShimmer: true,
      shimmerDuration: const Duration(seconds: 3),
      onPressed: onPressed,
      width: 100,
      height: 40,
      borderRadius: 25,
      fontSize: 14,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: Colors.white,
      borderWidth: 0,
      icon: icon,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
  }
}
