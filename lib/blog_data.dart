class BlogPost {
  final String title;
  final String content;
  final String imageUrl;
  final String category;

  BlogPost({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.category,
  });
}

List<BlogPost> blogPosts = [
  BlogPost(
    title: "Poetry of the Soul",
    content: "A poetic journey into the heart of emotions, reflections, and dreams. Discover words that speak to the soul...",
    imageUrl: "https://picsum.photos/seed/picsum/200/300",
    category: "Poetry",
  ),
  BlogPost(
    title: "History Unfolded",
    content: "Delve into the pages of history and rediscover the events that shaped our world. From the past to present...",
    imageUrl: "https://picsum.photos/seed/picsum/200/300",
    category: "History",
  ),
  BlogPost(
    title: "Literature & Legacy",
    content: "Explore classic literature and the minds behind them. A rich tapestry of storytelling that transcends time...",
    imageUrl: "https://picsum.photos/seed/picsum/200/300",
    category: "Literature",
  ),
  BlogPost(
    title: "Modern Reflections",
    content: "Thoughts and essays on today's digital era, social issues, and personal identity. See the world through new eyes...",
    imageUrl: "https://picsum.photos/seed/picsum/200/300",
    category: "Literature",
  ),
  BlogPost(
    title: "Verses Untold",
    content: "Hidden gems of poetry that never found the limelight. Read words that echo silence, longing, and beauty...",
    imageUrl: "https://picsum.photos/seed/picsum/200/300",
    category: "Poetry",
  ),
  BlogPost(
    title: "Echoes of Bengal",
    content: "Explore the Bengali heritage and its cultural roots through vivid narratives, myths, and truths...",
    imageUrl: "https://picsum.photos/seed/picsum/200/300",
    category: "History",
  ),
];
