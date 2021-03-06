# Add more folders to ship with the application, here
folder_01.source = qml/WheelUI
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    filereader.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qml/WheelUI/WCircle.qml \
    qml/WheelUI/WInteractiveIcon.qml \
    qml/WheelUI/WDock.qml \
    qml/WheelUI/apps/clock/WClock.qml \
    qml/WheelUI/WIconHome.qml \
    qml/WheelUI/WStatusBar.qml \
    qml/WheelUI/WDesktopBackground.qml \
    qml/WheelUI/WBubbleMessage.qml \
    qml/WheelUI/apps/calc/WCalculator.qml

HEADERS += \
    filereader.h
