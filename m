From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: Set argv[0] in the win32 style for non-Cygwin applications.
Date: Mon, 25 Sep 2000 01:36:00 -0000
Message-id: <s1sog1chnr4.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00099.html

The following patch will be useful, when a Cygwin application
launch non-Cygwin applications such as examine argv[0].

ChangeLog:
Mon Sep 25 17:33:29 2000  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* spawn.cc (spawn_guts): Set argv[0] in the win32 style for
	non-Cygwin applications.

Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.40
diff -u -p -r1.40 spawn.cc
--- spawn.cc	2000/09/19 13:48:52	1.40
+++ spawn.cc	2000/09/25 08:19:58
@@ -496,7 +496,10 @@ spawn_guts (HANDLE hToken, const char * 
 	  const char *a;
 
 	  newargv.dup_maybe (i);
-	  a = newargv[i];
+	  if (i == 0)
+	    a = real_path;
+	  else
+	    a = newargv[i];
 	  int len = strlen (a);
 	  if (len != 0 && !strpbrk (a, " \t\n\r\""))
 	    one_line.add (a, len);

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
