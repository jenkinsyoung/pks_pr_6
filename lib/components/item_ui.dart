import 'package:flutter/material.dart';
import 'package:pr_6/models/item.dart';
import 'package:pr_6/pages/info_page.dart';
class ItemUi extends StatefulWidget {
  const ItemUi({super.key, required this.game, required this.bodyColor, required this.textColor});
  final Item game;
  final Color bodyColor;
  final Color textColor;

  @override
  State<ItemUi> createState() => _ItemUiState();
}

class _ItemUiState extends State<ItemUi> {
  late Item game;
  void _increase() {
    setState(() {
      basketCount[basket.indexOf(game)]++;
    });
  }

  void _decrease() {
    setState(() {
      if (basketCount[basket.indexOf(game)] > 1) {
        basketCount[basket.indexOf(game)]--;
      } else {
        basketCount.removeAt(basket.indexOf(game));
        basket.removeAt(basket.indexOf(game));
      }
    });
  }
  @override
  void initState() {
    super.initState();
    game = widget.game;
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      width: 161,
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.topStart,
        children: <Widget>[
          Container(
            width: 161,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              image: DecorationImage(image:  NetworkImage(
                  game.image,
                ),
                fit: BoxFit.cover
              )
            ),
          ),
          Positioned(
            top: 7.0,
            left: 7.0,
            child: SizedBox(
              width: 147,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: widget.bodyColor,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    child: Center( child: Text('${game.age}+', style: TextStyle(
                      fontSize: 10,
                      color: widget.textColor,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        game.changeFavorite(game);
                      });
                    },
                    child: Icon(
                      favorite.contains(game) ? Icons.favorite : Icons.favorite_border,
                      color: widget.bodyColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 87.25,
            child: Container(
              height: 115,
              width: 161,
              decoration: BoxDecoration(
                  color: widget.bodyColor,
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5.0,
                      left: 5.0,
                      bottom: 5.0,
                    ),
                    child: SizedBox(
                      width: 140,
                      child: Center(
                        child: Text(game.title, style: TextStyle(
                          fontSize: 12,
                          color: widget.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 140,
                    height: 0,
                    decoration:
                    BoxDecoration(
                      border: Border(
                          top: BorderSide(width: 1.0,
                          color: widget.textColor,
                        )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5.0,
                        left: 8.0,
                        right: 8.0
                    ),
                    child: SizedBox(
                      width: 140,
                      child: Text(game.description ,
                        style: TextStyle(
                          fontSize: 8,
                          color: widget.textColor,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      right: 8.0,
                      top: 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${game.price} ₽', style: TextStyle(
                          fontSize: 12,
                          color: widget.textColor,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => InfoPage(game: game),
                              ),
                            );
                          }, child: Text('Подробнее >>',
                          style: TextStyle(
                            fontSize: 10,
                            color: widget.textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:5.0,
                    bottom: 8.0),
                    child: basket.contains(game) == false ? GestureDetector(
                      onTap: (){
                        setState(() {
                          basket.add(game);
                          basketCount.add(1);
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 19,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                              color: widget.textColor,
                              width: 2
                          )
                        ),
                        child: Center(
                          child: Text('Добавить в корзину',
                          style: TextStyle(
                            fontSize: 9,
                            color: widget.textColor,
                            fontWeight: FontWeight.w600,
                          )),
                        ),
                      ),
                    ):
                    SizedBox(
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: _decrease,
                              child: Text('-', style:
                              TextStyle(
                                color: widget.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1,
                              )
                              )
                          ),
                          Text('${basketCount[basket.indexOf(widget.game)]}',
                            style:
                            TextStyle(
                              color: widget.textColor,
                              fontSize: 14,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            )
          ),
        ],
      ),
    );
  }
}

