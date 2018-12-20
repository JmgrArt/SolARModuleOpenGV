TARGET = pnpWithOpenGV
VERSION=1.0.0

CONFIG += c++1z
CONFIG -= qt
CONFIG += console

DEFINES += MYVERSION=$${VERSION}

CONFIG(debug,debug|release) {
    DEFINES += _DEBUG=1
    DEFINES += DEBUG=1
}

CONFIG(release,debug|release) {
    DEFINES += NDEBUG=1
}

win32:CONFIG -= static
win32:CONFIG += shared

DEPENDENCIESCONFIG = sharedlib
#NOTE : CONFIG as staticlib or sharedlib, DEPENDENCIESCONFIG as staticlib or sharedlib MUST BE DEFINED BEFORE templatelibconfig.pri inclusion
include ($$(BCOMDEVROOT)/builddefs/qmake/templateappconfig.pri)

HEADERS += experiment_helpers.hpp \
random_generators.hpp \
time_measurement.hpp

SOURCES += 	experiment_helpers.cpp\
random_generators.cpp \
time_measurement.cpp \
main.cpp

unix {
    LIBS += -ldl 
    QMAKE_CXX = clang++
    QMAKE_LINK = clang++
	
  #  QMAKE_CXXFLAGS += DBOOST_LOG_DYN_LINK 
    
}

macx {
    QMAKE_MAC_SDK= macosx
    QMAKE_CXXFLAGS += -fasm-blocks -x objective-c++
}

win32 {
    QMAKE_LFLAGS += /MACHINE:X64
    DEFINES += WIN64 UNICODE _UNICODE
    QMAKE_COMPILER_DEFINES += _WIN64

    # Windows Kit (msvc2013 64)
    LIBS += -L$$(WINDOWSSDKDIR)lib/winv6.3/um/x64 -lshell32 -lgdi32 -lComdlg32
    INCLUDEPATH += $$(WINDOWSSDKDIR)lib/winv6.3/um/x64

}

