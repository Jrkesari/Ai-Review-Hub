import 'package:flutter/material.dart';

class CategorySideBarRow extends StatefulWidget {
  final String? caption;
  final String title;
  final List<String?>? subCategory;
  final VoidCallback onTap;
  final bool isSelected;
  final int index;
  final int selectedIndex;
  final String selectedSubcategory;
  final Function subCategoryOntap;

  const CategorySideBarRow({
    Key? key,
    required this.title,
    required this.subCategory,
    required this.caption,
    required this.onTap,
    required this.isSelected,
    required this.index,
    required this.selectedIndex,
    required this.selectedSubcategory,
    required this.subCategoryOntap,
  }) : super(key: key);

  @override
  State<CategorySideBarRow> createState() => _CategorySideBarRowState();
}

class _CategorySideBarRowState extends State<CategorySideBarRow> {
  bool isShowMore = false;

  @override
  Widget build(BuildContext context) {
    int subCategoryCount = widget.subCategory?.length ?? 0;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: widget.isSelected
                ? LinearGradient(
                    colors: [
                      const Color.fromARGB(255, 9, 66, 112),
                      Colors.blue.shade300
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            boxShadow: widget.isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      widget.index == widget.selectedIndex
                          ? Icons.arrow_drop_down_circle_outlined
                          : Icons.arrow_forward_ios,
                      size: 17,
                      color: widget.isSelected ? Colors.white : Colors.black54,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.isSelected
                                ? Colors.white
                                : const Color(0xFF19191D),
                            fontWeight: widget.isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        if (widget.caption != null &&
                            widget.caption!.isNotEmpty)
                          Text(
                            widget.caption!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: widget.isSelected
                                  ? Colors.white70
                                  : const Color(0xFF787885),
                              fontSize: 14,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                if (subCategoryCount > 0 && widget.isSelected)
                  SizedBox.fromSize(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        isShowMore
                            ? subCategoryCount
                            : (subCategoryCount < 5 ? subCategoryCount : 5),
                        (index) => GestureDetector(
                          onTap: () => widget.subCategoryOntap(
                              widget.subCategory![index] ?? ""),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 40),
                            child: Text(
                              widget.subCategory![index] ?? "",
                              style: TextStyle(
                                fontWeight: widget.selectedSubcategory ==
                                        widget.subCategory![index]
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: widget.isSelected
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (subCategoryCount > 5 && widget.isSelected)
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: SizedBox(
                      height: 28,
                      width: 114,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            isShowMore = !isShowMore;
                          });
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue.shade200),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.blue.shade900),
                        ),
                        child: Text(isShowMore ? 'Show less' : 'Show more'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
