import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../design_system/theme/app_tokens_extension.dart';
import '../../design_system/components/secondary_button.dart';
import '../../design_system/components/primary_button.dart';
import '../../design_system/components/badge.dart';
import 'package:go_router/go_router.dart';

class TakePhotosPage extends StatefulWidget {
  const TakePhotosPage({super.key});

  @override
  State<TakePhotosPage> createState() => _TakePhotosPageState();
}

class _TakePhotosPageState extends State<TakePhotosPage> {
  CameraController? _controller;
  Future<void>? _initFuture;
  int _pageCount = 0;
  bool _hasCover = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final List<CameraDescription> cams = await availableCameras();
      if (cams.isEmpty) {
        _initFuture = Future.value();
        if (mounted) setState(() {});
        return;
      }
      final CameraDescription cam =
          cams.firstWhere((c) => c.lensDirection == CameraLensDirection.back, orElse: () => cams.first);
      _controller = CameraController(cam, ResolutionPreset.high, enableAudio: false);
      _initFuture = _controller!.initialize();
      if (mounted) setState(() {});
    } catch (_) {
      _initFuture = Future.value();
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.tokens;
    return Scaffold(
      backgroundColor: t.bgCanvas,
      body: Stack(
        children: <Widget>[
          // Camera preview goes under everything and reaches the status bar area
          Positioned.fill(
            child: FutureBuilder<void>(
              future: _initFuture,
              builder: (BuildContext context, AsyncSnapshot<void> snap) {
                if (_controller == null || snap.connectionState != ConnectionState.done) {
                  return Container(
                    color: t.bgSurface,
                    alignment: Alignment.center,
                    child: Icon(Icons.camera_alt_rounded,
                        size: 48, color: t.semantics.colors['iconBrand'] ?? t.brand),
                  );
                }
                return LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    final Size? pv = _controller!.value.previewSize;
                    if (pv == null) {
                      return SizedBox.expand(child: CameraPreview(_controller!));
                    }
                    // In portrait, the preview dimensions are swapped.
                    final double previewW = pv.height;
                    final double previewH = pv.width;
                    return ClipRect(
                      child: OverflowBox(
                        alignment: Alignment.center,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SizedBox(
                            width: previewW,
                            height: previewH,
                            child: CameraPreview(_controller!),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Top full-width badge over the camera
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(t.spacingMd, t.spacingSm, t.spacingMd, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  BrandBadge(text: _hasCover ? 'Página ${_pageCount}' : 'Capa da Prova'),
                ],
              ),
            ),
          ),
          // no bottom bar here; moved to Scaffold.bottomNavigationBar
        ],
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          color: t.bgCanvas,
          padding: EdgeInsets.all(t.spacingMd),
          child: Row(
            children: <Widget>[
              Expanded(
                child: SecondaryButton(
                  label: _hasCover ? 'Finalizar' : 'Não Possui',
                  onPressed: () {
                    if (_hasCover) {
                      context.goNamed('page_processing_status', extra: <String, dynamic>{'totalPhotos': _pageCount});
                    }
                  },
                ),
              ),
              SizedBox(width: t.spacingMd),
              Expanded(
                child: PrimaryButton(
                  label: '',
                  onPressed: () {
                    setState(() {
                      _pageCount += 1;
                      _hasCover = true;
                    });
                  },
                  child: Image.asset(
                    'assets/images/icon-camera.png',
                    width: 28,
                    height: 28,
                    color: t.textInvertedStrong,
                    errorBuilder: (_, __, ___) => const Icon(Icons.camera_alt_rounded),
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


