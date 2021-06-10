import 'package:flutter/material.dart';
import '../screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({

    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,

  });

  String get ComplexityText {

    if(complexity == Complexity.Simple)
      return 'Simple';

    if(complexity == Complexity.Challenging)
      return 'Challenging';

    if(complexity == Complexity.Hard)
      return 'Hard';

  }

  String get AffordabilityText {

    if(affordability == Affordability.Affordable)
      return 'Affordable';

    if(affordability == Affordability.Luxurious)
      return 'Luxurious';

    if(affordability == Affordability.Pricey)
      return 'Pricey';

  }

  void selectMeal(BuildContext context) {

    Navigator.of(context).pushNamed(

      MealDetailScreen.routeName, arguments: id,

    ).then((result) {

      if(result != null)
        ;

    });

  }

  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: () => selectMeal(context),

      child: Card(

        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(15),

        ),

        elevation: 5,
        margin: EdgeInsets.all(15),
        child: Column(

          children: <Widget>[

            Stack(


              children: <Widget>[

                // force the child into certain form
                ClipRRect(

                  borderRadius: BorderRadius.only(

                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),

                  ),

                  child: Image.network(

                    imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,

                  ),

                ),

                Positioned(

                  // 26 away from bottom of the biggest child of stack i.e image
                  bottom: 26,
                  right: 10,

                  child: Container(

                    width: 280,
                    padding: EdgeInsets.symmetric(

                      vertical: 5,
                      horizontal: 20,

                    ),

                    child: Text(

                      title,
                      style: TextStyle(

                        fontSize: 26,
                        color: Colors.white,

                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,


                    ),

                    decoration: BoxDecoration(

                      color: Colors.black54,

                      borderRadius: BorderRadius.circular(15),

                    ),

                  ),

                )

              ],

            ),

            Padding(

              padding: EdgeInsets.all(20),
              child: Row(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Row(

                    children: <Widget>[

                      Icon(Icons.schedule,),
                      SizedBox(width: 6,),
                      Text('$duration min'),

                    ]

                  ),

                  Row(

                    children: <Widget>[

                      Icon(Icons.work,),
                      SizedBox(width: 6,),
                      Text(ComplexityText),

                    ]

                  ),

                  Row(

                    children: <Widget>[

                      Icon(Icons.work,),
                      SizedBox(width: 6,),
                      Text(AffordabilityText),

                    ]

                  ),

                ],

              ),

            )

          ],

        ),

      ),

    );

  }

}