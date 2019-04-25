import 'package:flutter/material.dart';
import '../constants.dart' show AppColors, AppStyles, Constants;
import '../modal/conversation.dart' show Conversation, mockConversation;

class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return _ConversationItem(
          conversation: mockConversation[index],
        );
      },
      itemCount: mockConversation.length,
    );
  }
}

// 每个列表项的控件
class _ConversationItem extends StatelessWidget {
  const _ConversationItem({Key key, this.conversation})
      : assert(conversation != null),
      super(key: key);

  final Conversation conversation;

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    // 根据图片获取方式
    if (conversation.isAvatarFromNet()) {
      avatar = Image.network(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,
      );
    } else {
      avatar = Image.asset(
        conversation.avatar,
        width: Constants.ConversationAvatarSize,
        height: Constants.ConversationAvatarSize,);
    }

    Widget avatarContainer;

    if (conversation.unreadMsgCount > 0) {
      // 未读消息角标 控件
      Widget unReadMsgCountText = Container(
        width: Constants.UnReadMsgNotifyDotSize,
        height: Constants.UnReadMsgNotifyDotSize,
        // 布局
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // 圆角
          borderRadius: BorderRadius.circular(Constants.UnReadMsgNotifyDotSize / 2.0),
          color: Color(AppColors.NofityDotBg),
        ),
        child: Text(conversation.unreadMsgCount.toString(), style: AppStyles.UnReadMsgCountDotStyle,),
      );

      // 头像组合控件
      avatarContainer = Stack(
        // 超出Stack控件部分显示效果
        overflow: Overflow.visible,
        children: <Widget>[
          avatar,
          Positioned(
            right: -6.0,
            top: -6.0,
            child: unReadMsgCountText,
          ),
        ],
      );
    } else {
      avatarContainer = avatar;
    }


    return Container(
      padding: const EdgeInsets.all(10.0),
      // 增加分割线
      decoration: BoxDecoration(
          color: Color(AppColors.ConversationItemBg),
        border: Border(
          bottom: BorderSide(
            color: Color(AppColors.DividerColor),
            width: Constants.DividerWidth,
          ),
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          avatarContainer,

          // 增加间隔 1.使用padding 2.增加一个container
          Container(width: 10.0,),

          // 可扩展控件，先让其他控件占位  然后自己在填充
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  conversation.title,
                  style: AppStyles.TitleStyle,
                ),
                Text(
                  conversation.des,
                  style: AppStyles.DesStyle,
                ),
              ],
            ),
          ),
          Container(width: 10.0,),

          Column(
            children: <Widget>[
              Text(conversation.updateAt, style: AppStyles.DesStyle,),
            ],
          ),
        ],
      ),
    );
  }
}
