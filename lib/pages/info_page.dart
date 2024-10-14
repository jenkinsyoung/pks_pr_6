import 'package:flutter/material.dart';
import 'package:pr_6/components/info_ui.dart';
import 'package:pr_6/models/item.dart';


class InfoPage extends StatefulWidget {
  const InfoPage({super.key, required this.game});
  final Item game;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late Item game;

  @override
  void initState() {
    super.initState();
    game = widget.game;
  }

  void _deleteGame(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text('Удалить игру',
              style: TextStyle(
                color: Color.fromRGBO(76, 23, 0, 1.0),
                fontWeight: FontWeight.w500,
              )),
        ),
        content: const Text('Вы уверены, что хотите удалить эту игру?',
            style: TextStyle(
              color: Color.fromRGBO(76, 23, 0, 1.0),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            )),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(games.indexOf(game));
                },
                child: const Text('Да',
                    style: TextStyle(
                      color: Color.fromRGBO(21, 78, 24, 1.0),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    )),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Нет',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(game.title, style: TextStyle(
          color: game.indicator == 1 ? const Color.fromRGBO(129, 40, 0, 1.0) : game.indicator == 2 ? const Color.fromRGBO(163, 3, 99, 1.0) :const Color.fromRGBO(48, 0, 155, 1.0),
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (favorite.contains(game)) {
                        favorite.removeAt(favorite.indexOf(game));
                      } else {
                        favorite.add(game);
                      }
                      Navigator.of(context).pop(game);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InfoPage(game: game),
                        ),
                      );
                    });
                  },
                  child: Icon(
                    favorite.contains(game) ? Icons.favorite : Icons.favorite_border,
                    color: game.indicator == 1 ? const Color.fromRGBO(129, 40, 0, 1.0) : game.indicator == 2 ? const Color.fromRGBO(163, 3, 99, 1.0) :const Color.fromRGBO(48, 0, 155, 1.0),
                  ),
                ),

                IconButton(
                  icon: Icon(Icons.delete, color: game.indicator == 1 ? const Color.fromRGBO(129, 40, 0, 1.0) : game.indicator == 2 ? const Color.fromRGBO(163, 3, 99, 1.0) :const Color.fromRGBO(48, 0, 155, 1.0),),
                  onPressed: () => _deleteGame(games.indexOf(game)),
                ),
              ]
          ),
          InfoUi(game: game,
            textColor: game.indicator == 1 ? const Color.fromRGBO(129, 40, 0, 1.0) : game.indicator == 2 ? const Color.fromRGBO(163, 3, 99, 1.0) :const Color.fromRGBO(48, 0, 155, 1.0),
            nameColor: game.indicator == 1 ? 'brown' : game.indicator == 2 ? 'pink' : 'blue'
        ),

          Padding(
            padding: const EdgeInsets.only(top: 2.0,
                bottom: 10.0,
                right: 15.0,
                left: 15.0),
            child: GestureDetector(
              onTap: (){
                setState(() => _deleteGame(games.indexOf(game))
                );
              },
              child: Container(
                width: 120,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        color: Colors.redAccent,
                        width: 2
                    )
                ),
                child: const Center(
                  child: Text('Удалить игру',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}







