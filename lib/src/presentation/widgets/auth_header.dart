import 'package:flutter/material.dart';
import 'package:flutter_architecture/src/presentation/extensions/build_context.dart';
import 'package:flutter_architecture/src/presentation/theme/theme.dart';

class AppAuthHeader extends StatelessWidget {
  final String title;
  final Widget body;

  const AppAuthHeader({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 40),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 40.0),
                            child: SizedBox(
                              height: 64,
                              width: 64,
                              child: Placeholder(),
                            ),
                          ),
                        ),
                        const SizedBox(height: AppTheme.kPaddingLarge),
                        Text(
                          title,
                          style: context.theme.textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppTheme.kPaddingLarge),
                        body,
                        const SizedBox(height: AppTheme.kPaddingLarge),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Wrap(
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text('terms'),
                                ),
                                const SizedBox(width: AppTheme.kPaddingSmall),
                                InkWell(
                                  onTap: () {},
                                  child: Text('privacy'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
