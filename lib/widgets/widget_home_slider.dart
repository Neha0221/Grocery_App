import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:groceryapp/models/pagination.dart';
import 'package:groceryapp/models/slider.dart';
import 'package:groceryapp/providers.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomeSliderWidget extends ConsumerWidget {
  const HomeSliderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: _sliderList(ref),
    );
  }

  Widget _sliderList(WidgetRef ref) {
    final sliders = ref.watch(
      slidersProvider(PaginationModel(page: 1, pageSize: 10)),
    );

    return sliders.when(
      data: (list) {
        return imageCarousel(list!);
      },
      error: (err1, err2) => const Center(
        child: Text('error'),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget imageCarousel(
    List<SliderModel> sliderList,
  ) {
    return CarouselSlider(
        items: sliderList.map((model) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(model.fullImagePath),
                    fit: BoxFit.contain)),
          );
        }).toList(),
        options: CarouselOptions(
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.decelerate,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ));
  }
}
