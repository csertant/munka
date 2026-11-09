import 'package:flutter_svg/svg.dart';
import 'package:material_ui/material_ui.dart';

import '../themes/dimensions.dart';

abstract class CustomIcons {
  static const String stats = 'assets/icons/stats.svg';
  static const String control = 'assets/icons/control.svg';
  static const String settings = 'assets/icons/settings.svg';

  static const String add = 'assets/icons/add.svg';
  static const String edit = 'assets/icons/edit.svg';
  static const String delete = 'assets/icons/delete.svg';

  static const String play = 'assets/icons/play.svg';
  static const String pause = 'assets/icons/pause.svg';
  static const String stop = 'assets/icons/stop.svg';

  static const String user = 'assets/icons/user.svg';
  static const String userAdd = 'assets/icons/user_add.svg';
  static const String userDelete = 'assets/icons/user_delete.svg';

  static const String a = 'assets/icons/letters/a.svg';
  static const String b = 'assets/icons/letters/b.svg';
  static const String c = 'assets/icons/letters/c.svg';
  static const String d = 'assets/icons/letters/d.svg';
  static const String e = 'assets/icons/letters/e.svg';
  static const String f = 'assets/icons/letters/f.svg';
  static const String g = 'assets/icons/letters/g.svg';
  static const String h = 'assets/icons/letters/h.svg';
  static const String i = 'assets/icons/letters/i.svg';
  static const String j = 'assets/icons/letters/j.svg';
  static const String k = 'assets/icons/letters/k.svg';
  static const String l = 'assets/icons/letters/l.svg';
  static const String m = 'assets/icons/letters/m.svg';
  static const String n = 'assets/icons/letters/n.svg';
  static const String o = 'assets/icons/letters/o.svg';
  static const String p = 'assets/icons/letters/p.svg';
  static const String q = 'assets/icons/letters/q.svg';
  static const String r = 'assets/icons/letters/r.svg';
  static const String s = 'assets/icons/letters/s.svg';
  static const String t = 'assets/icons/letters/t.svg';
  static const String u = 'assets/icons/letters/u.svg';
  static const String v = 'assets/icons/letters/v.svg';
  static const String w = 'assets/icons/letters/w.svg';
  static const String x = 'assets/icons/letters/x.svg';
  static const String y = 'assets/icons/letters/y.svg';
  static const String z = 'assets/icons/letters/z.svg';

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
