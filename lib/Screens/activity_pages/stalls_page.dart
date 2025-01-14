import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/stall_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/stall_provider.dart';
import 'PixelStoreCardWidget.dart';

class StallsPage extends StatefulWidget {
  const StallsPage({super.key});

  @override
  State<StallsPage> createState() => _StallsPageState();
}

class _StallsPageState extends State<StallsPage> {
  final TextEditingController _searchController = TextEditingController();
  List<StallModel> _stalls = [];
  List<StallModel> _filteredStalls = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final stallProvider = Provider.of<StallProvider>(context, listen: false);
      stallProvider.fetchStalls();
    });
  }

  // Future<List<StallModel>> getData() async {
  //   try {
  //     final stalls = await ViewModelMain().getStalls();
  //     setState(() {
  //       _stalls = stalls;
  //       print("This is stalls list: ${stalls.first.imgurl}");
  //       _filteredStalls = List.from(_stalls);
  //     });
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   }
  //   return _stalls;
  // }

  void _filterStalls(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredStalls = List.from(_stalls);
      });
    } else {
      setState(() {
        _filteredStalls = _stalls
            .where((stall) =>
                stall.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final stallProvider = Provider.of<StallProvider>(context);

    if (stallProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // Update local state when stalls are fetched
    if (_stalls.isEmpty) {
      _stalls = stallProvider.stalls;
      _filteredStalls = List.from(_stalls); // Initialize the filtered list
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        color: Colors.transparent, // Transparent container
        child: Column(
          children: [
            Opacity(
              opacity: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.0), // Transparent background
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Container(
                      color: Color(0xff1d2b53),
                      child: PixelTextField(
                        controller: _searchController,
                        onChanged: _filterStalls,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: ListView(
                children: [
                  ..._filteredStalls.map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: PixelStoreCard(stall: item),
                    ),
                  ),
                  SizedBox(height: bottomNavBarHeight - 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PixelTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final double horizontalPdding;
  final double height;

  const PixelTextField({
    super.key,
    this.controller,
    this.hintText = 'Search Food',
    this.onChanged,
    this.keyboardType,
    this.horizontalPdding = 20.0,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (horizontalPdding * 2),
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/textField.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            keyboardType: keyboardType,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Game_Tape',
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                  color: Color(0xff83769c),
                  fontFamily: 'Game_Tape',
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
