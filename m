From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: stamp winver_stamp only on success
Date: Thu, 27 Sep 2001 05:04:00 -0000
Message-id: <00c001c1474c$ce1e1890$01000001@lifelesswks>
X-SW-Source: 2001-q3/msg00208.html

I've had some trouble with recent version changes, with cygwin_version.h
not being found - which is how I noticed this...

Thu Sep 27 22:00:00 2001 Robert Collins rbtcollins@itdomain.com.au

    * Makefile.in: Only stamp winver_stamp on success.

====
Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.63
diff -u -p -r1.63 Makefile.in
--- Makefile.in 2001/09/24 22:49:12     1.63
+++ Makefile.in 2001/09/27 12:03:42
@@ -210,8 +210,8 @@ version.cc winver.o: winver_stamp
 winver_stamp: mkvers.sh include/cygwin/version.h winver.rc
$(DLL_OFILES)
        @echo "Making version.o and winver.o";\
        $(SHELL) ${word 1,$^} ${word 2,$^} ${word 3,$^} $(WINDRES) && \
-       touch $@ && \
-       $(COMPILE_CXX) -o version.o version.cc
+       $(COMPILE_CXX) -o version.o version.cc && \
+       touch $@

 cygrun.exe : cygrun.o $(LIB_NAME) $(w32api_lib)/libuser32.a \
             $(w32api_lib)/libshell32.a $(w32api_lib)/libkernel32.a



