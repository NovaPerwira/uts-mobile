import 'package:flutter/material.dart';

class CampaignModel {
  final String title;
  final String category;
  final double progress;
  final String target;
  final IconData icon;

  CampaignModel({
    required this.title,
    required this.category,
    required this.progress,
    required this.target,
    required this.icon,
  });
}
