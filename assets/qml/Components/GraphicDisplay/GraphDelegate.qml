import QtQuick 2.12
import QtCharts 2.3

Window {
    id: root
    property int graphId: 0

    spacing: -1
    showIcon: false
    visible: true
    borderColor: root.headerVisible ? "#517497" : "transparent"
    property alias isgrapharr: chartView.grapharr
   // property date curdate: new Date()
   // property date maxdate: getmaxtime()

    ChartView {
        id: chartView
        animationOptions: ChartView.NoAnimation
        theme: ChartView.ChartThemeDark
        antialiasing: true
        anchors.fill: parent
        legend.visible: false
        backgroundRoundness: 0
        enabled: root.enabled
        visible: root.enabled
        backgroundColor: root.backgroundColor
        property var grapharr:[]

        margins {
            top: 0
            bottom: 0
            left: 0
            right: 0
        }

        ValueAxis {
            id: axisX
            min: 0
            max: 1024
            tickCount: 11
            labelsColor: "#ffffff"
            labelsFont.pointSize: 13
            labelsFont.bold: true
            labelFormat: '%d'
        }

        ValueAxis {
            id: axisY
            min:0
            max:50
        }

        Component.onCompleted: {
            for(var n=0;n<30;n++){
                var mySeries = chartView.createSeries(ChartView.SeriesTypeLine, "my line series", axisX,axisY);
                mySeries.useOpenGL=true
                grapharr.push(mySeries)
            }
        }
    }

    Timer {
        id: refreshTimer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (root.title=="室内温度"){

            }
            if (root.title=="区域功率"){

            }
            if (root.title=="表面温度"){
                for(let i = 0 ; i < 30; i++)
                {
                    Cpp_API_Temperature.update(chartView.series(i),i);
                }
            }
            // 更新时间轴
            let currentDate = new Date();
            let offset=root.maxdate-currentDate;
            if(offset<10){ //10ms
               console.log("extend time")
               root.maxdate=extendMaxTime();
//               root.curdate=extendMinTime();//.setSeconds(root.curdate.getSeconds()+2);
               // maxdate.setSeconds(maxdate.getSeconds()+60);
               //chartView.scrollRight(100);
            }
//            spline_right.append(数据的时间,数据)
        }
    }
    function getmaxtime()
    {
        let maxtime=new Date()
        maxtime.setSeconds(maxtime.getSeconds()+10)
        return maxtime
    }

    function extendMaxTime(){
          let maxtime=new Date();
          maxtime.setSeconds(maxtime.getSeconds()+1);
          return maxtime;
    }
    function extendMinTime(){
          let mintime=new Date(curdate.toString());
          mintime.setSeconds(curdate.getSeconds()+1);
          return mintime;
          //curdate.setSeconds(curdate.getSeconds()+2);
     }
}

