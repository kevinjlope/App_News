import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news/core/error/failures.dart';
import 'package:news/features/articles/domain/entities/article.dart';
import 'package:news/features/articles/domain/entities/source.dart';
import 'package:news/features/articles/domain/repositories/articles_repository.dart';
import 'package:news/features/articles/domain/usecases/get_articles_by_country.dart';

class MockArticlesRepository extends Mock implements ArticlesRepository {}

void main() {
  GetArticlesByCountry? usecase;
  MockArticlesRepository? mockArticlesRepository;

  setUp(() {
    mockArticlesRepository = MockArticlesRepository();
    usecase = GetArticlesByCountry(mockArticlesRepository);
  });

  const String tCountry = 'us';
  final Article tArticle = Article(
    source: Source(id: 'source id', name: 'source name'),
    author: 'article author',
    title: 'article title',
    description: 'article description',
    url: 'article url',
    urlToImage: 'article url to image',
    publishedAt: DateTime.now(),
    content: 'article content',
  );

  final List<Article> tArticles = <Article>[tArticle, tArticle];

  test('should get articles by country from the repository', () async {
    //arrange
    when((() => mockArticlesRepository!.getArticlesByCountry(tCountry)))
        .thenAnswer((_) => Future<Either<Failure, List<Article>>>.value(
            Right<Failure, List<Article>>(tArticles))); //<-- Right(tArticles)
    // act
    final Either<Failure, List<Article>> result =
        await usecase!(const Params(country: tCountry));
    // assert
    expect(result, Right<Failure, List<Article>>(tArticles));
    // Verify that the method has been called on the repository
    verify(() => mockArticlesRepository!.getArticlesByCountry(tCountry));
    // Only the above method should be called and nothing more.
    verifyNoMoreInteractions(mockArticlesRepository!);
  });
}
