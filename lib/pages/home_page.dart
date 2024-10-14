import 'package:flutter/material.dart';
import 'package:pr_6/components/item_list.dart';
import 'package:pr_6/models/item.dart';
import 'package:pr_6/pages/create_page.dart';
import 'package:pr_6/pages/info_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void _addGame(Item game) {
    setState(() {
      games.add(game);
    });
  }

  void _removeGame(int index) {
    setState(() {
      if (basket.contains(games[index])){
        basket.removeAt(basket.indexOf(games[index]));
      }
      games.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Настольные игры',
            style: TextStyle(
              color: Color.fromRGBO(76, 23, 0, 1.0),
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: games.isEmpty
      ? const Center(
        child: Padding(
          padding: EdgeInsets.only(
            right: 20.0,
            left: 20.0,
          ),
          child: Text(
            'Нет доступных товаров, добавьте хотя бы одну карточку',
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(76, 23, 0, 1.0),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      )
      : Padding(
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
          itemCount: games.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () async {
                final result = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => InfoPage(game: games[index]),
                  ),
                );
                if (result != null && result is Item) {
                  setState(() {
                    games[index] = result;
                  });
                }
                else if(result != null && result is int){
                  setState(() {
                    _removeGame(result);
                  });
                }
              },
              child: ItemList(
                  key: Key('${games[index].title} ${favorite.contains(games[index])} ${basket.contains(games[index])}'),
                  game: games[index]),
            );
          },
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: SizedBox(
          width: 50,
          height: 50,
          child: FloatingActionButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreatePage()),
              );
              if (result != null && result is Item) {
                _addGame(result);
              }
            },
            backgroundColor: const Color.fromRGBO(76, 23, 0, 1.0),
            foregroundColor: const Color.fromRGBO(255, 230, 230, 1.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
