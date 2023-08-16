import 'package:flutter/material.dart';

import '../auth/different_auth/sell_yr_animal.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  double minPrice = 0;
  double maxPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Search by Price Range',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Minimum Price (PKR)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  minPrice = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Maximum Price (PKR)',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  maxPrice = double.parse(value);
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SellYourAnimal.routeName,
                  arguments: {
                    'minPrice': minPrice,
                    'maxPrice': maxPrice,
                  },
                );
              },
              child: const Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}
