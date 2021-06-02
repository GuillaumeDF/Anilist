import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:data/data_repository.dart';
import 'package:ani_list/logic/cubit/cubit.dart';
import 'package:ani_list/constants/constants.dart';

import 'user_infos.dart';

class ReviewsView extends StatefulWidget {
  ReviewsView({Key key}) : super(key: key);

  @override
  _ReviewsViewState createState() => _ReviewsViewState();
}

class _ReviewsViewState extends State<ReviewsView> {
  final int _maxLines = 200;

  Widget _getReviewContent(String content) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        content.length > _maxLines
            ? content.substring(0, _maxLines) + '...'
            : content,
        style:
            Theme.of(context).textTheme.subtitle2.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildReviewCard(Review review) {
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(reviewDetailsRoute, arguments: review),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomLeft,
              end: FractionalOffset.topRight,
              colors: <Color>[Colors.blueGrey, Colors.blue],
            ),
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(color: Colors.white, offset: Offset(1.0, 1.0))
            ]),
        child: Center(
          child: Column(
            children: [
              UserInfos(review.reviewer),
              Divider(),
              _getReviewContent(review.content),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReview(Review review) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        _buildReviewCard(review),
      ],
    );
  }

  Widget _getReviews(List<Review> reviews) {
    return Column(
      children: [
        _buildReview(reviews[0]),
        _buildReview(reviews[1]),
        _buildReview(reviews[2]),
        _buildReview(reviews[3]),
        _buildReview(reviews[4]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnimeInfosCubit, AnimeInfosState>(
      builder: (context, state) {
        if (state is AnimeInfosLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is AnimeInfosError) {
          return Center(child: Text("Top failed"));
        } else if (state is AnimeInfosReviewsSuccess) {
          return _getReviews(state.reviews);
        }
        return Container();
      },
    );
  }
}
