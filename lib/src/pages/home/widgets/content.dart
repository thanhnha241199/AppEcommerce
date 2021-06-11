//Library
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Package
import 'package:appecommerce/src/pages/home/widgets/banner_slide.dart';
import 'package:appecommerce/src/pages/home/widgets/flash_sale.dart';
import 'package:appecommerce/src/pages/home/widgets/main_menu.dart';
import 'package:appecommerce/src/pages/home/widgets/product_load_more.dart';
import 'package:appecommerce/src/pages/home/widgets/small_banner.dart';
import 'package:appecommerce/src/pages/home/widgets/story.dart';


class Content extends StatefulWidget {
  final TrackingScrollController scrollController;

  const Content(this.scrollController);

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final _indicatorController = IndicatorController();

  @override
  void dispose() {
    _indicatorController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      controller: _indicatorController,
      onRefresh: () => Future.delayed(const Duration(seconds: 2)),
      builder: (
        BuildContext context,
        Widget child,
        IndicatorController controller,
      ) {
        return AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, _) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (!controller.isIdle)
                  Positioned(
                    top: 100 * controller.value,
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: SpinKitThreeBounce(
                        color: Colors.deepOrange,
                        size: 20,
                      ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, 155.0 * controller.value),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: SingleChildScrollView(
        controller: widget.scrollController,
        child: Column(
          children: [
            BannerSlide(),
            SizedBox(height: 18),
            MainMenu(),
            SmallBanner(),
            _buildDivider(),
            FlashSale(),
            SizedBox(height: 12),
            _buildDivider(),
            Story(),
            _buildDivider(),
            ProductLoadMore(),
          ],
        ),
      ),
    );
  }

  Container _buildDivider() => Container(
        height: 14,
        color: Colors.grey[200],
      );
}
