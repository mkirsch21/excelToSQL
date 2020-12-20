from PyQt5 import QtGui
from PyQt5.QtWidgets import QApplication, QDialog, QComboBox, QVBoxLayout, QLabel, QLineEdit, QPushButton, QMessageBox
from PyQt5.QtCore import pyqtSlot
import sys
import os

class Window(QDialog):
    def __init__(self):
        super().__init__()

        self.title = "SQL Insert Helper"
        self.top = 400
        self.left = 1000
        self.width = 600
        self.height = 200


        self.InitWindow()


    def InitWindow(self):
        self.setWindowIcon(QtGui.QIcon("icon.png"))
        self.setWindowTitle(self.title)
        self.setGeometry(self.left, self.top, self.width, self.height)

        vbox = QVBoxLayout()

        self.comboFA = QComboBox()
        self.comboFA.addItem("EI")
        self.comboFA.addItem("TA")
        self.comboFA.addItem("EC")
        self.comboFA.addItem("TP")
        self.comboFA.addItem("CH")

        self.comboScript = QComboBox()
        self.comboScript.addItem("Single Insert")
        self.comboScript.addItem("Full Insert")
        self.comboScript.addItem("Single Update")
        self.comboScript.addItem("Full Update")

        self.comboFA.currentTextChanged.connect(self.comboChanged)
        self.comboScript.currentTextChanged.connect(self.comboChanged)

        self.label = QLabel()
        self.label.setStyleSheet('color:red')
        self.label.move(20,110)

        vbox.addWidget(self.comboFA)
        vbox.addWidget(self.comboScript)
        vbox.addWidget(self.label)

        # Create textbox
        self.textbox = QLineEdit(self)
        self.textbox.move(20, 80)
        self.textbox.resize(500,20)
        self.textbox.setPlaceholderText("Output Script Name") 
        
        # Create a button in the window
        self.button = QPushButton('Submit', self)
        self.button.move(20,140)
        
        # connect button to function on_click
        self.button.clicked.connect(self.on_click)

        self.setLayout(vbox)

        self.show()

    def comboChanged(self):
        text1 = self.comboFA.currentText()
        text2 = self.comboScript.currentText()
        self.label.setText("You Have Selected : " + text1 + ' and ' + text2)
    
    @pyqtSlot()
    def on_click(self):
        textboxValue = self.textbox.text()
        functionalArea = self.comboFA.currentText()
        scriptType = self.comboScript.currentText()
        QMessageBox.question(self, 'Submitted', "Submitted: " + textboxValue, QMessageBox.Ok, QMessageBox.Ok)
        self.textbox.setText("")

        if scriptType == 'Full Insert':
            if functionalArea == 'EI':
                os.system('python3 fullWorkbookInsert.py {} {}'.format(functionalArea, textboxValue))
            else:
                pass
        else:
            pass
        



App = QApplication(sys.argv)
window = Window()
sys.exit(App.exec())