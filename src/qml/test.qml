import QtQuick 2.7
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.11
import org.julialang 1.0

ApplicationWindow {
  title: "My Application"
  width: 800
  height: 600
  visible: true
  id: window

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
      Layout.alignment: Qt.AlignCenter

      Text {
        text: "Amplitude:"
      }

      Slider {
        id: amplitude
        width: 100
        height: 50
        value: 2
        from: 1
        to: 100
        onValueChanged: root.do_plot()
      }

      Text {
        text: "Frequency:"
      }

      Slider {
        id: frequency
        width: 100
        height: 50
        value: 1
        from: 1
        to: 100
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
