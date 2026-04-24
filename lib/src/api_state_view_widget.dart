import 'package:flutter/material.dart';

class ApiStateView extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final bool isEmpty;
  final VoidCallback? onRetry;
  final Widget child;

  final Widget? loadingWidget;
  final Widget? errorWidget;
  final Widget? emptyWidget;

  const ApiStateView({
    super.key,
    required this.isLoading,
    required this.error,
    required this.isEmpty,
    required this.child,
    this.onRetry,
    this.loadingWidget,
    this.errorWidget,
    this.emptyWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ?? const Center(child: CircularProgressIndicator());
    }

    if (error != null && error!.trim().isNotEmpty) {
      return errorWidget ??
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(error!, textAlign: TextAlign.center),
                const SizedBox(height: 12),
                if (onRetry != null)
                  ElevatedButton(
                      onPressed: onRetry, child: const Text("Retry")),
              ],
            ),
          );
    }

    if (isEmpty) {
      return emptyWidget ?? const Center(child: Text("No data found"));
    }

    return child;
  }
}
