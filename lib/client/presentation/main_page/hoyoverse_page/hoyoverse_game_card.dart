import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sga/client/repository/global_repo.dart';
import 'package:sga/server/constant/hoyoverse/request_event.dart';
import 'package:sga/server/data_model/hoyoverse/response/check_response.dart';
import 'package:sga/server/data_model/hoyoverse/response/claim_response.dart';

class HoyoverseGameCard extends StatefulWidget {
  const HoyoverseGameCard({
    super.key,
    required this.imageProvider,
    required this.title,
    required this.requestEvent,
    required this.onClaim,
    required this.onCheck,
  });

  final ImageProvider imageProvider;
  final String title;
  final RequestEvent requestEvent;
  final Future<ClaimResponse> Function(RequestEvent) onClaim;
  final Future<CheckResponse> Function(RequestEvent) onCheck;

  @override
  State<HoyoverseGameCard> createState() => HoyoverseGameCardState();
}

class HoyoverseGameCardState extends State<HoyoverseGameCard> {
  bool claimStatus = true;

  @override
  void initState() {
    super.initState();
    widget.onCheck(widget.requestEvent).then((value) {
      if (!context.mounted) return;
      setState(() {
        claimStatus = value.data?.isSign ?? true;
      });
    }).onError((e, s) {
      log('${widget.title} Error: $e', error: e, stackTrace: s);
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalRepo = GlobalRepository.of(context);
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image(
              image: widget.imageProvider,
              width: 400,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, left: 4),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Positioned.directional(
            textDirection: TextDirection.ltr,
            end: 4,
            bottom: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                  ),
                  onPressed: !claimStatus
                      ? () async {
                          try {
                            final response = await widget.onClaim(widget.requestEvent);
                            if (!context.mounted) return;
                            globalRepo.showSnackBar(
                              Text(
                                response.message,
                                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                              ),
                              color: Colors.green,
                            );
                            final checkResponse = await widget.onCheck(widget.requestEvent);
                            if (!context.mounted) return;
                            setState(() {
                              claimStatus = checkResponse.data?.isSign ?? true;
                            });
                          } catch (e) {
                            globalRepo.showSnackBar(
                              Text(
                                e.toString(),
                                style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                              ),
                              color: Colors.red,
                            );
                          }
                        }
                      : null,
                  child: const Text('Claim'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
