import { CenterTitle} from '@satis/center-title'
import { MessageReq, MessageRespData } from '../../dto/MessageResp';
import MessageListViewModel from '../../ViewModel/MessageListViewModel';

@Builder
function MsgItem(item:MessageRespData,type:'0'|'1'|'2'){
  if (type==='0'){
    // 赞·踩
    Row({space:'40lpx'}){
      Row(){
        Image(item.targetUserAvatar).width('90lpx').height('90lpx').borderRadius('45lpx').margin({top:'40lpx'})
      }.alignItems(VerticalAlign.Top)
      Column({space:'20lpx'}){
        Row({space:'20lpx'}){
          Text(`${item.targetNickname}`).fontColor('#4c6184').fontSize('40lpx').fontWeight(600)
          Text(`${item.msgItemTypeDesc}`).fontSize('40lpx').fontWeight(600)
        }.width('100%')
        .justifyContent(FlexAlign.Start)

        Row({space:'20lpx'}){
          Flex({alignItems:ItemAlign.Stretch}) {
             Row().width('5lpx')
               .backgroundColor('#e6e6e6').borderRadius('1lpx').margin({right:'20lpx'})
            Text(`${item.content}`)
              .fontSize('30lpx')
              .fontColor('#555555')
              .maxLines(3)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({right:'40lpx'})
          }
          // .border({width:{left:3},color:'#e5e5e6'})

        }.width('100%')
        .justifyContent(FlexAlign.Start)

        Row(){
          Text(`${item.msgTime}`).fontSize('25lpx').fontColor('##b2b2b4')
        }.width('100%')
        .justifyContent(FlexAlign.Start)

      }.layoutWeight(1)
      .padding({ top:'40lpx', bottom:'40lpx' })
      .border({ width:{bottom:1}, color:'#e9e9e9' })

    }.width('100%')
    .alignItems(VerticalAlign.Top)
    .padding({ left:'40lpx' })

  } else if (type==='1'){

    // 评论
    Row({space:'40lpx'}){
      Row(){
        Image(item.targetUserAvatar).width('90lpx').height('90lpx').borderRadius('45lpx').margin({top:'40lpx'})
      }.alignItems(VerticalAlign.Top)
      Column({space:'20lpx'}){
        Row({space:'20lpx'}){
          Text(`${item.targetNickname}`).fontColor('#4c6184').fontSize('40lpx').fontWeight(600)
          Text(`${item.msgItemTypeDesc}`).fontSize('40lpx').fontWeight(600)
        }.width('100%')
        .justifyContent(FlexAlign.Start)

        Row({space:'20lpx'}){
          Flex({alignItems:ItemAlign.Stretch}) {
            Row().width('5lpx')
              .backgroundColor('#e6e6e6').borderRadius('1lpx').margin({right:'20lpx'})
            Text(`${item.content}`)
              .fontSize('30lpx')
              .fontColor('#555555')
              .maxLines(3)
              .textOverflow({ overflow: TextOverflow.Ellipsis })
              .margin({right:'40lpx'})
          }
          // .border({width:{left:3},color:'#e5e5e6'})

        }.width('100%')
        .justifyContent(FlexAlign.Start)

        Row(){
          Text(`${item.msgTime}`).fontSize('25lpx').fontColor('##b2b2b4')
        }.width('100%')
        .justifyContent(FlexAlign.Start)

      }.layoutWeight(1)
      .padding({ top:'40lpx', bottom:'40lpx' })
      .border({ width:{bottom:1}, color:'#e9e9e9' })

    }.width('100%')
    .alignItems(VerticalAlign.Top)
    .padding({ left:'40lpx' })


  }else {



  }

}

@Component
export struct Like {
  @Consume navPathStack: NavPathStack;

  @State messageListViewModel:MessageListViewModel = new MessageListViewModel();
  @State msgType:'0'|'1'|'2' = '0'


  @Builder
  title(){
  Text("赞 · 踩").fontSize('60lpx').fontColor(Color.Black)
    .fontWeight(700)
    .maxLines(1)
    .textOverflow({overflow:TextOverflow.Ellipsis})
    .ellipsisMode(EllipsisMode.END)
  }



  build() {
    NavDestination(){
      if (this.messageListViewModel.loading){
        LoadingProgress()
      }else{
        List() {
          ForEach(this.messageListViewModel.data,(item:MessageRespData)=>{
            ListItem(){
              MsgItem(item,this.msgType)
            }
          })
        }
        .backgroundColor('#f8f8f8')
        .align(Alignment.Top)
        .width('100%')
        .height('100%')
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP,SafeAreaEdge.BOTTOM])
      }


    }
    .width('100%')
    .height('100%')
    .title(CenterTitle(this.title))
    .hideToolBar(true)
    .onWillShow(()=>{
      let param:MessageReq = this.navPathStack.getParamByName('MsgLike')[0] as MessageReq
      console.log(param+'-------------')
      this.msgType = param.type

      this.messageListViewModel.getMessageListData(param)
    })
  }


}

@Builder
export function MsgLikeBuilder(){
  Like()
}


