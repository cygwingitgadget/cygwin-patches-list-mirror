From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: cinstall/Makefile.in and configure.
Date: Wed, 07 Feb 2001 15:56:00 -0000
Message-id: <3A81E0C9.65A57BA9@yahoo.com>
X-SW-Source: 2001-q1/msg00056.html

 
2001-02-07  Earnie Boyd  <earnie@users.sourceforge.net>

	* Makefile.in: (%.o: %.rc): Specify --include-dir $(w32api_include).
	* configure: regenerate.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/Makefile.in,v
retrieving revision 2.10
diff -u -3 -p -r2.10 Makefile.in
--- Makefile.in	2000/12/26 23:19:41	2.10
+++ Makefile.in	2001/02/07 23:50:13
@@ -159,10 +159,10 @@ version.c : $(srcdir)/ChangeLog Makefile
 
 %.o: %.rc
 ifdef VERBOSE
-	$(WINDRES) --include-dir $(srcdir) -o $@ $<
+	$(WINDRES) --include-dir $(srcdir) --include-dir $(w32api_include) -o $@ $<
 else
 	@echo $(WINDRES) -o $@ $(<F)
-	@$(WINDRES) --include-dir $(srcdir) -o $@ $<
+	@$(WINDRES) --include-dir $(srcdir) --include-dir $(w32api_include) -o $@ $<
 endif
 
 %.o: %.c
Index: configure
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/configure,v
retrieving revision 2.1
diff -u -3 -p -r2.1 configure
--- configure	2000/12/11 00:07:56	2.1
+++ configure	2001/02/07 23:51:01
@@ -28,7 +28,6 @@ program_suffix=NONE
 program_transform_name=s,x,x,
 silent=
 site=
-sitefile=
 srcdir=
 target=NONE
 verbose=
@@ -143,7 +142,6 @@ Configuration:
   --help                  print this message
   --no-create             do not create output files
   --quiet, --silent       do not print \`checking...' messages
-  --site-file=FILE        use FILE as the site file
   --version               print the version of autoconf that created configure
 Directory and file names:
   --prefix=PREFIX         install architecture-independent files in PREFIX
@@ -314,11 +312,6 @@ EOF
   -site=* | --site=* | --sit=*)
     site="$ac_optarg" ;;
 
-  -site-file | --site-file | --site-fil | --site-fi | --site-f)
-    ac_prev=sitefile ;;
-  -site-file=* | --site-file=* | --site-fil=* | --site-fi=* | --site-f=*)
-    sitefile="$ac_optarg" ;;
-
   -srcdir | --srcdir | --srcdi | --srcd | --src | --sr)
     ac_prev=srcdir ;;
   -srcdir=* | --srcdir=* | --srcdi=* | --srcd=* | --src=* | --sr=*)
@@ -484,16 +477,12 @@ fi
 srcdir=`echo "${srcdir}" | sed 's%\([^/]\)/*$%\1%'`
 
 # Prefer explicitly selected file to automatically selected ones.
-if test -z "$sitefile"; then
-  if test -z "$CONFIG_SITE"; then
-    if test "x$prefix" != xNONE; then
-      CONFIG_SITE="$prefix/share/config.site $prefix/etc/config.site"
-    else
-      CONFIG_SITE="$ac_default_prefix/share/config.site $ac_default_prefix/etc/config.site"
-    fi
+if test -z "$CONFIG_SITE"; then
+  if test "x$prefix" != xNONE; then
+    CONFIG_SITE="$prefix/share/config.site $prefix/etc/config.site"
+  else
+    CONFIG_SITE="$ac_default_prefix/share/config.site $ac_default_prefix/etc/config.site"
   fi
-else
-  CONFIG_SITE="$sitefile"
 fi
 for ac_site_file in $CONFIG_SITE; do
   if test -r "$ac_site_file"; then
@@ -585,7 +574,7 @@ else { echo "configure: error: can not r
 fi
 
 echo $ac_n "checking host system type""... $ac_c" 1>&6
-echo "configure:589: checking host system type" >&5
+echo "configure:578: checking host system type" >&5
 
 host_alias=$host
 case "$host_alias" in
@@ -606,7 +595,7 @@ host_os=`echo $host | sed 's/^\([^-]*\)-
 echo "$ac_t""$host" 1>&6
 
 echo $ac_n "checking target system type""... $ac_c" 1>&6
-echo "configure:610: checking target system type" >&5
+echo "configure:599: checking target system type" >&5
 
 target_alias=$target
 case "$target_alias" in
@@ -624,7 +613,7 @@ target_os=`echo $target | sed 's/^\([^-]
 echo "$ac_t""$target" 1>&6
 
 echo $ac_n "checking build system type""... $ac_c" 1>&6
-echo "configure:628: checking build system type" >&5
+echo "configure:617: checking build system type" >&5
 
 build_alias=$build
 case "$build_alias" in
@@ -650,7 +639,7 @@ test "$host_alias" != "$target_alias" &&
 # Extract the first word of "gcc", so it can be a program name with args.
 set dummy gcc; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:654: checking for $ac_word" >&5
+echo "configure:643: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_CC'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -680,7 +669,7 @@ if test -z "$CC"; then
   # Extract the first word of "cc", so it can be a program name with args.
 set dummy cc; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:684: checking for $ac_word" >&5
+echo "configure:673: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_CC'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -729,7 +718,7 @@ fi
 fi
 
 echo $ac_n "checking whether we are using GNU C""... $ac_c" 1>&6
-echo "configure:733: checking whether we are using GNU C" >&5
+echo "configure:722: checking whether we are using GNU C" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_gcc'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -738,7 +727,7 @@ else
   yes;
 #endif
 EOF
-if { ac_try='${CC-cc} -E conftest.c'; { (eval echo configure:742: \"$ac_try\") 1>&5; (eval $ac_try) 2>&5; }; } | egrep yes >/dev/null 2>&1; then
+if { ac_try='${CC-cc} -E conftest.c'; { (eval echo configure:731: \"$ac_try\") 1>&5; (eval $ac_try) 2>&5; }; } | egrep yes >/dev/null 2>&1; then
   ac_cv_prog_gcc=yes
 else
   ac_cv_prog_gcc=no
@@ -753,7 +742,7 @@ if test $ac_cv_prog_gcc = yes; then
   ac_save_CFLAGS="$CFLAGS"
   CFLAGS=
   echo $ac_n "checking whether ${CC-cc} accepts -g""... $ac_c" 1>&6
-echo "configure:757: checking whether ${CC-cc} accepts -g" >&5
+echo "configure:746: checking whether ${CC-cc} accepts -g" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_cc_g'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -789,7 +778,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}g++", so it can be a program name with args.
 set dummy ${ac_tool_prefix}g++; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:793: checking for $ac_word" >&5
+echo "configure:782: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_CXX'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -821,7 +810,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "g++", so it can be a program name with args.
 set dummy g++; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:825: checking for $ac_word" >&5
+echo "configure:814: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_CXX'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -857,7 +846,7 @@ if test -z "$CXX"; then
   # Extract the first word of "c++", so it can be a program name with args.
 set dummy c++; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:861: checking for $ac_word" >&5
+echo "configure:850: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_CXX'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -886,7 +875,7 @@ fi
   test -z "$CC" && { echo "configure: error: no acceptable cc found in \$PATH" 1>&2; exit 1; }
 fi
 
-CXXFLAGS="$(CFLAGS)"
+CXXFLAGS='$(CFLAGS)'
 
 
 if test "$program_transform_name" = s,x,x,; then
@@ -932,7 +921,7 @@ fi
 # SVR4 /usr/ucb/install, which tries to use the nonexistent group "staff"
 # ./install, which can be erroneously created by make from ./install.sh.
 echo $ac_n "checking for a BSD compatible install""... $ac_c" 1>&6
-echo "configure:936: checking for a BSD compatible install" >&5
+echo "configure:925: checking for a BSD compatible install" >&5
 if test -z "$INSTALL"; then
 if eval "test \"`echo '$''{'ac_cv_path_install'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
@@ -986,12 +975,12 @@ test -z "$INSTALL_DATA" && INSTALL_DATA=
 
 
 echo $ac_n "checking for Cygwin environment""... $ac_c" 1>&6
-echo "configure:990: checking for Cygwin environment" >&5
+echo "configure:979: checking for Cygwin environment" >&5
 if eval "test \"`echo '$''{'ac_cv_cygwin'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
   cat > conftest.$ac_ext <<EOF
-#line 995 "configure"
+#line 984 "configure"
 #include "confdefs.h"
 
 int main() {
@@ -1002,7 +991,7 @@ int main() {
 return __CYGWIN__;
 ; return 0; }
 EOF
-if { (eval echo configure:1006: \"$ac_compile\") 1>&5; (eval $ac_compile) 2>&5; }; then
+if { (eval echo configure:995: \"$ac_compile\") 1>&5; (eval $ac_compile) 2>&5; }; then
   rm -rf conftest*
   ac_cv_cygwin=yes
 else
@@ -1019,19 +1008,19 @@ echo "$ac_t""$ac_cv_cygwin" 1>&6
 CYGWIN=
 test "$ac_cv_cygwin" = yes && CYGWIN=yes
 echo $ac_n "checking for mingw32 environment""... $ac_c" 1>&6
-echo "configure:1023: checking for mingw32 environment" >&5
+echo "configure:1012: checking for mingw32 environment" >&5
 if eval "test \"`echo '$''{'ac_cv_mingw32'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
   cat > conftest.$ac_ext <<EOF
-#line 1028 "configure"
+#line 1017 "configure"
 #include "confdefs.h"
 
 int main() {
 return __MINGW32__;
 ; return 0; }
 EOF
-if { (eval echo configure:1035: \"$ac_compile\") 1>&5; (eval $ac_compile) 2>&5; }; then
+if { (eval echo configure:1024: \"$ac_compile\") 1>&5; (eval $ac_compile) 2>&5; }; then
   rm -rf conftest*
   ac_cv_mingw32=yes
 else
@@ -1050,7 +1039,7 @@ test "$ac_cv_mingw32" = yes && MINGW32=y
 
 
 echo $ac_n "checking for executable suffix""... $ac_c" 1>&6
-echo "configure:1054: checking for executable suffix" >&5
+echo "configure:1043: checking for executable suffix" >&5
 if eval "test \"`echo '$''{'ac_cv_exeext'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1060,10 +1049,10 @@ else
   rm -f conftest*
   echo 'int main () { return 0; }' > conftest.$ac_ext
   ac_cv_exeext=
-  if { (eval echo configure:1064: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; }; then
+  if { (eval echo configure:1053: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; }; then
     for file in conftest.*; do
       case $file in
-      *.c | *.o | *.obj | *.ilk | *.pdb) ;;
+      *.c | *.o | *.obj) ;;
       *) ac_cv_exeext=`echo $file | sed -e s/conftest//` ;;
       esac
     done
@@ -1084,7 +1073,7 @@ ac_exeext=$EXEEXT
 # Extract the first word of "${ac_tool_prefix}ar", so it can be a program name with args.
 set dummy ${ac_tool_prefix}ar; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1088: checking for $ac_word" >&5
+echo "configure:1077: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_AR'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1116,7 +1105,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "ar", so it can be a program name with args.
 set dummy ar; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1120: checking for $ac_word" >&5
+echo "configure:1109: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_AR'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1152,7 +1141,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}as", so it can be a program name with args.
 set dummy ${ac_tool_prefix}as; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1156: checking for $ac_word" >&5
+echo "configure:1145: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_AS'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1184,7 +1173,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "as", so it can be a program name with args.
 set dummy as; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1188: checking for $ac_word" >&5
+echo "configure:1177: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_AS'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1220,7 +1209,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}ranlib", so it can be a program name with args.
 set dummy ${ac_tool_prefix}ranlib; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1224: checking for $ac_word" >&5
+echo "configure:1213: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_RANLIB'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1252,7 +1241,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "ranlib", so it can be a program name with args.
 set dummy ranlib; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1256: checking for $ac_word" >&5
+echo "configure:1245: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_RANLIB'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1288,7 +1277,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}ld", so it can be a program name with args.
 set dummy ${ac_tool_prefix}ld; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1292: checking for $ac_word" >&5
+echo "configure:1281: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_LD'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1320,7 +1309,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "ld", so it can be a program name with args.
 set dummy ld; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1324: checking for $ac_word" >&5
+echo "configure:1313: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_LD'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1356,7 +1345,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}dlltool", so it can be a program name with args.
 set dummy ${ac_tool_prefix}dlltool; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1360: checking for $ac_word" >&5
+echo "configure:1349: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_DLLTOOL'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1388,7 +1377,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "dlltool", so it can be a program name with args.
 set dummy dlltool; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1392: checking for $ac_word" >&5
+echo "configure:1381: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_DLLTOOL'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1424,7 +1413,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}windres", so it can be a program name with args.
 set dummy ${ac_tool_prefix}windres; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1428: checking for $ac_word" >&5
+echo "configure:1417: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_WINDRES'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1456,7 +1445,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "windres", so it can be a program name with args.
 set dummy windres; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1460: checking for $ac_word" >&5
+echo "configure:1449: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_WINDRES'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1492,7 +1481,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}objcopy", so it can be a program name with args.
 set dummy ${ac_tool_prefix}objcopy; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1496: checking for $ac_word" >&5
+echo "configure:1485: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_OBJCOPY'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1524,7 +1513,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "objcopy", so it can be a program name with args.
 set dummy objcopy; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1528: checking for $ac_word" >&5
+echo "configure:1517: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_OBJCOPY'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
