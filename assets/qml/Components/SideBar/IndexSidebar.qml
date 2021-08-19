import QtQuick 2.7
import QtQuick.Controls 2.7

Rectangle{
    id:control

    property int currentItem: 0 //当前选中item
    property int spacing: 10    //项之间距离
    property int indent: 5      //子项缩进距离,注意实际还有icon的距离
    property string onSrc: "qrc:/images/on.png"
    property string offSrc: "qrc:/images/off.png"

    property var checkedArray: [] //当前已勾选的items
    property bool autoExpand: false

    property var groups: []
    property var graphs: [[],[],[],[],[]]

    //背景
    color: Qt.rgba(2/255,19/255,23/255,128/255)
    property alias model: list_view.model
    ListView{
        id: list_view
        anchors.fill: parent
        anchors.margins: 0
        //通过+1来给每个item一个唯一的index
        //可以配合root的currentItem来做高亮
        property int itemCount: 0
        //model: //model由外部设置，通过解析json
        delegate: list_delegate
        clip: true
    }
    Component{
        id:list_delegate
        Row{
            id:list_itemgroup
            spacing: 0

            //canvas 画项之间的连接线
            Canvas{
                id:list_canvas
                width: item_titleicon.width+10
                height: list_itemcol.height
                //开了反走样，线会模糊看起来加粗了
                antialiasing: false
                //最后一项的连接线没有尾巴
                property bool isLastItem: (index==parent.ListView.view.count-1)
                onPaint: {
                    var ctx = getContext("2d")
                    var i=0
                    //ctx.setLineDash([4,2]); 遇到个大问题，不能画虚线
                    // setup the stroke
                    ctx.strokeStyle = Qt.rgba(201/255,202/255,202/255,1)
                    ctx.lineWidth=1
                    // create a path
                    ctx.beginPath()
                    //用短线段来实现虚线效果，判断里-3是防止width(4)超过判断长度
                    //此外还有5的偏移是因为我image是透明背景的，为了不污染到图标
                    //这里我是虚线长4，间隔2，加起来就是6一次循环
                    //效果勉强
                    ctx.moveTo(width/2,0) //如果第一个item虚线是从左侧拉过来，要改很多
                    for(i=0;i<list_itemrow.height/2-5-3;i+=6){
                        ctx.lineTo(width/2,i+4);
                        ctx.moveTo(width/2,i+6);
                    }

                    ctx.moveTo(width/2+5,list_itemrow.height/2)
                    for(i=width/2+5;i<width-3;i+=6){
                        ctx.lineTo(i+4,list_itemrow.height/2);
                        ctx.moveTo(i+6,list_itemrow.height/2);
                    }

                    if(!isLastItem){
                        ctx.moveTo(width/2,list_itemrow.height/2+5)
                        for(i=list_itemrow.height/2+5;i<height-3;i+=6){
                            ctx.lineTo(width/2,i+4);
                            ctx.moveTo(width/2,i+6);
                        }
                        //ctx.lineTo(10,height)
                    }
                    // stroke path
                    ctx.stroke()
                }

                //项图标框--可以是ractangle或者image
                Image {
                    id:item_titleicon
                    visible: false
                    //如果是centerIn的话展开之后就跑到中间去了
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.leftMargin: list_canvas.width/2-width/2
                    anchors.topMargin: list_itemrow.height/2-width/2
                    //根据是否有子项/是否展开加载不同的图片/颜色
                    //color: item_repeater.count
                    //      ?item_sub.visible?"white":"gray"
                    //:"black"
                    //这里没子项或者子项未展开未off，展开了为on
                    source: item_repeater.count?item_sub.visible?offSrc:onSrc:offSrc

                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            if(item_repeater.count)
                                item_sub.visible=!item_sub.visible;
                        }
                    }
                }
            }

            //项内容：包含一行item和子项的listview
            Column{
                id:list_itemcol

                //这一项的内容，这里只加了一个text
                Row {
                    id:list_itemrow
                    width: control.width
                    height: item_text.contentHeight+control.spacing
                    anchors.margins: 0
                    spacing: 5

                    property int itemIndex;

                    Rectangle{
                        height: item_text.contentHeight+control.spacing
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                        color: (currentItem===list_itemrow.itemIndex)
                               ?Qt.rgba(101/255,255/255,255/255,38/255)
                               :"transparent"
                        Text {
                            id:item_text
                            anchors.left: parent.left
                            width: 30
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.text
                            font.pixelSize: 14
                            font.family: "Microsoft YaHei UI"
                            color: Qt.rgba(101/255,1,1,1)
                        }
                        Switch {
                            id: sw
                            width: 45
                            height: 20
                            anchors.fill: parent
                            palette.highlight: "#d72d60"
                            Component.onCompleted: checked = true
                            onCheckedChanged: {
                                if (list_itemrow.itemIndex>=0 && list_itemrow.itemIndex< 3){
                                    graphs[0][list_itemrow.itemIndex] = checked
                                    if (graphGenerator.itemAt(0) !== null){
                                        graphGenerator.itemAt(0).children[0].isgrapharr[list_itemrow.itemIndex].visible=checked
                                        subgraph[0].isgrapharr[list_itemrow.itemIndex].visible=checked
                                    }
                                }
                                if (list_itemrow.itemIndex==3)
                                {
                                    groups[0] = checked
                                    if(checked){
                                        check(0)
                                    }else{
                                        uncheck(0)
                                    }
                                }
                                //
                                if (list_itemrow.itemIndex>=4 && list_itemrow.itemIndex< 33){
                                    graphs[1][list_itemrow.itemIndex-4] = checked
                                    if (graphGenerator.itemAt(1) !== null){
                                        graphGenerator.itemAt(1).children[0].isgrapharr[list_itemrow.itemIndex-4].visible=checked
                                        subgraph[1].isgrapharr[list_itemrow.itemIndex-4].visible=checked
                                    }

                                }
                                if (list_itemrow.itemIndex==33){
                                    groups[1] = checked
                                    if(checked){
                                        check(1)
                                    }else{
                                        uncheck(1)
                                    }
                                }
                                //
                                if (list_itemrow.itemIndex>=34 && list_itemrow.itemIndex< 63){
                                    graphs[2][list_itemrow.itemIndex-34] = checked
                                    if (graphGenerator.itemAt(2) !== null){
                                        graphGenerator.itemAt(2).children[0].isgrapharr[list_itemrow.itemIndex-34].visible=checked
                                        subgraph[2].isgrapharr[list_itemrow.itemIndex-34].visible=checked
                                    }
                                }
                                if (list_itemrow.itemIndex==63){
                                    groups[2] = checked
                                    if(checked){
                                        check(2)
                                    }else{
                                        uncheck(2)
                                    }
                                }
                            }
                        }
                    }

                    Component.onCompleted: {
                        list_itemrow.itemIndex=list_view.itemCount;
                        list_view.itemCount+=1;

                        if(modelData.istitle)
                            item_titleicon.visible=true;
                    }
                }

                //放子项
                Column{
                    id:item_sub
                    visible: control.autoExpand
                    //上级左侧距离=小图标宽+x偏移
                    x:indent
                    Item {
                        width: 10
                        height: item_repeater.contentHeight
                        //需要加个item来撑开，如果用Repeator获取不到count
                        ListView{
                            id:item_repeater
                            anchors.fill: parent
                            anchors.margins: 0
                            delegate: list_delegate
                            model:modelData.subnodes
                        }
                    }
                }

            }
        }
        //end list_itemgroup
    }
    //end list_delegate

    function check(index){
        if (graphGenerator.itemAt(index) !== null){
            graphGenerator.itemAt(index).children[0].visible = true
        }
    }

    function uncheck(index){
        graphGenerator.itemAt(index).children[0].visible = false
    }

    Component.onCompleted: {
        setTestDataA()
        graphGenerator.model = list_view.count
        graphGenerator.itemAt(0).children[0].title="室内温度"
        graphGenerator.itemAt(1).children[0].title="区域功率"
        graphGenerator.itemAt(2).children[0].title="表面温度"
    }
    function setTestDataA(){
        list_view.model=JSON.parse('[
        {
            "text":"室内温度",
            "istitle":true,
            "subnodes":[
                {"text":"环境温度 1","istitle":true},
                {"text":"环境温度 2","istitle":true},
                {"text":"平均环境温度","istitle":true}
            ]
        },
        {
            "text":"区域功率",
            "istitle":true,
            "subnodes":[
                {"text":"右上臂前","istitle":true},
                {"text":"右上臂后","istitle":true},
                {"text":"左上臂前","istitle":true},
                {"text":"左上臂后","istitle":true},
                {"text":"右前臂前","istitle":true},
                {"text":"右前臂后","istitle":true},
                {"text":"左前臂前","istitle":true},
                {"text":"左前臂后","istitle":true},
                {"text":"胸上部","istitle":true},
                {"text":"肩背部","istitle":true},
                {"text":"腹部","istitle":true},
                {"text":"背中部","istitle":true},
                {"text":"腰腹部","istitle":true},
                {"text":"背下部","istitle":true},
                {"text":"右大腿前","istitle":true},
                {"text":"右大腿后","istitle":true},
                {"text":"左大腿前","istitle":true},
                {"text":"左大腿后","istitle":true},
                {"text":"右小腹前","istitle":true},
                {"text":"右臀","istitle":true},
                {"text":"左小腹前","istitle":true},
                {"text":"左臀","istitle":true},
                {"text":"右小腿前","istitle":true},
                {"text":"右小腿后","istitle":true},
                {"text":"左小腿前","istitle":true},
                {"text":"左小腿后","istitle":true},
                {"text":"左脚","istitle":true},
                {"text":"右脚","istitle":true},
                {"text":"头部","istitle":true}
            ]
        },
        {
            "text":"表面温度",
            "istitle":true,
            "subnodes":[
                {"text":"右上臂前","istitle":true},
                {"text":"右上臂后","istitle":true},
                {"text":"左上臂前","istitle":true},
                {"text":"左上臂后","istitle":true},
                {"text":"右前臂前","istitle":true},
                {"text":"右前臂后","istitle":true},
                {"text":"左前臂前","istitle":true},
                {"text":"左前臂后","istitle":true},
                {"text":"胸上部","istitle":true},
                {"text":"肩背部","istitle":true},
                {"text":"腹部","istitle":true},
                {"text":"背中部","istitle":true},
                {"text":"腰腹部","istitle":true},
                {"text":"背下部","istitle":true},
                {"text":"右大腿前","istitle":true},
                {"text":"右大腿后","istitle":true},
                {"text":"左大腿前","istitle":true},
                {"text":"左大腿后","istitle":true},
                {"text":"右小腹前","istitle":true},
                {"text":"右臀","istitle":true},
                {"text":"左小腹前","istitle":true},
                {"text":"左臀","istitle":true},
                {"text":"右小腿前","istitle":true},
                {"text":"右小腿后","istitle":true},
                {"text":"左小腿前","istitle":true},
                {"text":"左小腿后","istitle":true},
                {"text":"左脚","istitle":true},
                {"text":"右脚","istitle":true},
                {"text":"头部","istitle":true}
            ]
        }
    ]')
    }
}
