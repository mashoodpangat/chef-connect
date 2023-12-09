import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Container shimmercontainer(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width - 40,
    height: MediaQuery.of(context).size.height / 1.48,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade100,
            highlightColor: Colors.grey.shade300,
            direction: ShimmerDirection.ltr,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              height: 20,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: double.infinity,
                              height: 20,
                              color: Colors.white,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Container(
                              width: 100,
                              height: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              itemCount: 10,
            ),
          ),
        ),
      ],
    ),
  );
}

Container shimmersSubcategories(BuildContext context) {
  return Container(
      child: Shimmer.fromColors(
    baseColor: Colors.grey.shade100,
    highlightColor: Colors.grey.shade200,
    direction: ShimmerDirection.ltr,
    child: GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 3 / 4),
      itemBuilder: (_, __) => Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
      ),
    ),
  ));
}

Container shimmersActiveOrders(BuildContext context) {
  return Container(
    color: Colors.white,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade100,
      highlightColor: Colors.grey.shade300,
      direction: ShimmerDirection.ltr,
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 180,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
          ),
        ),
        itemCount: 10,
      ),
    ),
  );
}
