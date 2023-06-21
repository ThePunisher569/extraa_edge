class Rocket {
  final String name;
  String country;
  int engines;
  List<String> flickerImages;
  bool active;
  int costPerLaunch;
  int successRatePercent;
  String description;
  String wikipedia;
  num height;
  num diameter;
  num heightInFeet;
  num diameterInFeet;

  Rocket({
    required this.name,
    required this.country,
    required this.engines,
    required this.flickerImages,
    required this.active,
    required this.costPerLaunch,
    required this.successRatePercent,
    required this.description,
    required this.wikipedia,
    required this.height,
    required this.diameter,
    required this.heightInFeet,
    required this.diameterInFeet,
  });

  factory Rocket.fromMap(Map<String, dynamic> map) {
    return Rocket(
      name: map['name'] as String,
      country: map['country'] as String,
      engines: map['engines']['number'] as int,
      flickerImages: List<String>.from(map['flickr_images']),
      active: map['active'] as bool,
      costPerLaunch: map['cost_per_launch'] as int,
      successRatePercent: map['success_rate_pct'] as int,
      description: map['description'] as String,
      wikipedia: map['wikipedia'] as String,
      height: map['height']['meters'] as num,
      diameter: map['diameter']['meters'] as num,
      heightInFeet: map['height']['feet'] as num,
      diameterInFeet: map['diameter']['feet'] as num,
    );
  }

  @override
  String toString() {
    return 'Rocket{name: $name, country: $country, engines: $engines, flickerImages: $flickerImages, active: $active, costPerLaunch: $costPerLaunch, successRatePercent: $successRatePercent, description: $description, wikiLink: $wikipedia, height: $height, diameter: $diameter, heightInFeet: $heightInFeet, diameterInFeet: $diameterInFeet}';
  }
}
