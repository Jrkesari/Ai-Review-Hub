List<Map<String, dynamic>> extraFilter = [
  {
    "title": "Recommended",
    "is_selected": false,
  },
  {
    "title": "Recently Added",
    "is_selected": false,
  },
  {
    "title": "Most Rated",
    "is_selected": false,
  },
];

List<Map<String, dynamic>> categoryList = [
  {
    'title': 'Chatbots',
    'icon': 'assets/icons/svg/hanger.svg',
  },
  {
    'title': 'Video Editing',
    'icon': 'assets/icons/svg/cinema.svg',
  },
  {
    'title': 'Music Generation',
    'icon': 'assets/icons/svg/concert.svg',
  },
  {
    'title': 'Finance',
    'icon': 'assets/icons/svg/fitness.svg',
  },
  {
    'title': 'Cybersecurity',
    'icon': 'assets/icons/svg/pets.svg',
  },
  {
    'title': 'Robotics',
    'icon': 'assets/icons/svg/observation.svg',
  },
  {
    'title': 'Autonomous Vehicles',
    'icon': 'assets/icons/svg/barley.svg',
  },
  {
    'title': 'Customer Service',
    'icon': 'assets/icons/svg/Vector.svg',
  },
  {
    'title': 'Healthcare',
    'icon': 'assets/icons/svg/babysitter.svg',
  },
];

List<Map<String, dynamic>> sideBarCategoryList = [
  {
    "title": "All Categories",
    "subtitle": "Explore our wide range of topics",
    "sub_category": <String>[],
  },
  {
    "title": "Technology",
    "subtitle": "Emerging Tech & Innovations",
    "sub_category": <String>[
      'Chatbots',
      'Video Editing',
      'Music Generation',
      'Cybersecurity',
      'Robotics',
      'Autonomous Vehicles'
    ],
  },
  {
    "title": "Industry Applications",
    "subtitle": "Specialized Tech Solutions",
    "sub_category": <String>['Finance', 'Healthcare', 'hello', 'bjhbkjs'],
  },
  {
    "title": "Consumer Tech",
    "subtitle": "",
    "sub_category": <String>[
      'Smartphones & Accessories AI Tools',
      'Home Automation'
    ],
  }
  // {
  //   "title": "Professional Gear",
  //   "subtitle": "",
  //   "sub_category": <String>[
  //     'Professional Cameras',
  //     'Studio Equipment',
  //     'Live Streaming Gear'
  //   ],
  // }
];

List<String> relatedKeyword = [
  'Tools',
  'Trending',
  'Famous',
  'Chatbot',
];

List<Map<String, dynamic>> productList = [
  {
    "title": "GPT-3",
    "price": "",
    "image": "assets/images/kitty.jpg",
    "rating": 4.05,
    "favorite": false,
    "url": "https://chat.openai.com/",
    'description':
        'High-quality wireless headphones with noise-cancellation and up to 40 hours of battery life.',
    "reviews": [
      Review(text: "Incredible AI tool.", rating: 5.0),
    ],
  },
  {
    "title":
        "Adobe Premiere Pro’s Auto Reframe: Automatically adjusts the aspect ratio of videos to suit different platforms.",
    "price": "",
    "image": "assets/images/shoe.png",
    "rating": 4.5,
    "favorite": false,
    "url": "https://www.example.com/shoe",
    'description':
        'High-quality wireless headphones with noise-cancellation and up to 40 hours of battery life.',
    "reviews": [
      Review(text: "Incredible AI tool.", rating: 5.0),
    ],
  },
  {
    "title": "DALL-E by OpenAI: Generates images from textual descriptions.",
    "price": "",
    "image": "assets/images/kitty.jpg",
    "rating": 2.05,
    "favorite": false,
    "url": 'https://openai.com/dall-e-2',
    'description':
        'High-quality wireless headphones with noise-cancellation and up to 40 hours of battery life.',
    "reviews": [
      Review(text: "Incredible AI tool.", rating: 5.0),
    ],
  },
  {
    "title":
        "AIVA: An AI composer that has been trained on classical scores to generate new pieces.",
    "price": "",
    "image": "assets/images/kitty.jpg",
    "rating": 5.0,
    "favorite": true,
    "url": "https://www.aiva.ai/",
    'description':
        'High-quality wireless headphones with noise-cancellation and up to 40 hours of battery life.',
    "reviews": [
      Review(text: "Incredible AI tool.", rating: 5.0),
    ],
  },
  {
    "title":
        "Grammarly: Provides writing suggestions to improve grammar, punctuation, and style.",
    "price": "",
    "image": "assets/images/kitty.jpg",
    "rating": 5.0,
    "favorite": false,
    "url": "https://www.grammarly.com/",
    'description':
        'High-quality wireless headphones with noise-cancellation and up to 40 hours of battery life.',
    "reviews": [
      Review(text: "Incredible AI tool.", rating: 5.0),
    ],
  },
  // {
  //   "title": "John Von Ebalkin SPRING ",
  //   "price": "",
  //   "image": "assets/images/jeans.png",
  //   "rating": 3.9,
  //   "favorite": false
  // },
  // {
  //   "title":
  //       "Envelope, Stripes, Pencil and etc. Purchase this kit today and feel OKAY",
  //   "price": "",
  //   "image": "assets/images/gift.png",
  //   "rating": 4.9,
  //   "favorite": false
  // },
  // {
  //   "title": "Professional teadrinking set for every designer and developer",
  //   "price": "",
  //   "image": "assets/images/kitchen.png",
  //   "rating": 3.05,
  //   "favorite": false
  // },
  // {
  //   "title": "One string Bonsai description",
  //   "price": "",
  //   "image": "assets/images/plant.png",
  //   "rating": 5.0,
  //   "favorite": false
  // },
  // {
  //   "title":
  //       "Simply best item in town to shine bright with your Nine Inch Nails",
  //   "price": "",
  //   "image": "assets/images/cosmetic.png",
  //   "rating": 1.0,
  //   "favorite": false
  // },
  // {
  //   "title":
  //       "KISTOCHKI & KRASIBO. Top cosmetics brand from Chelyabinsk is here!",
  //   "price": "",
  //   "image": "assets/images/brush.png",
  //   "rating": 1.5,
  //   "favorite": false
  // },
];

class Review {
  String text;
  double rating;

  Review({required this.text, required this.rating});
}
