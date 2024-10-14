import 'package:flutter/material.dart';
import 'package:pr_6/models/item.dart';
import 'package:pr_6/pages/info_page.dart';

class InfoUi extends StatefulWidget {
  const InfoUi({super.key, required this.game, required this.textColor, required this.nameColor});
  final Item game;
  final Color textColor;
  final String nameColor;

  @override
  State<InfoUi> createState() => _InfoUiState();
}

class _InfoUiState extends State<InfoUi> {


  void _increase() {
    setState(() {
      basketCount[basket.indexOf(widget.game)]++;
      Navigator.of(context).pop(widget.game);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InfoPage(game: widget.game),
        ),
      );
    });
  }

  void _decrease() {
    setState(() {
      if (basketCount[basket.indexOf(widget.game)] > 1) {
        basketCount[basket.indexOf(widget.game)]--;
      } else {
        basketCount.removeAt(basket.indexOf(widget.game));
        basket.removeAt(basket.indexOf(widget.game));
      }
      Navigator.of(context).pop(widget.game);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => InfoPage(game: widget.game),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(
        right: 20.0,
        left: 20.0,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          width: 322,
          height: 280,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.game.image),
                fit: BoxFit.cover
            ),
            borderRadius: const BorderRadius.all(Radius.circular(15)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 13.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 5.0),
                    child: Image( image: AssetImage('lib/assets/groups_${widget.nameColor}.png' ),
                      width: 18,
                    ),
                  ),
                  Text(widget.game.gamers, style:
                  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: widget.textColor,
                  )
                  ),
                ],
              ),


              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Image( image: AssetImage('lib/assets/clock_${widget.nameColor}.png'),
                      width: 18,
                    ),
                  ),
                  Text(widget.game.time, style:
                  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: widget.textColor,
                  ),
                  ),
                ],
              ),

              Text('${widget.game.age}+', style:
              TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: widget.textColor,
              ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0
                  ),
                  child: Text('Цена: ',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,

                    ),
                    textAlign: TextAlign.left,),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0
                  ),
                  child: Text('${widget.game.price} ₽',
                    style: TextStyle(
                      color: widget.textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,

                    ),
                    textAlign: TextAlign.left,),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                  // right: 15.0,
                  // left: 15.0
              ),
              child: basket.contains(widget.game) == false ? GestureDetector(
                onTap: (){
                  setState(() {
                    basket.add(widget.game);
                    basketCount.add(1);
                    Navigator.of(context).pop(widget.game);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InfoPage(game: widget.game),
                      ),
                    );
                  });
                },
                child: Container(
                  width: 360,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          color: widget.textColor,
                          width: 2
                      )
                  ),
                  child: Center(
                    child: Text('Добавить в корзину',
                        style: TextStyle(
                          fontSize: 16,
                          color: widget.textColor,
                          fontWeight: FontWeight.w600,
                        )),
                  ),
                ),
              ):
              SizedBox(
                width: 80,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                        onTap: _decrease,
                        child: Text('-', style:
                        TextStyle(
                          color: widget.textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1,
                        )
                        )
                    ),
                    Text('${basketCount[basket.indexOf(widget.game)]}',
                      style:
                      TextStyle(
                        color: widget.textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                    ),
                    GestureDetector(
                        onTap: _increase,
                        child: Text('+',
                          style:
                          TextStyle(
                            color: widget.textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            height: 1,
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 25.0, bottom: 10.0),
              child: Text('Описание',
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(widget.game.description, style: TextStyle(
                color: widget.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
                textAlign: TextAlign.justify,
              ),
            ),


            Padding(
              padding: const EdgeInsets.only(
                  top: 25.0, bottom: 10.0),
              child: Text('Правила',
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(widget.game.rules, style: TextStyle(
                color: widget.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),

      ],
    );
  }
}