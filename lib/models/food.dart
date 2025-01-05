class Food {
  String name;
  String image;
  double cal;
  double time;
  double rate;
  int reviews;
  bool isLiked;

  Food({
    required this.name,
    required this.image,
    required this.cal,
    required this.time,
    required this.rate,
    required this.reviews,
    required this.isLiked,
  });
}

final List<Food> foods = [
  Food(
    name: "Суп Рамен с курицей",
    image: "assets/images/ramen-noodles.jpg",
    cal: 120,
    time: 15,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
  Food(
    name: "Говяжий стейк",
    image: "assets/images/beaf-steak.jpg",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: true,
  ),
  Food(
    name: "Масляная курица",
    image: "assets/images/butter-chicken.jpg",
    cal: 130,
    time: 18,
    rate: 4.2,
    reviews: 10,
    isLiked: false,
  ),
  Food(
    name: "Французский тост",
    image: "assets/images/french-toast.jpg",
    cal: 110,
    time: 16,
    rate: 4.6,
    reviews: 90,
    isLiked: true,
  ),
  Food(
    name: "Пельмени",
    image: "assets/images/Pelmeni_Russian.jpg",
    cal: 150,
    time: 30,
    rate: 4.0,
    reviews: 76,
    isLiked: false,
  ),
  Food(
    name: "Мексиканская пицца",
    image: "assets/images/mexican-pizza.jpg",
    cal: 140,
    time: 25,
    rate: 4.4,
    reviews: 23,
    isLiked: false,
  ),
  Food(
    name: "Карп-белка",
    image: "assets/images/126e4f77-54e5-4947-ab96-ff0236f74e49.webp",
    cal: 731,
    time: 60,
    rate: 4.1,
    reviews: 16,
    isLiked: false,
  ),Food(
    name: "Запеканка из кабачков с курицей",
    image: "assets/images/b03a49b4-5ada-4e01-8328-d861c84c9481.webp",
    cal: 403,
    time: 70,
    rate: 4.7,
    reviews: 58,
    isLiked: false,
  ),Food(
    name: "Голубцы из савойской капусты с индейкой",
    image: "assets/images/3c453e04-a6fe-4385-a605-845b55e67d17.webp",
    cal: 140,
    time: 90,
    rate: 4.8,
    reviews: 21,
    isLiked: false,
  ),Food(
    name: "Рыба в корочке из рисовой муки",
    image: "assets/images/aad1ece6-3e89-4762-b0a8-5d41a59d37d3.webp",
    cal: 140,
    time: 25,
    rate: 4.7,
    reviews: 23,
    isLiked: true,
  ),Food(
    name: "Чкмерули по-грузински",
    image: "assets/images/dc59280c-c714-406e-b98a-4ca3bccf8371.webp",
    cal: 1100,
    time: 45,
    rate: 5.0,
    reviews: 3,
    isLiked: false,
  ),Food(
    name: "Овсяная каша с овощами",
    image: "assets/images/a0b2a3f7-3716-4c39-97b7-e20aa985d02b.webp",
    cal: 80,
    time: 15,
    rate: 4.6,
    reviews: 12,
    isLiked: false,
  ),Food(
    name: "Молочный коктейль с печеньем",
    image: "assets/images/4696aae2-26a2-4760-acbe-74fb1c452cc7.webp",
    cal: 430,
    time: 20,
    rate: 4.9,
    reviews: 8,
    isLiked: true,
  ),
];
