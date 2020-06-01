class SliderItem {
  final String title;
  final String pathImage;
  final String description;

  SliderItem({this.description, this.pathImage, this.title});

  List<SliderItem> getSliderItems() {
    List<SliderItem> aSliderItems = List();

    aSliderItems.add(
      SliderItem(
          description:
              "Fini le temps absurde pour avoir un logement, nous constituons vos dossiers, vous n'avez qu'a les choisir et les suivre dpuis votre smart"
              "phone",
          title: 'Gagnez du temps',
          pathImage: 'assets/images/screenSplashTime.svg'),
    );

    aSliderItems.add(
      SliderItem(
          description:
              "C'est vous qui choisissez ou vous voulez habiter, nous vous proposons regulierement les offres qui cadre avec votre budget",
          title: 'Trouvez le logement qui vous convient',
          pathImage: 'assets/images/screenSplashHome.svg'),
    );

    aSliderItems.add(
      SliderItem(
        description:
            "Une Assistance partout ou vous allez, nous avons des entretiens reguliers ur l'avancee de vos dossiers",
        title: 'Toujours plus proche de vous',
        pathImage: 'assets/images/screenSplashAssistance.svg',
      ),
    );

    return aSliderItems;
  }
}
