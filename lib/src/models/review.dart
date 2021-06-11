import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReviewProduct {
  String comment;
  double rating;

  ReviewProduct({
    this.comment,
    this.rating,
  });

  ReviewProduct.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    rating = documentSnapshot['rating'];
    comment = documentSnapshot['comment'];
  }

  toJson() {
    return {
     "comment":comment,
      "rating": rating,
    };
  }
}