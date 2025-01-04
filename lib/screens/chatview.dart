import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:slayer_ai/model/ai_model.dart';

class Chatview extends StatelessWidget {
  final AImodel aiModel;
  const Chatview({super.key, required this.aiModel});
  @override
  Widget build(BuildContext context) {
    if (aiModel.isUser == true) {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 8,
            ),
            const CircleAvatar(
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .80,
              padding:const EdgeInsets.symmetric(vertical: 8,horizontal: 8),
              margin:const EdgeInsets.only(left: 9),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 203, 203),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Visibility(
                      visible: aiModel.images?.isNotEmpty??false,
                      child:SizedBox(height: 120,
                      child: ListView.separated(
                        itemCount: aiModel.images?.length??0,
                        scrollDirection: Axis.horizontal,
                        padding:const EdgeInsets.all(8),
                        itemBuilder: (context,index){
                          return Container(
                            height: 120,width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(aiModel.images![index]))
                            ),
              
                          );
                        }, 
                        separatorBuilder: (context,index)=>const SizedBox(width:8.0), 
                      
                        )
                      ),
                       ),
                       Text(aiModel.text??"")
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 8,
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/ai.png'),
          ),
          const SizedBox(
            width: 8,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width * .80,
              child: 
              Markdown(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                // selectable: true,
                data: aiModel.text ?? "",
              ))
        ],
      );
    }
  }
}
