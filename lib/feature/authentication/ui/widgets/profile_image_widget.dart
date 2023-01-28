import 'dart:io';

import 'package:aramex/app/theme.dart';
import 'package:aramex/common/util/image_picker_bottom_sheet.dart';
import 'package:aramex/common/util/image_picker_utils.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ProfileImageWidget extends StatefulWidget {
  final String imageUrl;
  final File? file;
  final ValueChanged<File> onChanged;
  const ProfileImageWidget({
    super.key,
    this.file,
    this.imageUrl = "",
    required this.onChanged,
  });

  @override
  State<ProfileImageWidget> createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DottedBorder(
          borderType: BorderType.Circle,
          strokeWidth: 1,
          dashPattern: const [6],
          color: CustomTheme.primaryColor,
          child: Container(
            margin: const EdgeInsets.all(4),
            height: 115,
            width: 115,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(115),
              child: Builder(
                builder: (context) {
                  if (_selectedFile != null || widget.file != null) {
                    return Image.file(_selectedFile ?? widget.file!);
                  } else if (widget.imageUrl.isNotEmpty) {
                    return Image.network(widget.imageUrl);
                  } else {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: const Icon(
                        Icons.image,
                        color: CustomTheme.primaryColor,
                        size: 30,
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 10,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              showBottomSheet(
                context: context,
                builder: (context) {
                  return ImagePickerBottomSheet(
                    onGalleryPressed: () async {
                      final _res = await ImagePickerUtils.getGallery();
                      if (_res != null) {
                        setState(() {
                          _selectedFile = _res;
                        });
                        widget.onChanged(_res);
                      }
                      Navigator.pop(context);
                    },
                    onCameraPressed: () async {
                      final _res = await ImagePickerUtils.getCamera();
                      if (_res != null) {
                        setState(() {
                          _selectedFile = _res;
                        });
                        widget.onChanged(_res);
                      }
                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_outlined,
                  size: 22,
                  color: CustomTheme.primaryColor,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
