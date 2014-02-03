Use Flash Builder to develop it.

* clone this repo
* open Flash Builder
* Switch Workspace to the parent directory of your cloned repo
* File-New-Flex Mobile Project
* type "bbb-air-client"
* Use default SDK (Flex 4.6.0)
* Next, then Finish

Add extra arguments to Flex Compiler:

* right-click on bbb-air-client project
* Properties-Flex Compiler
* add the following as Additional compiler arguments:

```
-locale=en_US,pt_BR -source-path=./locale/{locale} -resource-bundle-list=used-resource-bundles.txt -allow-source-path-overlap=true
```

Everytime you change the localization files (and when you first compile the client), run *build-locale.bat* to compile the localization resources.