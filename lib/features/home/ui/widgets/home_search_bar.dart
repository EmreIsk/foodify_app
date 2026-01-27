import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/home/ui/cubit/anasayfa_cubit.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Ne yemek istersin?",
          prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (aramaSonucu) {
          context.read<AnasayfaCubit>().ara(aramaSonucu);
        },
      ),
    );
  }
}
