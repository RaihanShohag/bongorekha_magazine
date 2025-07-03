import 'package:flutter/material.dart';
import 'blog_data.dart';
import 'blog_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BlogPost> filteredPosts = blogPosts;
  String selectedCategory = 'All';
  final TextEditingController searchController = TextEditingController();

  void filterPosts(String query) {
    setState(() {
      filteredPosts = blogPosts.where((post) {
        return post.title.toLowerCase().contains(query.toLowerCase()) ||
            post.content.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      if (category == 'All') {
        filteredPosts = blogPosts;
      } else {
        filteredPosts = blogPosts
            .where((post) => post.category.toLowerCase() == category.toLowerCase())
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('📰 Bongorekha Magazine'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: BlogSearchDelegate(
                  posts: blogPosts,
                  onSelect: (post) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BlogDetailsPage(post: post)),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.redAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.menu_book, size: 40, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Bongorekha Menu',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Video'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    categoryChip('All'),
                    categoryChip('Literature'),
                    categoryChip('Poetry'),
                    categoryChip('History'),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ...filteredPosts.map((post) => blogCard(post)).toList(),
              const SizedBox(height: 20),
              const Text(
                '🎥 Watch our latest video:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              const SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: const Center(
                    child: Icon(Icons.play_circle_outline, size: 60, color: Colors.redAccent),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryChip(String label) => Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: ChoiceChip(
      label: Text(label),
      selected: selectedCategory == label,
      onSelected: (_) => filterByCategory(label),
      selectedColor: Colors.redAccent,
      backgroundColor: Colors.grey[800],
      labelStyle: const TextStyle(color: Colors.white),
    ),
  );

  Widget blogCard(BlogPost post) => Card(
    color: Colors.white,
    margin: const EdgeInsets.symmetric(vertical: 8),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BlogDetailsPage(post: post)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                post.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(post.title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(
                    post.content.length > 80
                        ? post.content.substring(0, 80) + '...'
                        : post.content,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class BlogSearchDelegate extends SearchDelegate {
  final List<BlogPost> posts;
  final Function(BlogPost) onSelect;

  BlogSearchDelegate({required this.posts, required this.onSelect});

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.clear),
      onPressed: () => query = '',
    )
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) {
    final results = posts
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: results
          .map((post) => ListTile(
        title: Text(post.title),
        onTap: () => onSelect(post),
      ))
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = posts
        .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView(
      children: suggestions
          .map((post) => ListTile(
        title: Text(post.title),
        onTap: () => onSelect(post),
      ))
          .toList(),
    );
  }
}
