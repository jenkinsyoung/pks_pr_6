import 'package:flutter/material.dart';
import 'package:pr_6/models/item.dart';
import 'package:pr_6/pages/info_page.dart';
import 'package:pr_6/components/item_list.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  void _removeGame(int index) {
    setState(() {
      if (basket.contains(games[index])){
        basket.removeAt(basket.indexOf(games[index]));
      }
      favorite.removeAt(favorite.indexOf(games[index]));
      games.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Избранное',
            style: TextStyle(
              color: Color.fromRGBO(76, 23, 0, 1.0),
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: favorite.isEmpty
          ?  const Center(
            child: Padding(
              padding: EdgeInsets.only(
                right: 20.0,
                left: 20.0,
              ),
              child: Text(
                'У Вас нет избранных товаров',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(76, 23, 0, 1.0),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
            :  Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                right: 15.0,
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  childAspectRatio: 161 / 205,
                ),
                itemCount: favorite.length,
                itemBuilder: (BuildContext context, int index) {
                  final int originalIndex = games.indexOf(favorite[index]);
                  return GestureDetector(
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => InfoPage(game: favorite[index]),
                        ),
                      );
                      if (result != null && result is Item) {
                        setState(() {
                          games[originalIndex] = result;
                        });
                      }
                      else if (result != null && result is int) {
                        setState(() {
                          _removeGame(originalIndex);
                        });
                      }
                    },
                    child: ItemList(
                        key: Key('${games[index].title} ${favorite.contains(games[index])} ${basket.contains(games[index])}'),
                        game: favorite[index]
                    ),
                  );
              },
              ),
      ),
    );
  }
}
