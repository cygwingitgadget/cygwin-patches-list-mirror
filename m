From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Cc: Mumit Khan <khan@xraylith.wisc.EDU>
Subject: [PATCH] Don't install mingw DLLs when building a cross-compiler
Date: Sat, 17 Jun 2000 10:47:00 -0000
Message-id: <20000617134739.A23807@cygnus.com>
X-SW-Source: 2000-q2/msg00107.html

I'm checking in the following mingw patch.  It avoids the copying of a
DLL to a directory on a (for instance) linux system when building a
cross compiler.

I've also changed the top-level winsup configure to avoid other
nonsensical things when building a cross-compiler, like building
'cinstall' or 'utils'.  The cygwin configure/Makefile.in has suffered
similar surgery to mingw's.

If anyone is relying on executables and DLLs showing up in their
/usr/local/bin (or whereever you install your cross-compilers and
linkers) this patch will cause you some grief.  I think it is
correct behavior, however.

cgf

Sat Jun 17 13:41:50 2000  Christopher Faylor <cgf@cygnus.com>

	* Makefile.in: Avoid installing dll if we're cross building and the
	cross-host system isn't a Windows system.


Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/Makefile.in,v
retrieving revision 1.2
diff -u -p -r1.2 Makefile.in
--- Makefile.in	2000/03/31 04:43:46	1.2
+++ Makefile.in	2000/06/17 17:41:38
@@ -108,9 +108,19 @@ LIBS = libcrtdll.a libmsvcrt.a libmsvcrt
 
 DLLS = $(THREAD_DLL_NAME)
 
-all : $(CRT0S) $(LIBS) $(DLLS)
+all_dlls_host = @all_dlls_host@
+install_dlls_host = @install_dlls_host@
+
+all : $(CRT0S) $(LIBS) $(all_dlls_host)
 	@$(MAKE) subdirs DO=$@ $(FLAGS_TO_PASS)
 
+all_dlls_host: $(DLLS)
+
+install_dlls_host:
+	for i in $(DLLS); do \
+		$(INSTALL_PROGRAM) $$i $(bindir)/$$i ; \
+	done
+
 _libm_dummy.o:
 	rm -f _libm_dummy.c
 	echo "static int __mingw_libm_dummy;" > _libm_dummy.c
@@ -190,11 +200,8 @@ info-html:
 
 install-info: info
 
-install: all
+install: all $(install_dlls_host)
 	$(mkinstalldirs) $(bindir)
-	for i in $(DLLS); do \
-		$(INSTALL_PROGRAM) $$i $(bindir)/$$i ; \
-	done
 	$(mkinstalldirs) $(tooldir)/lib 
 	for i in $(LIBS); do \
 		$(INSTALL_DATA) $$i $(tooldir)/lib/$$i ; \
Index: configure
===================================================================
RCS file: /cvs/src/src/winsup/mingw/configure,v
retrieving revision 1.2
diff -u -p -r1.2 configure
--- configure	2000/04/19 17:11:59	1.2
+++ configure	2000/06/17 17:41:38
@@ -781,10 +781,17 @@ else
 fi
 
 
+case "$with_cross_host" in
+  ""|*cygwin*) all_dlls_host='all_dlls_host'
+	       install_dlls_host='install_dlls_host';;
+esac
+
+
+
 # Extract the first word of "${ac_tool_prefix}ar", so it can be a program name with args.
 set dummy ${ac_tool_prefix}ar; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:788: checking for $ac_word" >&5
+echo "configure:795: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_AR'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -816,7 +823,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "ar", so it can be a program name with args.
 set dummy ar; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:820: checking for $ac_word" >&5
+echo "configure:827: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_AR'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -853,7 +860,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}as", so it can be a program name with args.
 set dummy ${ac_tool_prefix}as; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:857: checking for $ac_word" >&5
+echo "configure:864: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_AS'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -885,7 +892,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "as", so it can be a program name with args.
 set dummy as; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:889: checking for $ac_word" >&5
+echo "configure:896: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_AS'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -921,7 +928,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}ranlib", so it can be a program name with args.
 set dummy ${ac_tool_prefix}ranlib; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:925: checking for $ac_word" >&5
+echo "configure:932: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_RANLIB'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -953,7 +960,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "ranlib", so it can be a program name with args.
 set dummy ranlib; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:957: checking for $ac_word" >&5
+echo "configure:964: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_RANLIB'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -989,7 +996,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}ld", so it can be a program name with args.
 set dummy ${ac_tool_prefix}ld; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:993: checking for $ac_word" >&5
+echo "configure:1000: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_LD'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1021,7 +1028,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "ld", so it can be a program name with args.
 set dummy ld; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1025: checking for $ac_word" >&5
+echo "configure:1032: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_LD'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1057,7 +1064,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}dlltool", so it can be a program name with args.
 set dummy ${ac_tool_prefix}dlltool; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1061: checking for $ac_word" >&5
+echo "configure:1068: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_DLLTOOL'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1089,7 +1096,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "dlltool", so it can be a program name with args.
 set dummy dlltool; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1093: checking for $ac_word" >&5
+echo "configure:1100: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_DLLTOOL'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1125,7 +1132,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}dlltool", so it can be a program name with args.
 set dummy ${ac_tool_prefix}dlltool; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1129: checking for $ac_word" >&5
+echo "configure:1136: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_DLLWRAP'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1157,7 +1164,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "dlltool", so it can be a program name with args.
 set dummy dlltool; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1161: checking for $ac_word" >&5
+echo "configure:1168: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_DLLWRAP'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1193,7 +1200,7 @@ fi
 # Extract the first word of "${ac_tool_prefix}windres", so it can be a program name with args.
 set dummy ${ac_tool_prefix}windres; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1197: checking for $ac_word" >&5
+echo "configure:1204: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_WINDRES'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1225,7 +1232,7 @@ if test -n "$ac_tool_prefix"; then
   # Extract the first word of "windres", so it can be a program name with args.
 set dummy windres; ac_word=$2
 echo $ac_n "checking for $ac_word""... $ac_c" 1>&6
-echo "configure:1229: checking for $ac_word" >&5
+echo "configure:1236: checking for $ac_word" >&5
 if eval "test \"`echo '$''{'ac_cv_prog_WINDRES'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1260,7 +1267,7 @@ fi
 
 
 echo $ac_n "checking how to run the C preprocessor""... $ac_c" 1>&6
-echo "configure:1264: checking how to run the C preprocessor" >&5
+echo "configure:1271: checking how to run the C preprocessor" >&5
 # On Suns, sometimes $CPP names a directory.
 if test -n "$CPP" && test -d "$CPP"; then
   CPP=
@@ -1275,13 +1282,13 @@ else
   # On the NeXT, cc -E runs the code through the compiler's parser,
   # not just through cpp.
   cat > conftest.$ac_ext <<EOF
-#line 1279 "configure"
+#line 1286 "configure"
 #include "confdefs.h"
 #include <assert.h>
 Syntax Error
 EOF
 ac_try="$ac_cpp conftest.$ac_ext >/dev/null 2>conftest.out"
-{ (eval echo configure:1285: \"$ac_try\") 1>&5; (eval $ac_try) 2>&5; }
+{ (eval echo configure:1292: \"$ac_try\") 1>&5; (eval $ac_try) 2>&5; }
 ac_err=`grep -v '^ *+' conftest.out | grep -v "^conftest.${ac_ext}\$"`
 if test -z "$ac_err"; then
   :
@@ -1292,13 +1299,13 @@ else
   rm -rf conftest*
   CPP="${CC-cc} -E -traditional-cpp"
   cat > conftest.$ac_ext <<EOF
-#line 1296 "configure"
+#line 1303 "configure"
 #include "confdefs.h"
 #include <assert.h>
 Syntax Error
 EOF
 ac_try="$ac_cpp conftest.$ac_ext >/dev/null 2>conftest.out"
-{ (eval echo configure:1302: \"$ac_try\") 1>&5; (eval $ac_try) 2>&5; }
+{ (eval echo configure:1309: \"$ac_try\") 1>&5; (eval $ac_try) 2>&5; }
 ac_err=`grep -v '^ *+' conftest.out | grep -v "^conftest.${ac_ext}\$"`
 if test -z "$ac_err"; then
   :
@@ -1309,13 +1316,13 @@ else
   rm -rf conftest*
   CPP="${CC-cc} -nologo -E"
   cat > conftest.$ac_ext <<EOF
-#line 1313 "configure"
+#line 1320 "configure"
 #include "confdefs.h"
 #include <assert.h>
 Syntax Error
 EOF
 ac_try="$ac_cpp conftest.$ac_ext >/dev/null 2>conftest.out"
-{ (eval echo configure:1319: \"$ac_try\") 1>&5; (eval $ac_try) 2>&5; }
+{ (eval echo configure:1326: \"$ac_try\") 1>&5; (eval $ac_try) 2>&5; }
 ac_err=`grep -v '^ *+' conftest.out | grep -v "^conftest.${ac_ext}\$"`
 if test -z "$ac_err"; then
   :
@@ -1342,19 +1349,19 @@ echo "$ac_t""$CPP" 1>&6
 # The Ultrix 4.2 mips builtin alloca declared by alloca.h only works
 # for constant arguments.  Useless!
 echo $ac_n "checking for working alloca.h""... $ac_c" 1>&6
-echo "configure:1346: checking for working alloca.h" >&5
+echo "configure:1353: checking for working alloca.h" >&5
 if eval "test \"`echo '$''{'ac_cv_header_alloca_h'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
   cat > conftest.$ac_ext <<EOF
-#line 1351 "configure"
+#line 1358 "configure"
 #include "confdefs.h"
 #include <alloca.h>
 int main() {
 char *p = alloca(2 * sizeof(int));
 ; return 0; }
 EOF
-if { (eval echo configure:1358: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext}; then
+if { (eval echo configure:1365: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext}; then
   rm -rf conftest*
   ac_cv_header_alloca_h=yes
 else
@@ -1375,12 +1382,12 @@ EOF
 fi
 
 echo $ac_n "checking for alloca""... $ac_c" 1>&6
-echo "configure:1379: checking for alloca" >&5
+echo "configure:1386: checking for alloca" >&5
 if eval "test \"`echo '$''{'ac_cv_func_alloca_works'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
   cat > conftest.$ac_ext <<EOF
-#line 1384 "configure"
+#line 1391 "configure"
 #include "confdefs.h"
 
 #ifdef __GNUC__
@@ -1408,7 +1415,7 @@ int main() {
 char *p = (char *) alloca(1);
 ; return 0; }
 EOF
-if { (eval echo configure:1412: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext}; then
+if { (eval echo configure:1419: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext}; then
   rm -rf conftest*
   ac_cv_func_alloca_works=yes
 else
@@ -1440,12 +1447,12 @@ EOF
 
 
 echo $ac_n "checking whether alloca needs Cray hooks""... $ac_c" 1>&6
-echo "configure:1444: checking whether alloca needs Cray hooks" >&5
+echo "configure:1451: checking whether alloca needs Cray hooks" >&5
 if eval "test \"`echo '$''{'ac_cv_os_cray'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
   cat > conftest.$ac_ext <<EOF
-#line 1449 "configure"
+#line 1456 "configure"
 #include "confdefs.h"
 #if defined(CRAY) && ! defined(CRAY2)
 webecray
@@ -1470,12 +1477,12 @@ echo "$ac_t""$ac_cv_os_cray" 1>&6
 if test $ac_cv_os_cray = yes; then
 for ac_func in _getb67 GETB67 getb67; do
   echo $ac_n "checking for $ac_func""... $ac_c" 1>&6
-echo "configure:1474: checking for $ac_func" >&5
+echo "configure:1481: checking for $ac_func" >&5
 if eval "test \"`echo '$''{'ac_cv_func_$ac_func'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
   cat > conftest.$ac_ext <<EOF
-#line 1479 "configure"
+#line 1486 "configure"
 #include "confdefs.h"
 /* System header to define __stub macros and hopefully few prototypes,
     which can conflict with char $ac_func(); below.  */
@@ -1498,7 +1505,7 @@ $ac_func();
 
 ; return 0; }
 EOF
-if { (eval echo configure:1502: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext}; then
+if { (eval echo configure:1509: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext}; then
   rm -rf conftest*
   eval "ac_cv_func_$ac_func=yes"
 else
@@ -1525,7 +1532,7 @@ done
 fi
 
 echo $ac_n "checking stack direction for C alloca""... $ac_c" 1>&6
-echo "configure:1529: checking stack direction for C alloca" >&5
+echo "configure:1536: checking stack direction for C alloca" >&5
 if eval "test \"`echo '$''{'ac_cv_c_stack_direction'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
 else
@@ -1533,7 +1540,7 @@ else
   ac_cv_c_stack_direction=0
 else
   cat > conftest.$ac_ext <<EOF
-#line 1537 "configure"
+#line 1544 "configure"
 #include "confdefs.h"
 find_stack_direction ()
 {
@@ -1552,7 +1559,7 @@ main ()
   exit (find_stack_direction() < 0);
 }
 EOF
-if { (eval echo configure:1556: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext} && (./conftest; exit) 2>/dev/null
+if { (eval echo configure:1563: \"$ac_link\") 1>&5; (eval $ac_link) 2>&5; } && test -s conftest${ac_exeext} && (./conftest; exit) 2>/dev/null
 then
   ac_cv_c_stack_direction=1
 else
@@ -1602,7 +1609,7 @@ else { echo "configure: error: can not r
 fi
 
 echo $ac_n "checking host system type""... $ac_c" 1>&6
-echo "configure:1606: checking host system type" >&5
+echo "configure:1613: checking host system type" >&5
 
 host_alias=$host
 case "$host_alias" in
@@ -1623,7 +1630,7 @@ host_os=`echo $host | sed 's/^\([^-]*\)-
 echo "$ac_t""$host" 1>&6
 
 echo $ac_n "checking target system type""... $ac_c" 1>&6
-echo "configure:1627: checking target system type" >&5
+echo "configure:1634: checking target system type" >&5
 
 target_alias=$target
 case "$target_alias" in
@@ -1641,7 +1648,7 @@ target_os=`echo $target | sed 's/^\([^-]
 echo "$ac_t""$target" 1>&6
 
 echo $ac_n "checking build system type""... $ac_c" 1>&6
-echo "configure:1645: checking build system type" >&5
+echo "configure:1652: checking build system type" >&5
 
 build_alias=$build
 case "$build_alias" in
@@ -1733,7 +1740,7 @@ MKINSTALLDIRS=$ac_aux_dir/mkinstalldirs
 # SVR4 /usr/ucb/install, which tries to use the nonexistent group "staff"
 # ./install, which can be erroneously created by make from ./install.sh.
 echo $ac_n "checking for a BSD compatible install""... $ac_c" 1>&6
-echo "configure:1737: checking for a BSD compatible install" >&5
+echo "configure:1744: checking for a BSD compatible install" >&5
 if test -z "$INSTALL"; then
 if eval "test \"`echo '$''{'ac_cv_path_install'+set}'`\" = set"; then
   echo $ac_n "(cached) $ac_c" 1>&6
@@ -1941,6 +1948,8 @@ s%@build_cpu@%$build_cpu%g
 s%@build_vendor@%$build_vendor%g
 s%@build_os@%$build_os%g
 s%@CC@%$CC%g
+s%@all_dlls_host@%$all_dlls_host%g
+s%@install_dlls_host@%$install_dlls_host%g
 s%@AR@%$AR%g
 s%@AS@%$AS%g
 s%@RANLIB@%$RANLIB%g
Index: configure.in
===================================================================
RCS file: /cvs/src/src/winsup/mingw/configure.in,v
retrieving revision 1.2
diff -u -p -r1.2 configure.in
--- configure.in	2000/04/19 17:11:59	1.2
+++ configure.in	2000/06/17 17:41:38
@@ -62,6 +62,13 @@ fi
 
 LIB_AC_PROG_CC
 
+case "$with_cross_host" in
+  ""|*cygwin*) all_dlls_host='all_dlls_host'
+	       install_dlls_host='install_dlls_host';;
+esac
+AC_SUBST(all_dlls_host)
+AC_SUBST(install_dlls_host)
+
 AC_CHECK_TOOL(AR, ar, ar)
 
 AC_SUBST(AR)
