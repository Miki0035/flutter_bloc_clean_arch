int calculateReadingTime(String content) {
  final wordCount = content.split(r'\s+').length;
  final readingTime = wordCount / 225;
  return readingTime.ceil();
}
