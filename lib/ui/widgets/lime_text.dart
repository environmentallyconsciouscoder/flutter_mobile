import 'package:flutter/material.dart';

import 'package:limetrack/ui/common/app_colors.dart';
import 'package:limetrack/ui/common/app_styles.dart';

class LimeText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign alignment;

  LimeText.headline(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = headlineStyle.copyWith(color: color),
        alignment = align;

  LimeText.headingOne(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = heading1Style.copyWith(color: color),
        alignment = align;

  LimeText.headingTwo(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = heading2Style.copyWith(color: color),
        alignment = align;

  LimeText.headingThree(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = heading3Style.copyWith(color: color),
        alignment = align;

  LimeText.headingFour(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = heading4Style.copyWith(color: color),
        alignment = align;

  LimeText.headingFive(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = heading5Style.copyWith(color: color),
        alignment = align;

  LimeText.headingSix(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = heading6Style.copyWith(color: color),
        alignment = align;

  LimeText.subheading(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = subheadingStyle.copyWith(color: color),
        alignment = align;

  LimeText.body(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = bodyStyle.copyWith(color: color),
        alignment = align;

  LimeText.bodyBold(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = bodyBoldStyle.copyWith(color: color),
        alignment = align;

  LimeText.smallBold(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = smallBoldStyle.copyWith(color: color),
        alignment = align;

  LimeText.small(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = smallStyle.copyWith(color: color),
        alignment = align;

  LimeText.captionBold(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = captionBoldStyle.copyWith(color: color),
        alignment = align;

  LimeText.caption(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = captionStyle.copyWith(color: color),
        alignment = align;

  LimeText.dashboardHeader(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.center})
      : style = dashboardHeaderStyle.copyWith(color: color),
        alignment = align;

  LimeText.dashboardBody(this.text, {super.key, Color color = kcPrimaryDarkerColor, TextAlign align = TextAlign.center})
      : style = dashboardItemStyle.copyWith(color: color),
        alignment = align;

  LimeText.dashboardFooter(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.center})
      : style = dashboardKeyStyle.copyWith(color: color),
        alignment = align;

  LimeText.analyticsWarning(this.text, {super.key, Color color = kcRedColor, TextAlign align = TextAlign.start})
      : style = analyticsWarningStyle.copyWith(color: color),
        alignment = align;

  LimeText.analyticsFilter(this.text, {super.key, Color color = kcSecondaryLighterColor, TextAlign align = TextAlign.right})
      : style = analyticsFilterStyle.copyWith(color: color),
        alignment = align;

  LimeText.analyticsFilterType(this.text, {super.key, Color color = kcSecondaryDarkerColor, TextAlign align = TextAlign.center})
      : style = analyticsFilterTypeStyle.copyWith(color: color),
        alignment = align;

  LimeText.analyticsChartTip(this.text, {super.key, Color color = kcSecondaryLighterColor, TextAlign align = TextAlign.left})
      : style = analyticsChartTipStyle.copyWith(color: color),
        alignment = align;

  LimeText.analyticsChartTitle(this.text, {super.key, Color color = kcSecondaryUltraDarkColor, TextAlign align = TextAlign.left})
      : style = analyticsChartTitleStyle.copyWith(color: color),
        alignment = align;

  LimeText.analyticsChartLabel(this.text, {super.key, Color color = kcSecondaryLighterColor, TextAlign align = TextAlign.left})
      : style = analyticsChartLabelStyle.copyWith(color: color),
        alignment = align;

  LimeText.dialogButton(this.text, {super.key, Color color = kcSecondaryColor, TextAlign align = TextAlign.start})
      : style = dialogButtonStyle.copyWith(color: color),
        alignment = align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }
}
