class News {
  final String image;
  final String title;
  final String description;

  const News({this.image, this.title, this.description});

  static const descriptionNews = [
    News(
        image:
            "https://images.unsplash.com/photo-1563498948862-204ac576f5b9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
        title: "Une experience mobile"),
    News(
        image:
            "https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1650&q=80",
        title: "Nous preparons vos dossiers"),
    News(
        image:
            "https://images.unsplash.com/photo-1586985564259-6211deb4c122?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1615&q=80",
        title: "Nous communiquons a distance"),
  ];
}
