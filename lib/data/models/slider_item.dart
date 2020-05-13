class SliderItem {
  final String title;
  final String pathImage;
  final String description;

  SliderItem({this.description, this.pathImage, this.title});

  List<SliderItem> getSliderItems() {
    List<SliderItem> aSliderItems = List();

    aSliderItems.add(SliderItem(
        description: 'Changer de logement trouver votre logement allodd',
        title: 'Trouvez le logement qui vous convient',
        pathImage: 'assets/images/screenSplashHome.svg'));

    aSliderItems.add(
      SliderItem(
          description: 'Valide rle temps avec roof',
          title: 'Gagnez du temps',
          pathImage: 'assets/images/screenSplashTime.svg'),
    );

    aSliderItems.add(SliderItem(
      description: 'Assisatnce partout ou vous allez nous sommes avec vous',
      title: 'Toujours plus proche de vous',
      pathImage: 'assets/images/screenSplashAssistance.svg',
    ));

    return aSliderItems;
  }
}
