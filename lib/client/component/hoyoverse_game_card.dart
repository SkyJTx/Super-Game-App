import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sga/client/component/value_change_notifier.dart';
import 'package:sga/client/repository/global_repo.dart';

class HoyoverseGameCard extends StatefulWidget {
  const HoyoverseGameCard({
    super.key,
    required this.checkNotifier,
    required this.imageProvider,
    required this.title,
    required this.onInit,
    required this.onClaim,
    required this.onCheck,
  });

  final ValueChangeNotifier<bool> checkNotifier;
  final ImageProvider imageProvider;
  final String title;
  final Future<bool> Function() onInit;
  final Future<bool> Function() onClaim;
  final Future<bool> Function() onCheck;

  @override
  State<HoyoverseGameCard> createState() => HoyoverseGameCardState();
}

class HoyoverseGameCardState extends State<HoyoverseGameCard> {
  @override
  void initState() {
    super.initState();
    widget.onInit().then((value) {
      widget.checkNotifier.value = value;
    }).onError((error, stackTrace) {
      if (!context.mounted) return;
      GlobalRepository.of(context).showErrorSnackBar(context, message: error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalRepo = GlobalRepository.of(context);
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
                BlocBuilder<ValueChangeNotifier<bool>, bool>(
                  bloc: widget.checkNotifier,
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.9),
                      ),
                      onPressed: !state
                          ? () async {
                              try {
                                final isSigned = await widget.onCheck();
                                widget.checkNotifier.value = isSigned;
                                if (isSigned) {
                                  if (!context.mounted) return;
                                  globalRepo.showWarningSnackBar(
                                    context,
                                    message: 'Already claimed',
                                  );
                                  return;
                                }

                                final signedSuccess = await widget.onClaim();
                                if (!signedSuccess) return;
                                if (!context.mounted) return;
                                globalRepo.showSuccessSnackBar(
                                  context,
                                  message: 'Claimed successfully',
                                );

                                final check = await widget.onCheck();
                                widget.checkNotifier.value = check;
                              } catch (e) {
                                if (!context.mounted) return;
                                globalRepo.showErrorSnackBar(context, message: e.toString());
                              }
                            }
                          : null,
                      child: const Text('Check-In'),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
