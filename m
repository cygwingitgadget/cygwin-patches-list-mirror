From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: [PATCH]: Check modification time on /etc/passwd and /etc/group
Date: Tue, 31 Jul 2001 11:38:00 -0000
Message-id: <20010731203820.U490@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00041.html

Hi,

the following is a PRELIMINARY patch which I created while waiting
for a loooong build. It checks the modification time on /etc/passwd
and /etc/group to reread them if neccessary.

It's preliminary since it completely ignores thread issues.

Could somebody have a look what is needed to make it thread safe?

Thanks in advance,
Corinna

ChangeLog:
==========

	* grp.cc (class grp_check): New class. Make `group_state'
	a member of class grp_check.
	(read_etc_group): Set `curr_lines' explicitely to 0.
	* passwd.cc (class pwd_check): New class Make `passwd_state'
	a member of class pwd_check.
	(read_etc_passwd): Set `curr_lines' explicitely to 0.

Index: grp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.26
diff -u -p -r1.26 grp.cc
--- grp.cc	2001/07/26 19:22:24	1.26
+++ grp.cc	2001/07/31 18:00:27
@@ -17,6 +17,7 @@ details. */
 #include <stdio.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <sys/stat.h>
 #include "sync.h"
 #include "sigproc.h"
 #include "pinfo.h"
@@ -51,7 +52,30 @@ enum grp_state {
   emulated,
   loaded
 };
-static grp_state group_state = uninitialized;
+class grp_check {
+  grp_state state;
+  time_t    last_modified;
+
+public:
+  grp_check () : state (uninitialized), last_modified (0L) {}
+  operator grp_state ()
+    {
+      struct stat st;
+
+      if (!stat ("/etc/group", &st) && st.st_mtime > last_modified)
+	{
+	  state = uninitialized;
+	  last_modified = st.st_mtime;
+	}
+      return state;
+    }
+  void operator = (grp_state nstate)
+    {
+      state = nstate;
+    }
+};
+
+static grp_check group_state;
 
 static int
 parse_grp (struct group &grp, const char *line)
@@ -153,6 +177,7 @@ read_etc_group ()
   if (group_state != initializing)
     {
       group_state = initializing;
+      curr_lines = 0;
 
       FILE *f = fopen (etc_group, "rt");
 
Index: passwd.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.27
diff -u -p -r1.27 passwd.cc
--- passwd.cc	2001/07/26 19:22:24	1.27
+++ passwd.cc	2001/07/31 18:00:27
@@ -13,6 +13,7 @@ details. */
 #include <pwd.h>
 #include <stdio.h>
 #include <errno.h>
+#include <sys/stat.h>
 #include "cygerrno.h"
 #include "security.h"
 #include "fhandler.h"
@@ -40,7 +41,31 @@ enum pwd_state {
   emulated,
   loaded
 };
-static pwd_state passwd_state = uninitialized;
+class pwd_check {
+  pwd_state state;
+  time_t    last_modified;
+
+public:
+  pwd_check () : state (uninitialized), last_modified (0L) {}
+  operator pwd_state ()
+    {
+      struct stat st;
+
+      if (!stat ("/etc/passwd", &st) && st.st_mtime > last_modified)
+	{
+	  state = uninitialized;
+	  last_modified = st.st_mtime;
+	}
+      return state;
+    }
+  void operator = (pwd_state nstate)
+    {
+      state = nstate;
+    }
+};
+
+static pwd_check passwd_state;
+
 
 /* Position in the passwd cache */
 #ifdef _MT_SAFE
@@ -140,6 +165,7 @@ read_etc_passwd ()
     if (passwd_state != initializing)
       {
 	passwd_state = initializing;
+	curr_lines = 0;
 
 	FILE *f = fopen ("/etc/passwd", "rt");
 
-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
