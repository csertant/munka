import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';

import '../themes/dimensions.dart';

abstract class CustomIcons {
  static const _basePath = 'assets/icons';
  static const _basePathLetters = '$_basePath/letters';

  static const appIconLight = '$_basePath/icon.png';
  static const appIconDark = '$_basePath/icon_white.png';

  static const stats = '$_basePath/stats.svg';
  static const control = '$_basePath/control.svg';
  static const settings = '$_basePath/settings.svg';

  static const add = '$_basePath/add.svg';
  static const edit = '$_basePath/edit.svg';
  static const delete = '$_basePath/delete.svg';

  static const play = '$_basePath/play.svg';
  static const pause = '$_basePath/pause.svg';
  static const stop = '$_basePath/stop.svg';

  static const user = '$_basePath/user.svg';
  static const userAdd = '$_basePath/user_add.svg';
  static const userDelete = '$_basePath/user_delete.svg';

  static const a = '$_basePathLetters/a.svg';
  static const b = '$_basePathLetters/b.svg';
  static const c = '$_basePathLetters/c.svg';
  static const d = '$_basePathLetters/d.svg';
  static const e = '$_basePathLetters/e.svg';
  static const f = '$_basePathLetters/f.svg';
  static const g = '$_basePathLetters/g.svg';
  static const h = '$_basePathLetters/h.svg';
  static const i = '$_basePathLetters/i.svg';
  static const j = '$_basePathLetters/j.svg';
  static const k = '$_basePathLetters/k.svg';
  static const l = '$_basePathLetters/l.svg';
  static const m = '$_basePathLetters/m.svg';
  static const n = '$_basePathLetters/n.svg';
  static const o = '$_basePathLetters/o.svg';
  static const p = '$_basePathLetters/p.svg';
  static const q = '$_basePathLetters/q.svg';
  static const r = '$_basePathLetters/r.svg';
  static const s = '$_basePathLetters/s.svg';
  static const t = '$_basePathLetters/t.svg';
  static const u = '$_basePathLetters/u.svg';
  static const v = '$_basePathLetters/v.svg';
  static const w = '$_basePathLetters/w.svg';
  static const x = '$_basePathLetters/x.svg';
  static const y = '$_basePathLetters/y.svg';
  static const z = '$_basePathLetters/z.svg';

  static const Map<String, String> _letterIcons = {
    'a': a,
    'b': b,
    'c': c,
    'd': d,
    'e': e,
    'f': f,
    'g': g,
    'h': h,
    'i': i,
    'j': j,
    'k': k,
    'l': l,
    'm': m,
    'n': n,
    'o': o,
    'p': p,
    'q': q,
    'r': r,
    's': s,
    't': t,
    'u': u,
    'v': v,
    'w': w,
    'x': x,
    'y': y,
    'z': z,
    'á': a,
    'ä': a,
    'é': e,
    'í': i,
    'ó': o,
    'ö': o,
    'ő': o,
    'ú': u,
    'ü': u,
    'ű': u,
  };

  static String fromName(String name) {
    final trimmed = name.trim();
    if (trimmed.isEmpty) {
      return user;
    }
    final firstChar = trimmed.characters.first.toLowerCase();
    return _letterIcons[firstChar] ?? user;
  }
}

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    super.key,
    required this.iconPath,
    this.size,
    this.color,
    this.padding,
  });

  final String iconPath;
  final double? size;
  final Color? color;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = this.size ?? AppDimensions.of(context).iconSizeDefault;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SvgPicture.asset(
        iconPath,
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(
          color ?? theme.colorScheme.outline,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
