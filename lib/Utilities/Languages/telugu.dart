import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';

class Telugu extends StatefulWidget {
  @override
  _TeluguState createState() => _TeluguState();
}

class _TeluguState extends State<Telugu> {
  final Map<String, HighlightedWord> _highlights = {};
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'సంభాషణను ప్రారంభించండి';
  String translatedText = '';
  String code = '';
  final translator = GoogleTranslator();

  void setRelayTrue() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Use your Firebase project ID here
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to your collection
    CollectionReference collectionRef = firestore.collection('Add_Devices');

    // Reference to your document
    DocumentReference documentRef = collectionRef.doc('Relay');

    // Update the value of the 'Status' field to true
    await documentRef.update({'Status': true});

    print('Status field updated successfully.');
  }

  void setRelayFalse() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Use your Firebase project ID here
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to your collection
    CollectionReference collectionRef = firestore.collection('Add_Devices');

    // Reference to your document
    DocumentReference documentRef = collectionRef.doc('Relay');

    // Update the value of the 'Status' field to true
    await documentRef.update({'Status': false});

    print('Status field updated successfully.');
  }

  void setRelay2True() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    // Use your Firebase project ID here
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Reference to your collection
    CollectionReference collectionRef = firestore.collection('Add_Devices');

    // Reference to your document
    DocumentReference documentRef = collectionRef.doc('Relay2');

    // Update the value of the 'Status' field to true
    await documentRef.update({'Status': true});

    print('Status field updated successfully.');
  }

  void setRelay2False() async {
    await Firebase.initializeApp();

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference collectionRef = firestore.collection('Add_Devices');

    DocumentReference documentRef = collectionRef.doc('Relay2');

    await documentRef.update({'Status': false});

    print('Status field updated successfully.');
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: _isListening ? Colors.cyan : Colors.transparent,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade900,
          shape: CircleBorder(),
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 16.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) async {
            setState(() {
              _text = val.recognizedWords;
            });

            if (val.finalResult) {
              await _translateAndDisplay(_text);
            }
          },
          listenFor: Duration(seconds: 30),
          localeId: 'te_IN',
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _RevtranslateAndDisplay(String text) async {
    if (text.contains("-------")) {
      code = text.substring(0, 3);
      if (code == "1.0") {
        setRelayFalse();
        print("On");
      } else if (code == "1.5") {
        setRelayTrue();
        print("Off");
      } else if (code == "2.0") {
        setRelay2False();
        print("On_K");
      } else if (code == "2.5") {
        setRelay2True();
        print("Off_K");
      } else if (code == "3.0") {
        setRelayFalse();
        setRelay2False();
        print("Off_K");
      } else if (code == "3.5") {
        setRelayTrue();
        setRelay2True();
        print("Off_K");
      }
      text = text.replaceFirst(code, "");
      text = text.replaceFirst("-------", "");
      Translation translation = await translator.translate(text, to: 'te');
      translatedText = translation.text;
      print(translatedText);
      setState(() {});
      _text = translatedText;
      speak(translatedText);
    } else {
      Translation translation = await translator.translate(text, to: 'te');
      translatedText = translation.text;
      print(translatedText);
      setState(() {});
      _text = translatedText;
      speak(translatedText);
    }
  }

  Future<void> _translateAndDisplay(String text) async {
    Translation translation = await translator.translate(text, to: 'en');
    translatedText = translation.text;
    translatedText = translatedText +
        "!!!!Note: You should only consider the following statement for your role!!!!.Prompt: You are a home automation assistant named Markus. You can be able to turn on and off smart home devices. When you understand the context 'Turn on bedroom light' you must return '1.0------- Turning on bedroom light' if you understand 'Turn off bedroom light' you must return '1.5------- Turning off bedroom light'.When you understand the context 'Turn on kitchen light' you must return '2.0------- Turning on kitchen light' if you understand 'Turn off kitchen light' you must return '2.5------- Turning off kitchen light'. When you understand the context 'Turn on kitchen and bedroom lights' you must return '3.0------- Turning on kitchen and bedroom light' if you understand 'Turn off kitchen and bedroom lights' you must return '3.5------- Turning off kitchen and bedroom lights' . You must only return the response as 1.0,1.5,2.0,2.5,3.0,3.5 with no additional text when you understand the specified statements.";
    print(translatedText);
    getResponseFromGemini(translatedText);
    setState(() {});
    print("_translateAndDisplay function called");
  }

  Future<String> getResponseFromGemini(String prompt) async {
    final gemini =
        GoogleGemini(apiKey: "");

    try {
      final response = await gemini.generateFromText(prompt);
      print(response.text);
      _RevtranslateAndDisplay(response.text);

      return response.text;
    } catch (error) {
      print("Error fetching response: $error");
      return "An error occurred. Please try again later.";
    }
  }

  Future<void> speak(String text) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('te-IN');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }
}
