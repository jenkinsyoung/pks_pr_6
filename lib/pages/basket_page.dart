import 'package:flutter/material.dart';
import 'package:pr_6/components/basket_element_ui.dart';
import 'package:pr_6/models/item.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    totalPrice = _calculateTotalPrice();
  }

  int _calculateTotalPrice() {
    int total = 0;
    for (var item in basket) {
      total += item.price * basketCount[basket.indexOf(item)];
    }
    return total;
  }

  void _updateTotalPrice(int priceChange) {
    setState(() {
      totalPrice += priceChange;
    });
  }

  void _deleteGame(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text('Удалить игру из корзины',
              style: TextStyle(
                color: Color.fromRGBO(76, 23, 0, 1.0),
                fontWeight: FontWeight.w500,
                fontSize: 20,
              )),
        ),
        content: Text('Вы уверены, что хотите удалить "${basket[index].title}"?',
            style: const TextStyle(
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
                  setState(() {
                    basketCount.removeAt(index);
                    basket.removeAt(index);
                  });
                  Navigator.of(context).pop();
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
        title: const Center(
        child: Text(
            'Корзина',
            style: TextStyle(
            color: Color.fromRGBO(76, 23, 0, 1.0),
            fontSize: 28,
            fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: basket.isEmpty ?
          const Center(
            child: Text('Ваша корзина пуста',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(76, 23, 0, 1.0),
              ),)
          )
          :
      ListView(
        children: <Widget>[
          ListView.builder(
          padding: const EdgeInsets.all(8),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: basket.length,
          itemBuilder: (BuildContext context, int index) {
             return Dismissible(
               key: Key(basket[index].title),
               confirmDismiss: (direction) async {
                 _deleteGame(index);
                 return false;
               },
               child: BasketElementUi(
                key: Key(basket[index].title),
                game: basket[index],
                colorName: basket[index].indicator == 1
                    ? 'brown'
                    : basket[index].indicator == 2
                    ? 'pink'
                    : 'blue',
                textColor: basket[index].indicator == 1
                    ? const Color.fromRGBO(129, 40, 0, 1.0)
                    : basket[index].indicator == 2
                    ? const Color.fromRGBO(163, 3, 99, 1.0)
                    : const Color.fromRGBO(48, 0, 155, 1.0),
                onUpdatePrice: _updateTotalPrice,
                           ),
             );
          }
          ),

        Center(
          child: Container(
            width: 324,
            height: 0,
            decoration: BoxDecoration(
                border: Border.all(color: const Color.fromRGBO(76, 23, 0, 1.0),
                width: 1.5)
            ),
          ),
        ),
          Padding(
            padding: const EdgeInsets.only(
                top: 8.0,
              right: 35.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                      right: 15.0),
                  child: Text('Итог:',
                  style:
                      TextStyle(
                        color:  Color.fromRGBO(76, 23, 0, 1.0),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      )
                  ),
                ),
                Text('${_calculateTotalPrice()} ₽',
                    style:
                    const TextStyle(
                      color:  Color.fromRGBO(76, 23, 0, 1.0),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}
