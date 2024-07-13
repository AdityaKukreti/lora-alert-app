class CommentStructure {
  String userid = "";
  String comment = "";
  DateTime time = DateTime.timestamp();

  CommentStructure(this.userid, this.comment, this.time);
}

class PostStructure {
  String username = "";
  String userid = "";
  String title = "";
  String content = "";
  DateTime time = DateTime.timestamp();
  String state = "";
  List<CommentStructure> comments = [];
  int commentCount = 0;
  String type = "";

  PostStructure(this.username, this.userid, this.title, this.content, this.time,
      this.comments, this.state, this.commentCount, this.type);
}

List<PostStructure> posts = [
  PostStructure(
      "NDRF",
      "NDRF001",
      "Cyclone Alert in West Bengal",
      "A severe cyclone warning has been issued for coastal West Bengal. Residents are advised to evacuate low-lying areas.",
      DateTime(2023, 10, 5, 14, 30),
      [
        CommentStructure("user100", "Is there a relief camp near Kolkata?",
            DateTime(2023, 10, 5, 14, 45)),
        CommentStructure(
            "user105",
            "Are the roads towards the city center safe?",
            DateTime(2023, 10, 5, 15, 00)),
        CommentStructure(
            "user106",
            "What supplies do we need to bring to the camp?",
            DateTime(2023, 10, 5, 15, 30)),
        CommentStructure("user107", "Has the train service been suspended?",
            DateTime(2023, 10, 5, 16, 00))
      ],
      "West Bengal",
      4,
      "Cyclone"),
  PostStructure(
      "Tamil Nadu Govt",
      "TN_Gov001",
      "Flood Recovery Efforts in Chennai",
      "Recovery operations are underway in Chennai after last week's heavy rainfall caused significant flooding.",
      DateTime(2023, 7, 12, 9, 15),
      [
        CommentStructure(
            "user101",
            "Thank you for the updates, how can we help?",
            DateTime(2023, 7, 12, 9, 30)),
        CommentStructure(
            "user108",
            "Is the electricity supply going to be restored soon?",
            DateTime(2023, 7, 12, 10, 00)),
        CommentStructure(
            "user109",
            "Are there any medical camps set up in the area?",
            DateTime(2023, 7, 12, 10, 30)),
        CommentStructure("user110", "How do we report missing persons?",
            DateTime(2023, 7, 12, 11, 00))
      ],
      "Tamil Nadu",
      4,
      "Flood"),
  PostStructure(
      "Kerala State Emergency",
      "KL_SE001",
      "Landslide Warning in Idukki",
      "Continued heavy rains have increased the risk of landslides in Idukki. Please avoid vulnerable areas and stay tuned for further updates.",
      DateTime(2023, 8, 23, 8, 30),
      [
        CommentStructure(
            "user102",
            "Can we get an update on the road closures?",
            DateTime(2023, 8, 23, 16, 20)),
        CommentStructure("user111", "Are evacuation shelters pet-friendly?",
            DateTime(2023, 8, 23, 17, 00)),
        CommentStructure(
            "user112",
            "What are the signs of an impending landslide we should watch out for?",
            DateTime(2023, 8, 23, 17, 30)),
        CommentStructure(
            "user113",
            "Is the mobile network operational in the area?",
            DateTime(2023, 8, 23, 18, 00))
      ],
      "Kerala",
      4,
      "Landslide"),
  PostStructure(
      "Uttarakhand Disaster Management",
      "UKDM001",
      "Avalanche Warning in the Himalayas",
      "An avalanche warning has been issued for the higher regions of Uttarakhand. All trekking expeditions are temporarily suspended.",
      DateTime(2023, 12, 15, 8, 45),
      [
        CommentStructure(
            "user103",
            "Stay safe everyone, this season has been tough.",
            DateTime(2023, 12, 15, 9, 00)),
        CommentStructure(
            "user114",
            "Has there been any reported damage or injuries?",
            DateTime(2023, 12, 15, 9, 30)),
        CommentStructure(
            "user115",
            "What should trekkers currently in the mountains do?",
            DateTime(2023, 12, 15, 10, 00)),
        CommentStructure("user116", "Are the rescue teams on standby?",
            DateTime(2023, 12, 15, 10, 30))
      ],
      "Uttarakhand",
      4,
      "Avalanche"),
  PostStructure(
      "Central Weather Bureau",
      "CWG001",
      "Severe Drought in Rajasthan",
      "Rajasthan faces severe drought conditions this year. Water conservation measures are in effect, and aid is being dispatched to the most affected areas.",
      DateTime(2023, 6, 20, 12, 10),
      [
        CommentStructure(
            "user104",
            "This is really serious, any tips on saving water?",
            DateTime(2023, 6, 20, 12, 25)),
        CommentStructure("user117", "How long is the drought expected to last?",
            DateTime(2023, 6, 20, 13, 00)),
        CommentStructure(
            "user118",
            "Are there water distribution points set up?",
            DateTime(2023, 6, 20, 13, 30)),
        CommentStructure(
            "user119",
            "What is the government doing to help farmers?",
            DateTime(2023, 6, 20, 14, 00))
      ],
      "Rajasthan",
      4,
      "Drought"),
  PostStructure(
      "Odisha Disaster Response",
      "ODR001",
      "Cyclone Preparation in Odisha",
      "With cyclone season approaching, Odisha's government is ramping up preparations. Evacuation plans are in place, and residents are urged to secure their homes and prepare emergency kits.",
      DateTime(2023, 9, 15, 10, 30),
      [
        CommentStructure(
            "user200",
            "What should we include in our emergency kits?",
            DateTime(2023, 9, 15, 10, 45))
      ],
      "Odisha",
      1,
      "Cyclone"),
  PostStructure(
      "Delhi Environmental Department",
      "DED001",
      "Air Quality Alert in Delhi",
      "Due to stagnant weather conditions, air quality in Delhi has deteriorated significantly. Residents are advised to limit outdoor activities and use air purifiers indoors.",
      DateTime(2023, 11, 3, 17, 00),
      [
        CommentStructure(
            "user201",
            "Are schools going to be closed because of this?",
            DateTime(2023, 11, 3, 17, 15))
      ],
      "Delhi",
      1,
      "Air Quality"),
  PostStructure(
      "Manipur Gov",
      "MNG001",
      "Earthquake Recovery Efforts in Manipur",
      "After a 6.2 magnitude earthquake, recovery efforts are underway in Manipur. Relief supplies are being distributed, and temporary shelters have been set up for displaced families.",
      DateTime(2023, 5, 22, 11, 50),
      [
        CommentStructure(
            "user202",
            "How can we volunteer to help with the relief operations?",
            DateTime(2023, 5, 22, 12, 05))
      ],
      "Manipur",
      1,
      "Earthquake"),
  PostStructure(
      "Goa Tourism Safety Board",
      "GTSB001",
      "Tsunami Watch for Goa",
      "A tsunami watch is in effect for the coast of Goa following a significant undersea earthquake detected near the Indian Ocean. Residents and tourists should follow all safety protocols and stay away from the beach until further notice.",
      DateTime(2023, 7, 30, 14, 20),
      [
        CommentStructure("user203", "Has any evacuation been started yet?",
            DateTime(2023, 7, 30, 14, 35))
      ],
      "Goa",
      1,
      "Tsunami"),
  PostStructure(
      "Punjab Agricultural Department",
      "PAD001",
      "Locust Attack Warning in Punjab",
      "Farmers in Punjab are warned of an impending locust attack expected to hit the region within the next week. Measures are being put in place to combat the invasion and minimize crop damage.",
      DateTime(2023, 6, 10, 15, 30),
      [
        CommentStructure("user204", "What can we do to protect our crops?",
            DateTime(2023, 6, 10, 15, 45))
      ],
      "Punjab",
      1,
      "Locust Attack"),
  PostStructure(
      "Delhi Fire Service",
      "DFS001",
      "Severe Fire Alert in Delhi Markets",
      "A major fire has broken out in several markets across Delhi due to electrical faults enhanced by the dry season. Residents are urged to avoid affected areas and adhere to safety guidelines issued by authorities.",
      DateTime(2023, 4, 20, 18, 30),
      [
        CommentStructure(
            "user300",
            "Are there any specific areas we should avoid?",
            DateTime(2023, 4, 20, 18, 45))
      ],
      "Delhi",
      1,
      "Fire"),
  PostStructure(
      "Assam Flood Control",
      "AFC001",
      "Urgent Flood Warning in Assam",
      "Persistent heavy rains have raised water levels of the Brahmaputra river, leading to flooding in multiple districts. Evacuation orders are in place for vulnerable areas.",
      DateTime(2023, 8, 5, 13, 10),
      [
        CommentStructure(
            "user301",
            "What are the safe evacuation routes for Dibrugarh?",
            DateTime(2023, 8, 5, 13, 25))
      ],
      "Assam",
      1,
      "Flood"),
  PostStructure(
      "UP State Emergency Service",
      "USES001",
      "Heatwave Advisory for Uttar Pradesh",
      "With temperatures expected to soar above 45 degrees Celsius, a severe heatwave advisory is in effect across Uttar Pradesh. Residents are advised to stay hydrated and avoid going out during peak hours.",
      DateTime(2023, 6, 15, 16, 00),
      [
        CommentStructure(
            "user302",
            "How can we help elderly neighbors who may be affected by the heat?",
            DateTime(2023, 6, 15, 16, 15))
      ],
      "Uttar Pradesh",
      1,
      "Heatwave")
];
