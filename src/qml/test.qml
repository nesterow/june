import QtQuick 2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts 1.2
import org.julialang 1.0

ApplicationWindow {
  title: "My Application"
  width: 800
  height: 600
  visible: true

  ColumnLayout {
    id: root
    spacing: 6
    anchors.fill: parent

    function do_plot()
    {
      if(jdisp === null)
        return;

      Julia.plotsin(jdisp, amplitude.value, frequency.value);
    }

    function init_and_plot()
    {

      Julia.init_backend(jdisp.width, jdisp.height, "GR");
      do_plot();
    }

    RowLayout {
      Layout.fillWidth: true
      Layout.alignment: parent.AlignCenter

      Text {
        text: "Amplitude:"
      }

      Slider {
        id: amplitude
        width: 100
        value: 1.0
        stepSize: 0.1
        minimumValue: 0.1
        maximumValue: 5.0
        onValueChanged: root.do_plot()
      }

      Text {
        text: "Frequency:"
      }

      Slider {
        id: frequency
        width: 100
        value: 1.0
        stepSize: 0.1
        minimumValue: 1.0
        maximumValue: 50.0
        onValueChanged: root.do_plot()
      }

    }

    JuliaDisplay {
      id: jdisp
      Layout.fillWidth: true
      Layout.fillHeight: true
      onHeightChanged: root.init_and_plot()
      onWidthChanged: root.init_and_plot()
    }
  }
}
