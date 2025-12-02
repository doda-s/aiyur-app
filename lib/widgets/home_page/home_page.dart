// import 'package:aiyurapp/widgets/home_page/search_bar.dart';
// import 'package:aiyurapp/widgets/list_page/list_page.dart';
// import 'package:flutter/material.dart';
// import 'package:aiyurapp/widgets/home_page/movie_card.dart';
// import 'package:aiyurapp/widgets/profile_page/profile_page.dart';
// import 'package:aiyurapp/widgets/shared/profile.dart';

// class TopAppBar extends StatelessWidget {
//   final Widget title;
//   final int selectedCategoryIndex;
//   final Function(int) onCategorySelected;

//   const TopAppBar({
//     super.key,
//     required this.title,
//     required this.selectedCategoryIndex,
//     required this.onCategorySelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 190,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: const BoxDecoration(color: Color(0xFFE0E0E0)),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               const IconButton(
//                 icon: Icon(Icons.movie, color: Color(0xFF4A4A4A)),
//                 onPressed: null,
//               ),
//               Expanded(child: title),
//               ProfileButton(onPressed: () {}),
//             ],
//           ),
//           const SizedBox(height: 8),
//           const SearchBarWidget(),
//           CategorySelector(
//             selectedIndex: selectedCategoryIndex,
//             onCategorySelected: onCategorySelected,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategorySelector extends StatelessWidget {
//   final int selectedIndex;
//   final Function(int) onCategorySelected;

//   CategorySelector({
//     super.key,
//     required this.selectedIndex,
//     required this.onCategorySelected,
//   });

//   final List<String> categories = ["All", "Trending", "Popular", "Upcoming"];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(16),
//       padding: const EdgeInsets.all(4),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF5F5F5),
//         borderRadius: BorderRadius.circular(32),
//       ),
//       child: Row(
//         children: List.generate(categories.length, (index) {
//           final isSelected = selectedIndex == index;

//           return Expanded(
//             child: GestureDetector(
//               onTap: () => onCategorySelected(index),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 250),
//                 curve: Curves.easeInOut,
//                 padding: const EdgeInsets.symmetric(vertical: 10),
//                 decoration: BoxDecoration(
//                   color: isSelected
//                       ? const Color(0xFF4A4A4A)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(32),
//                 ),
//                 child: Center(
//                   child: Text(
//                     categories[index],
//                     style: TextStyle(
//                       color: isSelected
//                           ? Colors.white
//                           : const Color(0xFF5E5E5E),
//                       fontWeight: isSelected
//                           ? FontWeight.bold
//                           : FontWeight.w500,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }

// class PageContent extends StatefulWidget {
//   const PageContent({super.key});

//   @override
//   State<PageContent> createState() => _PageContentState();
// }

// class _PageContentState extends State<PageContent> {
//   int _currentBottomIndex = 0;
//   int _selectedCategoryIndex = 0;

//   final List<Map<String, String>> movies = [
//     {
//       'title': 'Coruja da Noite',
//       'image':
//           'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
//       'category': 'Trending',
//     },
//     {
//       'title': 'Filme do Sol',
//       'image':
//           'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
//       'category': 'Popular',
//     },
//     {
//       'title': 'Montanha Misteriosa',
//       'image': 'https://picsum.photos/200/300',
//       'category': 'Upcoming',
//     },
//     {
//       'title': 'Lago Sereno',
//       'image': 'https://picsum.photos/200/301',
//       'category': 'Trending',
//     },
//     {
//       'title': 'Floresta Sombria',
//       'image': 'https://picsum.photos/200/302',
//       'category': 'Popular',
//     },
//     {
//       'title': 'Horizonte Perdido',
//       'image': 'https://picsum.photos/200/303',
//       'category': 'Upcoming',
//     },
//   ];

//   final List<String> categories = ["All", "Trending", "Popular", "Upcoming"];

//   List<Map<String, String>> get filteredMovies {
//     if (_selectedCategoryIndex == 0) return movies;
//     final selectedCategory = categories[_selectedCategoryIndex];
//     return movies
//         .where((movie) => movie['category'] == selectedCategory)
//         .toList();
//   }

//   Widget _getBody() {
//     switch (_currentBottomIndex) {
//       case 0:
//         return Column(
//           children: [
//             TopAppBar(
//               title: const Text(
//                 "Movies",
//                 style: TextStyle(
//                   color: Color(0xFF2D2D2D),
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               selectedCategoryIndex: _selectedCategoryIndex,
//               onCategorySelected: (index) {
//                 setState(() {
//                   _selectedCategoryIndex = index;
//                 });
//               },
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: GridView.builder(
//                   itemCount: filteredMovies.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) {
//                     final movie = filteredMovies[index];
//                     return MovieCard(
//                       imageUrl: movie['image']!,
//                       label: movie['title']!,
//                       onTap: () {
//                         Navigator.pushNamed(
//                           context,
//                           '/movieDetail',
//                           arguments: {
//                             'title': movie['title']!,
//                             'imageUrl': movie['image']!,
//                           },
//                         );
//                       },
//                       description: '',
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         );

//       case 1:
//         return const ProfilePage();

//       case 2:
//         return const MyListsPage();

//       default:
//         return const SizedBox();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: _getBody(),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentBottomIndex,
//         selectedItemColor: const Color(0xFF4A4A4A),
//         unselectedItemColor: const Color(0xFF5E5E5E),
//         backgroundColor: const Color(0xFFE0E0E0),
//         onTap: (index) => setState(() => _currentBottomIndex = index),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.movie), label: "Filmes"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.supervised_user_circle),
//             label: "Profile",
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.list), label: "My Lists"),
//         ],
//       ),
//     );
//   }
// }
