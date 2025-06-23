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

        Row(){
          Text(item.extraContent).fontSize('30lpx')
        }.width('100%').padding({right:'40lpx'}).justifyContent(FlexAlign.Start)

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
    // 关注
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
  }

}

@Component
export struct Like {
  @Consume navPathStack: NavPathStack;

  @State messageListViewModel:MessageListViewModel = new MessageListViewModel();
  // @State msgType:'0'|'1'|'2' = '0'
  @State param:MessageReq=new MessageReq('1','0');

  @State refreshing: boolean = false;
  @State titleText:string = '赞 · 踩'

  async onRefresh() {
    this.refreshing = false
    // 重新加载数据
    this.param.page='1'
    await this.messageListViewModel.getMessageListData(this.param,true)
    this.refreshing = this.messageListViewModel.loading
  }


  @Builder
  title(titleT:string){
  Text(titleT).fontSize('60lpx').fontColor(Color.Black)
    .fontWeight(700)
    .maxLines(1)
    .textOverflow({overflow:TextOverflow.Ellipsis})
    .ellipsisMode(EllipsisMode.END)
    .width('50%')
    .height('100%')
    .textAlign(TextAlign.Center)
    .position({left:'50%'})
    .translate({ x: '-50%' })
  }



  build() {
    NavDestination(){
      Refresh({ refreshing: $$this.refreshing }) {
        if (this.messageListViewModel.loading) {
          LoadingProgress().width('200lpx')
        } else {
          List() {
            ForEach(this.messageListViewModel.data, (item: MessageRespData) => {
              ListItem() {
                MsgItem(item, this.param.type)
              }
            })
          }
          .backgroundColor('#f8f8f8')
          .scrollBar(BarState.Off)
          .align(Alignment.Top)
          .width('100%')
          .height('100%')
          .onScrollIndex((start, end, center) => {
            if (center === this.messageListViewModel.data.length - 5) {
              console.log('current index', center + '-' + this.messageListViewModel.data.length)
              let nextPage =parseInt(this.param.page)+1
              this.param=new MessageReq(''+nextPage,'0')
              this.messageListViewModel.getMessageListData(this.param)
            }
          })
          .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        }
      }
      .onRefreshing(() => {
        this.onRefresh()
      })


    }
    .width('100%')
    .height('100%')
    .title(CenterTitle(this.title(this.titleText)))
    .hideToolBar(true)
    .onWillShow(()=>{
      let param:MessageReq = this.navPathStack.getParamByName('MsgLike')[0] as MessageReq
      console.log('param-------------',JSON.stringify(param,null,2))
      // this.msgType = param.type
      this.param = param
      if (param.type === '0') {
        console.log('赞 · 踩')
        this.titleText = '赞 · 踩'
      }else if(param.type ==='1'){
        console.log('评论')
        this.titleText = '评论'
      }else{
        console.log('关注')
        this.titleText = '关注'
      }

      this.messageListViewModel.getMessageListData(param)
    })
  }


}

@Builder
export function MsgLikeBuilder(){
  Like()
}


