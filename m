From: "Michael A. Chase" <mchase@ix.netcom.com>
To: <cygwin-patches@cygwin.com>
Subject: [PATCH]Setup version in setup.log
Date: Thu, 31 May 2001 11:51:00 -0000
Message-id: <00d801c0ea02$60a47a40$0332273f@ca.boeing.com>
References: <000b01c0e741$63e0a0d0$6e3a243f@ca.boeing.com>
X-SW-Source: 2001-q2/msg00272.html

I still haven't gotten the disclaimer from my company, but I hope you can
consider this a minor change.

ChangeLog:

2001-05-31  Michael Chase mchase@ix.netcom.com

    * main.cc (WinMain): Add setup version to starting setup.log entry

Patch:

--- old/main.cc Wed Sep  6 20:09:30 2000
+++ new/main.cc Sun May 27 23:30:22 2001
@@ -37,6 +37,7 @@ static char *cvsid = "\n%%% $Id: main.cc
 #include "find.h"
 #include "mount.h"
 #include "log.h"
+#include "version.h"

 #include "port.h"

@@ -57,7 +58,7 @@ WinMain (HINSTANCE h,

   next_dialog = IDD_SPLASH;

-  log (LOG_TIMESTAMP, "Starting cygwin install");
+  log (LOG_TIMESTAMP, "Starting cygwin install version %s", version);

   char cwd[_MAX_PATH];
   GetCurrentDirectory (sizeof (cwd), cwd);




