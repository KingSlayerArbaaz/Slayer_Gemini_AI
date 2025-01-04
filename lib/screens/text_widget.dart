import 'dart:typed_data';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final TextEditingController search;
  final VoidCallback imageSelect, onSend;
  final List<Uint8List> images;
  final void Function(int) onDeleteImage; 

  const TextWidget({
    super.key,
    required this.imageSelect,
    required this.onSend,
    required this.search,
    required this.images,
    required this.onDeleteImage, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(8, 8, 12, 15),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 52, 51, 51),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Visibility(
            visible: images.isNotEmpty,
            child: SizedBox(
              height: 120,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      // Image Container
                      Container(
                        height: 120,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(images[index]),
                          ),
                        ),
                      ),
                  
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Expanded(
                          child: GestureDetector(
                            onTap: () {
                              onDeleteImage(index); 
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration:const BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(width: 8.0),
                itemCount: images.length,
              ),
            ),
          ),
          Row(children: [
            IconButton(
              onPressed: imageSelect,
              icon: const Icon(Icons.image),
              color: Colors.white,
            ),
            Expanded(
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                controller: search,
                minLines: 1,
                maxLines: 6,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Your Message here",
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onSend,
                icon: const Icon(Icons.send),
              ),
            ),
          ])
        ],
      ),
    );
  }
}

