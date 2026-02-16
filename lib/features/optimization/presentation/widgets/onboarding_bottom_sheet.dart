import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';

class OnboardingBottomSheet extends StatefulWidget {
  const OnboardingBottomSheet({super.key});

  static Future<void> showIfNeeded(BuildContext context) async {
    final box = await Hive.openBox(AppConstants.settingsBoxName);
    final hasSeenOnboarding = box.get('hasSeenOnboarding', defaultValue: false);
    
    if (!hasSeenOnboarding && context.mounted) {
      await Future.delayed(const Duration(seconds: 2));
      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.black.withValues(alpha: 0.2),
          isDismissible: false,
          enableDrag: false,
          builder: (context) => const OnboardingBottomSheet(),
        );
      }
    }
  }

  @override
  State<OnboardingBottomSheet> createState() => _OnboardingBottomSheetState();
}

enum OnboardingStage { problem, upgrade, result, cta }

class _OnboardingBottomSheetState extends State<OnboardingBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _glowController;
  late AnimationController _pulseController;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  final ScrollController _contentScrollController = ScrollController();

  OnboardingStage _currentStage = OnboardingStage.problem;
  String _problemPromptText = '';
  bool _showProblemTags = false;
  bool _showUpgradeButton = false;
  bool _showResultContent = false;
  String _optimizedPromptText = '';
  bool _showProgressBars = false;
  bool _showProgress1 = false;
  bool _showProgress2 = false;
  bool _showProgress3 = false;
  double _progress24h = 0;
  double _progressPortable = 0;
  double _progressDesign = 0;
  bool _showVideoCards = false;
  bool _showCtaButton = false;

  String get _fullProblemPrompt => AppLocalizations.of(context)!.onboardingProblemPrompt;
  List<String> get _problemTags => [
    AppLocalizations.of(context)!.onboardingProblemTag1,
    AppLocalizations.of(context)!.onboardingProblemTag2,
    AppLocalizations.of(context)!.onboardingProblemTag3,
  ];
  List<String> get _tagDescriptions => [
    AppLocalizations.of(context)!.onboardingProblemTag1Desc,
    AppLocalizations.of(context)!.onboardingProblemTag2Desc,
    AppLocalizations.of(context)!.onboardingProblemTag3Desc,
  ];
  String get _fullOptimizedPrompt => AppLocalizations.of(context)!.onboardingOptimizedPrompt;

  @override
  void initState() {
    super.initState();
    
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _slideAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    ));

    _entranceController.forward();
    _startProblemStage();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollContentToBottom(animated: false);
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _glowController.dispose();
    _pulseController.dispose();
    _contentScrollController.dispose();
    super.dispose();
  }

  void _scrollContentToBottom({required bool animated}) {
    if (!mounted) return;
    if (!_contentScrollController.hasClients) return;

    final target = _contentScrollController.position.maxScrollExtent;
    if (animated) {
      _contentScrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    } else {
      _contentScrollController.jumpTo(target);
    }
  }

  void _scheduleScrollToBottom({bool animated = true}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollContentToBottom(animated: animated);
    });
  }

  void _startProblemStage() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    for (int i = 0; i <= _fullProblemPrompt.length; i++) {
      if (!mounted) return;
      setState(() {
        _problemPromptText = _fullProblemPrompt.substring(0, i);
      });
      final delay = i < 30 ? 50 : 30;
      await Future.delayed(Duration(milliseconds: delay));
    }

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    setState(() {
      _showProblemTags = true;
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _showUpgradeButton = true;
    });
    _scheduleScrollToBottom();

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    _startUpgradeStage();
  }

  void _startUpgradeStage() async {
    setState(() {
      _currentStage = OnboardingStage.upgrade;
    });
  }

  void _onUpgradeButtonClick() async {
    setState(() {
      _showUpgradeButton = false;
    });

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    _startResultStage();
  }

  void _startResultStage() async {
    setState(() {
      _currentStage = OnboardingStage.result;
      _showResultContent = true;
    });

    _scheduleScrollToBottom();

    await Future.delayed(const Duration(milliseconds: 600));
    if (!mounted) return;

    for (int i = 0; i <= _fullOptimizedPrompt.length; i++) {
      if (!mounted) return;
      setState(() {
        _optimizedPromptText = _fullOptimizedPrompt.substring(0, i);
      });
      final delay = i < 50 ? 30 : 20;
      await Future.delayed(Duration(milliseconds: delay));
    }

    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    setState(() {
      _showProgressBars = true;
    });

    _scheduleScrollToBottom();

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    _animateProgressBars();
  }

  void _animateProgressBars() async {
    setState(() {
      _showProgress1 = true;
    });
    _scheduleScrollToBottom();
    await _animateSingleProgress(1, 95);

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    setState(() {
      _showProgress2 = true;
    });
    _scheduleScrollToBottom();
    await _animateSingleProgress(2, 85);

    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    setState(() {
      _showProgress3 = true;
    });
    _scheduleScrollToBottom();
    await _animateSingleProgress(3, 90);
  }

  Future<void> _animateSingleProgress(int index, double targetValue) async {
    const duration = Duration(milliseconds: 600);
    final steps = 30;
    final delay = duration.inMilliseconds ~/ steps;

    for (int i = 0; i <= steps; i++) {
      if (!mounted) return;
      final value = (targetValue * i / steps).clamp(0.0, targetValue).toDouble();
      setState(() {
        if (index == 1) {
          _progress24h = value;
        } else if (index == 2) {
          _progressPortable = value;
        } else if (index == 3) {
          _progressDesign = value;
        }
      });
      await Future.delayed(Duration(milliseconds: delay));
    }

    if (index == 3) {
      await Future.delayed(const Duration(milliseconds: 300));
      if (!mounted) return;
      setState(() {
        _showVideoCards = true;
      });

      _scheduleScrollToBottom();

      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
      _startCtaStage();
    }
  }

  void _startCtaStage() async {
    setState(() {
      _currentStage = OnboardingStage.cta;
      _showCtaButton = true;
    });

    _scheduleScrollToBottom();
  }

  Future<void> _onStartExperience() async {
    final box = await Hive.openBox(AppConstants.settingsBoxName);
    await box.put('hasSeenOnboarding', true);

    if (!mounted) return;

    final exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    final exitSlide = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: exitController,
      curve: Curves.easeInCubic,
    ));

    final exitFade = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: exitController,
      curve: Curves.easeIn,
    ));

    setState(() {
      _slideAnimation = exitSlide;
      _fadeAnimation = exitFade;
    });

    await exitController.forward();
    exitController.dispose();

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, screenHeight * 0.9 * _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: Container(
        height: screenHeight * 0.9,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(9),
            topRight: Radius.circular(9),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(9),
            topRight: Radius.circular(9),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? Colors.white.withValues(alpha: 0.8)
                    : Colors.black.withValues(alpha: 0.5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9),
                  topRight: Radius.circular(9),
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildProgressIndicator(),
                  Expanded(
                    child: SingleChildScrollView(
                      controller: _contentScrollController,
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      child: Column(
                        children: [
                          _buildProblemCard(),
                          if (_showUpgradeButton) ...[
                            const SizedBox(height: 20),
                            _buildUpgradeButton(),
                          ],
                          if (_showResultContent) ...[
                            const SizedBox(height: 20),
                            _buildResultCard(),
                          ],
                        ],
                      ),
                    ),
                  ),
                  if (_showCtaButton) _buildCtaSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    final theme = Theme.of(context);
    final stageIndex = _currentStage.index;
    
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = index <= stageIndex;
          return Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isActive ? 32 : 8,
                height: 4,
                decoration: BoxDecoration(
                  color: isActive
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              if (index < 2) const SizedBox(width: 8),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildProblemCard() {
    final theme = Theme.of(context);
    
    return _AnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline,
                color: theme.colorScheme.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.onboardingProblemTitle,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _problemPromptText,
            style: TextStyle(
              fontSize: 15,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          if (_showProblemTags) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(_problemTags.length, (index) {
                return _ProblemTag(
                  label: _problemTags[index],
                  description: _tagDescriptions[index],
                  delay: index * 200,
                );
              }),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUpgradeButton() {
    final theme = Theme.of(context);
    
    return _AnimatedCard(
      child: Center(
        child: AnimatedBuilder(
          animation: _glowController,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(
                      alpha: 0.3 + (_glowController.value * 0.2),
                    ),
                    blurRadius: 15 + (_glowController.value * 10),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: child,
            );
          },
          child: GestureDetector(
            onTap: _onUpgradeButtonClick,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.primary.withValues(alpha: 0.9),
                  ],
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.auto_fix_high, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    AppLocalizations.of(context)!.onboardingUpgradeButton,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final theme = Theme.of(context);
    
    return _AnimatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.onboardingResultTitle,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _optimizedPromptText,
            style: TextStyle(
              fontSize: 15,
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          if (_showProgressBars) ...[
            const SizedBox(height: 16),
            if (_showProgress1)
              _AnimatedProgressItem(
                label: AppLocalizations.of(context)!.onboardingProgress1,
                value: _progress24h,
                color: Colors.orange,
              ),
            if (_showProgress2) ...[
              const SizedBox(height: 10),
              _AnimatedProgressItem(
                label: AppLocalizations.of(context)!.onboardingProgress2,
                value: _progressPortable,
                color: Colors.blue,
              ),
            ],
            if (_showProgress3) ...[
              const SizedBox(height: 10),
              _AnimatedProgressItem(
                label: AppLocalizations.of(context)!.onboardingProgress3,
                value: _progressDesign,
                color: Colors.purple,
              ),
            ],
          ],
          if (_showProgressBars && _showVideoCards) ...[
            const SizedBox(height: 16),
            _VideoPreviewCard(
              platform: AppLocalizations.of(context)!.onboardingVideoPlatform1,
              text: AppLocalizations.of(context)!.onboardingVideoText1,
              delay: 0,
            ),
            const SizedBox(height: 10),
            _VideoPreviewCard(
              platform: AppLocalizations.of(context)!.onboardingVideoPlatform2,
              text: AppLocalizations.of(context)!.onboardingVideoText2,
              delay: 300,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressItem(String label, double value, Color color) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: value),
              duration: const Duration(milliseconds: 100),
              builder: (context, animValue, child) {
                return Text(
                  '${animValue.toInt()}%',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value / 100,
            backgroundColor: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }

  Widget _buildCtaSection() {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.onboardingCtaUserCount,
            style: TextStyle(
              fontSize: 13,
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 12),
          _PulsingButton(
            onPressed: _onStartExperience,
            pulseController: _pulseController,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _AnimatedCard extends StatefulWidget {
  final Widget child;

  const _AnimatedCard({required this.child});

  @override
  State<_AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<_AnimatedCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<double>(
      begin: 30.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: GlassCard(
        borderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.all(16),
        child: widget.child,
      ),
    );
  }
}

class _ProblemTag extends StatefulWidget {
  final String label;
  final String description;
  final int delay;

  const _ProblemTag({
    required this.label,
    required this.description,
    this.delay = 0,
  });

  @override
  State<_ProblemTag> createState() => _ProblemTagState();
}

class _ProblemTagState extends State<_ProblemTag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: theme.colorScheme.error.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.error.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.error,
              ),
            ),
            Text(
              widget.description,
              style: TextStyle(
                fontSize: 11,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VideoPreviewCard extends StatefulWidget {
  final String platform;
  final String text;
  final int delay;

  const _VideoPreviewCard({
    required this.platform,
    required this.text,
    this.delay = 0,
  });

  @override
  State<_VideoPreviewCard> createState() => _VideoPreviewCardState();
}

class _VideoPreviewCardState extends State<_VideoPreviewCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.primary.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  widget.platform,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PulsingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final AnimationController pulseController;

  const _PulsingButton({
    required this.onPressed,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: pulseController,
      builder: (context, child) {
        final scale = 1.0 + (pulseController.value * 0.05);
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: Container(
        // 核心修改：添加左右16px的外边距
        margin: const EdgeInsets.symmetric(horizontal: 36),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              // 修正语法错误：withValues → withOpacity
              color: const Color(0xFF33cc99).withOpacity(0.4),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF33cc99),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 19),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 0,
            ),
            child: Text(
              AppLocalizations.of(context)!.onboardingCtaButton,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AnimatedProgressItem extends StatefulWidget {
  final String label;
  final double value;
  final Color color;

  const _AnimatedProgressItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  State<_AnimatedProgressItem> createState() => _AnimatedProgressItemState();
}

class _AnimatedProgressItemState extends State<_AnimatedProgressItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _slideAnimation = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: widget.value),
                duration: const Duration(milliseconds: 100),
                builder: (context, animValue, child) {
                  return Text(
                    '${animValue.toInt()}%',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: widget.color,
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: widget.value / 100,
              backgroundColor: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
