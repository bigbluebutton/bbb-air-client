### Use Flash Builder to develop it.

* clone this repo
* Install Flex Formatter plugin to your Flash Builder http://sourceforge.net/projects/flexformatter/
* open Flash Builder
* Switch Workspace to the parent directory of your cloned repo
* File-New-Flex Mobile Project
* type "bbb-air-client"
* Use default SDK (Flex 4.6.0)
* Next, then Finish

### Add extra arguments to Flex Compiler:

* right-click on bbb-air-client project
* Properties-Flex Compiler
* add the following as Additional compiler arguments:

```
-locale=en_US,pt_BR -source-path=./locale/{locale} -resource-bundle-list=used-resource-bundles.txt -allow-source-path-overlap=true
```

### Develoment
Everytime you change the localization files (and when you first compile the client), run *build-locale.bat* to compile the localization resources.

By default, when you run the app in debug mode, you will join the *Demo Meeting* on http://test-install.blindsidenetworks.com/, but only if you open the session first in your browser. The app will never call *create*, it only knows how to handle *join*.

### Code Quality
Flex Formatter plugin is configured against Adobe Flex Coding Standards. Make sure you use it offten.
