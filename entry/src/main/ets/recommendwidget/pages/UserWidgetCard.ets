const userLocal = new LocalStorage()
@Entry(userLocal)
@Component
struct UserWidgetCard {

  readonly displayPriorityOne = 1;
  readonly displayPriorityTwo = 2;
  readonly flexGrowValue = 1;
  readonly fullPercent = '100%';
  readonly imageHeight = '58%';
  readonly actionType = 'router';
  readonly abilityName = 'EntryAbility';
  readonly message = 'add detail111';
  readonly layoutWeightValue = 1;
  readonly maxLinesValue = 1;

  @LocalStorageProp('userTitle') userTitle:string='';
  @LocalStorageProp('userContent') userContent:string='';

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Stack({ alignContent: Alignment.BottomStart }) {
        Image($r('app.media.ic_widget'))
          .width(this.fullPercent)
          .height(this.fullPercent)

        Column() {
          Text(this.userTitle)
            .fontSize($r('app.float.card_title_font_size'))
            .width(this.fullPercent)
            .fontColor($r('sys.color.font'))
            .fontWeight(FontWeight.Medium)
        }
        .padding($r('app.float.maximum_padding'))
        .alignItems(HorizontalAlign.Start)
      }
      .width(this.fullPercent)
      .height(this.fullPercent)
      .displayPriority(this.displayPriorityOne)
      .flexGrow(this.flexGrowValue)

      Flex({ direction: FlexDirection.Column }) {
        Flex({ direction: FlexDirection.Row }) {
          Column() {
            Image($r('app.media.ic_widget'))
              .width(this.fullPercent)
              .height(this.imageHeight)
              .borderRadius($r('app.float.image_border_radius'))
              .margin({ bottom: $r('app.float.image_margin_bottom') })
              .flexGrow(this.flexGrowValue)

            Column() {
              Text(this.userTitle)
                .fontSize($r('app.float.card_title_font_size'))
                .width(this.fullPercent)
                .fontColor($r('sys.color.font'))
                .fontWeight(FontWeight.Medium)
                .maxLines(this.maxLinesValue)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
              Text(this.userContent)
                .fontSize($r('app.float.item_font_size'))
                .width(this.fullPercent)
                .fontColor($r('sys.color.font'))
                .fontWeight(FontWeight.Regular)
                .margin({ top: $r('app.float.item_margin_top') })
                .maxLines(this.maxLinesValue)
                .textOverflow({ overflow: TextOverflow.Ellipsis })
            }
            .justifyContent(FlexAlign.Center)
            .layoutWeight(this.layoutWeightValue)
            .flexGrow(this.flexGrowValue)
          }
          .width($r('app.float.info_column_width'))
          .height(this.fullPercent)
          .flexGrow(this.flexGrowValue)
        }
        .backgroundColor($r('sys.color.comp_background_primary'))
        .displayPriority(this.displayPriorityTwo)
        .flexGrow(this.flexGrowValue)
        .height($r('app.float.info_column_height'))
        .padding($r('app.float.info_column_padding'))
      }
    }
    .onClick(() => {
      postCardAction(this, {
        action: this.actionType,
        abilityName: this.abilityName,
        params: {
          targetIndex: 3
        }
      });
    })
  }
}