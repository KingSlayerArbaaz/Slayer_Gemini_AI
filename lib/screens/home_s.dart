import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:slayer_ai/model/ai_model.dart';
import 'package:slayer_ai/screens/chatview.dart';
import 'package:slayer_ai/screens/text_widget.dart';

class HomeS extends StatefulWidget {
  const HomeS({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeSState createState() => _HomeSState();
}

class _HomeSState extends State<HomeS> {
  final TextEditingController search = TextEditingController();
  final Gemini gemini = Gemini.instance;
  List<Uint8List> images = [];
  final ImagePicker imagePicker = ImagePicker();

  List<AImodel> aiModel = [];

  bool loading = false;
 void _deleteImage(int index) {
    setState(() {
      images.removeAt(index); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Slayer-AI"),
        centerTitle: true,
        backgroundColor: Colors.black,
        foregroundColor:Colors.white,
      ),
      body: Column(
        
        children: [
          Expanded(
            child:
             Visibility(
                visible: aiModel.isNotEmpty,
                replacement: const Center(
                  child: Text("HI! How Can i help You"),
                ),
                child: SingleChildScrollView(
                  reverse: true,
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: aiModel.length,
                      separatorBuilder: (context, i) {
                        return const SizedBox(
                          height: 9,
                        );
                      },
                      itemBuilder: (context, i) {
                        return  Chatview(aiModel: aiModel[i],);
                      }),
                ),
                ),
          ),

          Visibility(
            visible: loading,
            child: const SizedBox(
              height: 50,
              child: LoadingIndicator(
                  indicatorType: Indicator.ballPulse, 
                  colors: [Colors.black],       
                  strokeWidth: 2,                     
                  pathBackgroundColor: Colors.black   
              ),
            )),

          TextWidget(
            images: images,
            search: search,
            imageSelect: () async {
              final List<XFile> medias = await imagePicker.pickMultiImage();
              if (medias.isNotEmpty) {
                for (final img in medias) {
                  images.add(await img.readAsBytes());
                }
                setState(() {}); 
              }
            },
            onSend: () async {
              aiModel.add(AImodel(
                  isUser: true,
                   text: search.text.toString(),
                    images: images));

                    
              String seachText = search.text.toString(); 
              List<Uint8List> img = images;

              images = [];

              search.clear();
              loading=true;
              setState(() {});
              if (seachText.isNotEmpty || img.isNotEmpty) {
                gemini.promptStream(parts: [
                  Part.text(seachText),
                  if (img.isNotEmpty)...img.map((image) => Part.uint8List(image)),
                ]).listen((value) {
                  if(aiModel.last.isUser==true)
                  {

                  aiModel.add(AImodel(
                      isUser: false,
                      text: value!.output,
                      images: []
                      
                      ));
                  }

                  aiModel.last.text ="${aiModel.last.text}" "${value?.output}";
                  loading=false;
                      setState(() {
                        
                      });

                 
                });
              } 
            }, 
            onDeleteImage:_deleteImage,
          ),
        ],
      ),
    );
  }
}
