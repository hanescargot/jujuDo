class Love {
  String title;
  bool isFinished;
  String image;
  DateTime? createdTime; // Uuid : doc

  Love({required this.title, required this.isFinished, required this.image}) {
    createdTime = DateTime.now();
  }
}
