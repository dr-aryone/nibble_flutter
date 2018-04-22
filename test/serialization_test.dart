import 'package:test/test.dart';

import './mock_data.dart';
import '../lib/models/article.dart';
import '../lib/models/nibble.dart';

void main() {
  Article expectedArticle;
  Nibble expectedNibble;

  group('article model', () {
    setUp(() {
      expectedArticle = Article.fromMap(
        article,
      );
    });

    test('should create an article object from json', () {
      Article output = Article(
          source: {"id": "engadget", "name": "Engadget"},
          author: "Nick Summers",
          title:
              "'Resogun' developer teases multiplayer-centric 'Stormdivers' - Engadget",
          description:
              "Only Single Player 'Resogun' developer teases multiplayer-centric 'Stormdivers' Engadget Last November, Finnish game developer Housemarque declared that the arcade genre 'is dead.' The studio's last title, Nex Machina, was warmly received by the press and cur…",
          url:
              "https://www.engadget.com/2018/04/21/housemarque-stormdivers-multiplayer-game-reveal/",
          urlToImage:
              "https://o.aolcdn.com/images/dims?thumbnail=1200%2C630&quality=80&image_uri=https%3A%2F%2Fs.aolcdn.com%2Fhss%2Fstorage%2Fmidas%2Fed9bc19b8643a8a1c08f2cc15360287a%2F206311467%2Fstormdiversfeat.jpg&client=cbc79c14efcebee57402&signature=427a8e83ba571d83c66cd766107b9e29e53659e9",
          publishedAt: "2018-04-21T09:00:26Z");

      expect(output.title, expectedArticle.title);
    });

    test('should create a list of articles', () {
      List<Article> articles = new List();

      articles.add(expectedArticle);
      articles.add(expectedArticle);

      expect(articles.length, 2);
    });

    test('should convert decoded response body to a list of articles', () {
      List<Article> articles = new List();

      var data = {
        "status": "ok",
        "totalResults": 17062,
        "articles": [
          {
            "source": {"id": "engadget", "name": "Engadget"},
            "author": "Nick Summers",
            "title":
                "'Resogun' developer teases multiplayer-centric 'Stormdivers' - Engadget",
            "description":
                "Only Single Player 'Resogun' developer teases multiplayer-centric 'Stormdivers' Engadget Last November, Finnish game developer Housemarque declared that the arcade genre \"is dead.\" The studio's last title, Nex Machina, was warmly received by the press and cur…",
            "url":
                "https://www.engadget.com/2018/04/21/housemarque-stormdivers-multiplayer-game-reveal/",
            "urlToImage":
                "https://o.aolcdn.com/images/dims?thumbnail=1200%2C630&quality=80&image_uri=https%3A%2F%2Fs.aolcdn.com%2Fhss%2Fstorage%2Fmidas%2Fed9bc19b8643a8a1c08f2cc15360287a%2F206311467%2Fstormdiversfeat.jpg&client=cbc79c14efcebee57402&signature=427a8e83ba571d83c66cd766107b9e29e53659e9",
            "publishedAt": "2018-04-21T09:00:26Z"
          },
          {
            "source": {"id": "the-next-web", "name": "The Next Web"},
            "author": "Howard Marks",
            "title": "ICO predictions for 2018: Big changes for utility tokens",
            "description":
                "2017 was quite a banner year for the ICO marketplace with over \$6.4 billion in crypto invested in hundreds of ICOs. Some investors thought the world had gone crazy, others were saying it was just the beginning. Will ICOs announce the end of Venture Capital as…",
            "url": "https://thenextweb.com/?p=1119951",
            "urlToImage":
                "https://cdn0.tnwcdn.com/wp-content/blogs.dir/1/files/2018/04/ICO-predictions-for-2018_-Big-changes-for-utility-tokens-social.png",
            "publishedAt": "2018-04-21T08:30:25Z",
          },
        ]
      };

      List fetchedArticles = data['articles'];

      fetchedArticles
          .forEach((article) => articles.add(Article.fromMap(article)));

      expect(articles[0].author, "Nick Summers");
      expect(articles[1].author, "Howard Marks");
      expect(articles.length, 2);
    });
  });

  group("nibble model", () {
    setUp(() {
      expectedNibble = Nibble.fromMap(
        nibble,
      );
    });

   test('should create a nibble object from json', () {
      Nibble output = Nibble(
        message: "SOURCE IS TOO SHORT, SENTENCE AMOUNT REDUCED TO 3",
        characterCount: "487",
        contentReduced: "32%",
        title: "Apple will shutter its last Watch-exclusive store in May",
        content: "You may want to drop by the pop-up if you're in Japan to see if they still have good deals on offer.[BREAK] According to 9to5mac, the shop held a fire sale on Isetan's website just recently, selling its remaining Apple Watch Edition inventory for as little as \$700. Those 18-karat gold watches sold for at least \$10,000 and as much as \$17,000 when they first became available.[BREAK] It also might be your last chance to see an Apple Store that doesn't quite look like the company's usual spaces.[BREAK]",
        limitation: "Waited 0 extra seconds due to API Free mode, 95 requests left to make for today."
      );

      expect(output.title, expectedNibble.title);
      expect(output.content, expectedNibble.content);
    });

  });
}
