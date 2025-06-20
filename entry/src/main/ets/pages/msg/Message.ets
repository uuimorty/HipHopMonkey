import { LengthMetrics } from "@kit.ArkUI";
import { MessageReq } from "../../dto/MessageResp";

@Builder
function TopMessage(){
  Row(){
    Text('消息').fontSize('60lpx')
    SymbolGlyph($r('sys.symbol.magnifyingglass'))
      .fontSize('60lpx')
  }.width("100%").height('60lpx')
  .justifyContent(FlexAlign.SpaceBetween)
}


@Builder
function TopIcon(navPathStack: NavPathStack){
  Row(){
    Column(){
      Row(){
        SymbolGlyph($r('sys.symbol.bell_fill')).fontColor([Color.White])
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
        .width('100lpx')
        .height('100lpx')
        .borderRadius('10lpx')
        .backgroundColor('#58bc89')
      Text('赞·踩')
    }.width('100lpx')
    .onClick(()=>{
      navPathStack.pushPath({name:'MsgLike',param:new MessageReq("1","0")})
    })

    Column(){
      Row(){
        SymbolGlyph($r('sys.symbol.ellipsis_message')).fontColor([Color.White])
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
        .width('100lpx')
        .height('100lpx')
        .borderRadius('10lpx')
        .backgroundColor('#e16148')
      Text('评论')
    }.width('100lpx')

    Column(){
      Row(){
        SymbolGlyph($r('sys.symbol.book_open_fill')).fontColor([Color.White])
      }
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
        .width('100lpx')
        .height('100lpx')
        .borderRadius('10lpx')
        .backgroundColor('#3478f5')
      Text('关注')
    }.width('100lpx')


  }.width("100%").height('160lpx')
  .justifyContent(FlexAlign.SpaceEvenly)
}

@Component
export struct Message {
  @Consume navPathStack: NavPathStack;

  private scrollerForScroll: Scroller = new Scroller();



  build() {
    NavDestination(){

      Scroll(this.scrollerForScroll) {
        Column() {
          Column({ space: '80lpx' }) {
            TopMessage()
            TopIcon(this.navPathStack)
          }.width('100%')
          .height('400lpx')
          .backgroundColor(Color.White)
          .padding({left:'40lpx',right:'40lpx'})
          .margin({bottom:'40lpx'})


          Column(){
            SymbolGlyph($r('sys.symbol.doc'))
              .fontSize('120lpx')
              .fontColor(['#bbbbbb'])
            Text('没有找到相关数据')
          }
          .justifyContent(FlexAlign.Center)
          .layoutWeight(1)
          .width('100%')
          .backgroundColor(Color.White)
        }
      }
      .backgroundColor('#f8f8f8')
      .align(Alignment.Top)
      .width('100%')
      .height('100%')
      .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])


    }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideBackButton(true)
    .hideToolBar(true)
  }
}

@Builder
export function MessageBuilder(){
  Message()
}