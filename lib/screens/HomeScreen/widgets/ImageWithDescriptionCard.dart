import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/theme/appColor.dart';

class ImageWithDescriptionCard extends StatefulWidget {
  final String imageUrl;
  final String description;
  final VoidCallback onLike;

  const ImageWithDescriptionCard({
    super.key,
    required this.imageUrl,
    required this.description,
    required this.onLike,
  });

  @override
  State<ImageWithDescriptionCard> createState() => _ImageWithDescriptionCardState();
}

class _ImageWithDescriptionCardState extends State<ImageWithDescriptionCard> {
  bool isLiked = false;
  bool isExpanded = false;
  final int maxLines = 2;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              widget.imageUrl,
              fit: BoxFit.cover,
              height: 180,
              width: double.infinity,
            ),
          ),

          // Actions Row (Like Button)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    widget.onLike();
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      key: ValueKey<bool>(isLiked),
                      color: isLiked ? Appcolor.primary : Colors.grey,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Description Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final TextSpan textSpan = TextSpan(
                      text: widget.description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5, // Adjust line height
                          ),
                    );
                    final TextPainter textPainter = TextPainter(
                      text: textSpan,
                      maxLines: maxLines,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);

                    final bool isTextOverflowing = textPainter.didExceedMaxLines;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.description,
                          maxLines: isExpanded ? null : maxLines,
                          overflow: isExpanded ? null : TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                height: 1.5, // Adjust line height
                              ),
                        ),
                        if (isTextOverflowing)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                isExpanded ? 'Show less' : 'Show more',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}