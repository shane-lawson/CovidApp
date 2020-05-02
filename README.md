# CovidApp
App for friend's class project.

The goal is to have the app be data driven, so I can effect change to the structure of the app, and how things work; while they can configure the app with the data that should be displayed, and how it is arranged.

The data files consist of a .plist for each view in the app, located in the top level directory. Changing values here, and recompiling the app will update it to data contained in the .plist.

**NOTE:** The data files must be symlinked to individually from the main source file directory on the users system after downloading. Something like 

`ln -s ../../Resources.plist` 

for the data file for the Resources view in the app, and so on. Build errors will occur if this step is skipped.
