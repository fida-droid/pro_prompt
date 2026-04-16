import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../models/prompt.dart';
import '../providers/prompt_provider.dart';
import '../services/ad_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PromptCard extends StatelessWidget {
  final Prompt prompt;

  const PromptCard({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final provider = Provider.of<PromptProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: prompt.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[300]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        prompt.title,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        prompt.isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: prompt.isFavorite ? Colors.red : null,
                      ),
                      onPressed: () => provider.toggleFavorite(prompt.id),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  prompt.text,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(prompt.category),
                      backgroundColor: Colors.blue.withOpacity(0.1),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: prompt.text));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.copied)),
                        );
                        AdService().showInterstitialAd();
                      },
                      icon: const Icon(Icons.copy),
                      label: Text(l10n.copy),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.1, end: 0),
    );
  }
}
