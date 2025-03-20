import 'package:diabetic/services/networking.dart';
import 'package:diabetic/utils/constants.dart';
import 'package:diabetic/utils/urls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key, required this.recipeId});
  final int recipeId;

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  bool isLoading = true;
  dynamic _myRecipe;
  List<dynamic> _review = [];
  List<dynamic> _comments = [];
  @override
  void initState() {
    super.initState();
    loadBook();
  }

  void loadBook() async {
//  setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NetworkHelper networkHelper = NetworkHelper(
        url: '$recipesUrl/${widget.recipeId}',
        token: prefs.getString("token") ?? "");
    // print(networkHelper.url);
    try {
      dynamic data = await networkHelper.getData();
      print(data);
      // .postData({"username": username, "password": password});
      // print(data);
      if (data["status"] == "success") {
        setState(() {
          _myRecipe = data["data"]["recipe"];
          _comments = data["data"]["comments"];
          _review = data["data"]["review"];
          isLoading = false;
        });
        print(_myRecipe);
      }
    } catch (e) {
      //   setError(e.toString());
      // setLoading(false);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
          
            appBar: AppBar(
              title: const Center(
                child: Text(
                  'Recipe Page',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // صورة المنتج مع التنقل لصفحة التفاصيل
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductDetailPage(),
                          ),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Image.network(
                            "${k_host}get/${_myRecipe?["recipe_photo"]}",
                            width: double.infinity,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // اسم المنتج
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        _myRecipe["recipe_name"],
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // وصف المنتج
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        _myRecipe["ingredients"],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        _myRecipe["instructions"],
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                    // قسم التقييم والمراجعات
                    Padding(
                      padding: EdgeInsets.all(20.0),
                      child: ReviewsSection(
                        comments: _comments,
                        review: _review,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
  }
}

// صفحة تفاصيل المنتج
class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: const Center(
        child: Text('تفاصيل المنتج هنا...'),
      ),
    );
  }
}

// صفحة عربة التسوق
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: const Center(
        child: Text('عربة التسوق هنا...'),
      ),
    );
  }
}

// قسم المراجعات
        // RatingDistributionWidget(),
        // SizedBox(height: 20),
        // Text(
        //   'Reviews:',
        //   style: TextStyle(
        //     fontSize: 18,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        // Divider(color: Colors.grey, thickness: 1, height: 30),
class ReviewsSection extends StatelessWidget {
  const ReviewsSection(
      {super.key, required this.comments, required this.review});
  final List<dynamic> review;
  final List<dynamic> comments;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          itemCount: comments.length,
          shrinkWrap: true, // Use this to prevent overflow
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeScreen(recipeId: 10),
                  ),
                );
              },
                  title: Column(
                    children: [
                      Divider(color: Colors.grey, thickness: 1, height: 30),
                      ReviewItem(
                        avatarPath: "${k_host}get/${ comments[index]["photo"]}",
                        reviewerName: comments[index]["first_name"]+" " + comments[index]["last_name"],
                        reviewText:
                            comments[index]["comment_content"],
                      ),
                    ],
                  ));
            },
          
        
    ),
    ]
    );
  }
}
        
        // Divider(color: Colors.grey, thickness: 1, height: 30),
        // ReviewItem(
        //   avatarPath: 'assets/images/land.jpeg',
        //   reviewerName: 'Hema Salem',
        //   reviewText:
        //       'A simple Sweater but makes the user seem neat and beautiful.',
        //   thumbsUp: 11,
        //   thumbsDown: 0,
        // ),
        // Divider(color: Colors.grey, thickness: 1, height: 30),
        // ReviewItem(
        //   avatarPath: 'assets/images/land.jpeg',
        //   reviewerName: 'Ahmed Ibrahim',
        //   reviewText:
        //       'A simple Sweater but makes the user seem neat and beautiful.',
        //   thumbsUp: 9,
        //   thumbsDown: 0,
        // ),
        // Divider(color: Colors.grey, thickness: 1, height: 30),
        // ReviewItem(
        //   avatarPath: 'assets/images/land.jpeg',
        //   reviewerName: 'Mabrouk Mohamed',
        //   reviewText:
        //       'A simple Sweater but makes the user seem neat and beautiful.',
        //   thumbsUp: 13,
        //   thumbsDown: 0,
        // ),

// Widget لكل مراجعة
class ReviewItem extends StatelessWidget {
  final String avatarPath;
  final String reviewerName;
  final String reviewText;


  const ReviewItem({
    Key? key,
    required this.avatarPath,
    required this.reviewerName,
    required this.reviewText,
  
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                print("");
              },
              child: CircleAvatar(
                radius: 40,
                backgroundImage: Image.network(avatarPath,errorBuilder: (context, error, stackTrace) {
    return Text('Failed to load image');
  },) as ImageProvider,
              ),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () {
                print("");
              },
              child: Text(
                reviewerName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const StarRatingWidget(),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            print("");
          },
          child: Text(
            reviewText,
            style: const TextStyle(fontSize: 14),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            InkWell(
              onTap: () {
                print("");
              },
              child: const Text(
                'Reply',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 20),
           
          ],
        ),
      ],
    );
  }
}

// Widget توزيع التقييمات العام
class RatingDistributionWidget extends StatefulWidget {
  const RatingDistributionWidget({Key? key}) : super(key: key);

  @override
  _RatingDistributionWidgetState createState() =>
      _RatingDistributionWidgetState();
}

class _RatingDistributionWidgetState extends State<RatingDistributionWidget> {
  int fiveStarCount = 179;
  int fourStarCount = 56;
  int threeStarCount = 34;
  int twoStarCount = 19;
  int oneStarCount = 2;
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    int total = fiveStarCount +
        fourStarCount +
        threeStarCount +
        twoStarCount +
        oneStarCount;
    double overallRating = total == 0
        ? 0
        : (5 * fiveStarCount +
                4 * fourStarCount +
                3 * threeStarCount +
                2 * twoStarCount +
                1 * oneStarCount) /
            total;

    return Padding(
      padding: const EdgeInsets.all(33.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // صف تقييم النجوم العام مع عرض الرقم
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStarRating(),
              Text(
                _currentRating == 0
                    ? overallRating.toStringAsFixed(1)
                    : _currentRating.toString(),
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 40),
          _buildRatingRow(5, fiveStarCount, total),
          const SizedBox(height: 4),
          _buildRatingRow(4, fourStarCount, total),
          const SizedBox(height: 4),
          _buildRatingRow(3, threeStarCount, total),
          const SizedBox(height: 4),
          _buildRatingRow(2, twoStarCount, total),
          const SizedBox(height: 4),
          _buildRatingRow(1, oneStarCount, total),
        ],
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      children: List.generate(5, (index) {
        int starIndex = index + 1;
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = starIndex;
              // تحديث عدد التقييمات بناءً على النجمة المضغوطة
              switch (starIndex) {
                case 5:
                  fiveStarCount++;
                  break;
                case 4:
                  fourStarCount++;
                  break;
                case 3:
                  threeStarCount++;
                  break;
                case 2:
                  twoStarCount++;
                  break;
                case 1:
                  oneStarCount++;
                  break;
              }
            });
          },
          child: Icon(
            Icons.star,
            size: 40,
            color: starIndex <= _currentRating ? Colors.orange : Colors.grey,
          ),
        );
      }),
    );
  }

  Widget _buildRatingRow(int starCount, int count, int total) {
    double fraction = total == 0 ? 0 : count / total;
    return Row(
      children: [
        Text(starCount.toString()),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: fraction,
            minHeight: 8.0,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
        const SizedBox(width: 8),
        Text(count.toString()),
      ],
    );
  }
}

// Widget تقييم النجوم داخل كل مراجعة
class StarRatingWidget extends StatefulWidget {
  const StarRatingWidget({Key? key}) : super(key: key);

  @override
  State<StarRatingWidget> createState() => _StarRatingWidgetState();
}

class _StarRatingWidgetState extends State<StarRatingWidget> {
  int _currentRating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        int starIndex = index + 1;
        return GestureDetector(
          onTap: () {
            setState(() {
              _currentRating = starIndex;
            });
          },
          child: Icon(
            Icons.star,
            size: 25,
            color: starIndex <= _currentRating ? Colors.orange : Colors.grey,
          ),
        );
      }),
    );
  }
}

// Widget عام لأزرار التفاعل (Chat, Wishlist, Share)
class ToggleIconButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color activeColor;
  final Color inactiveColor;

  const ToggleIconButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.activeColor,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  _ToggleIconButtonState createState() => _ToggleIconButtonState();
}

class _ToggleIconButtonState extends State<ToggleIconButton> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
      },
      child: Column(
        children: [
          Icon(
            widget.icon,
            color: isActive ? widget.activeColor : widget.inactiveColor,
            size: 30.0,
          ),
          Text(
            widget.label,
          ),
        ],
      ),
    );
  }
}
