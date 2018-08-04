import wx
import curve_fitting_GUI
import numpy as np
import scipy
from scipy.interpolate import UnivariateSpline

class MyFrame(curve_fitting_GUI.MyFrame):
    def on_button_plot(self, event):
        a = self.text_ctrl_inputdata.GetValue()
        s = float(self.text_ctrl_fairing.GetValue())
        list = a.split('\n')
        if list[-1] == '':
            list.pop(-1)
        arr = [eval(i) for i in list]
        try:
            arr = np.array(arr, dtype=np.float32)
        except ValueError:
            print("The Input Data Structure Is WRONG.")
            return
        x, y = fit(arr, s)
        self.matplotlib_canvas.axes.scatter(arr[:, 0], arr[:, 1], c='k', marker='.', s=20)
        self.matplotlib_canvas.axes.plot(x, y)
        self.matplotlib_canvas.draw()
        event.Skip()

    def on_button_clear(self, event):
        self.matplotlib_canvas.clear()
        event.Skip()

    def on_import_button_clicked(self, event):
        dlg = wx.FileDialog(
            self, message="Choose a file to open",
            defaultFile="",
            wildcard="Csv and Txt files (*.csv;*.txt)|*.csv;*.txt",
            style=wx.FD_OPEN | wx.FD_FILE_MUST_EXIST
        )
        if dlg.ShowModal() == wx.ID_OK:
            tmp=""
            paths = dlg.GetPaths()
            for path in paths:
                tmp=tmp+path
            self.text_ctrl_output.SetValue(tmp)
            file=open(self.text_ctrl_output.GetValue())
            self.text_ctrl_inputdata.SetValue(file.read())
            file.close()
        dlg.Destroy()
        event.Skip()

class MyApp(wx.App):
    def OnInit(self):
        self.frame = MyFrame(None, wx.ID_ANY, "")
        self.SetTopWindow(self.frame)
        self.frame.Show()
        return True

def fit(arr, s):
    x = arr[:, 0]
    y = arr[:, 1]
    if arr.shape[1] == 2:
        pploy = UnivariateSpline(x, y, k=3, s=s)
    elif arr.shape[1] == 3:
        w = arr[:,2]
        pploy = UnivariateSpline(x, y, w, k=3, s=s)
    else:
        raise ValueError("The Input Data Structure Is WRONG.")
    x_point = np.linspace(np.min(x), np.max(x), 100)
    y_point = pploy(x_point)
    return x_point, y_point

if __name__ == "__main__":
    app = MyApp(0)
    app.MainLoop()



