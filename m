From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sources.redhat.com
Subject: a problem in invoking scripts.
Date: Wed, 13 Sep 2000 05:25:00 -0000
Message-id: <s1s7l8gjxcs.fsf@jaist.ac.jp>
X-SW-Source: 2000-q3/msg00079.html

We can't execute scripts with their unqualified names on recent
snapshots.

~ $ cat > /bin/foo
#!/bin/sh
echo hoge
~ $ foo
foo: Can't open foo: No such file or directory

The following patch can solve this problem and recalls an old
warning to spawn.cc.

ChangeLog:
Wed Sep 13 21:11:12 2000  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* spawn.cc (spawn_guts): Properly set the absolute path of a script
	in newargv.

Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.38
diff -u -p -r1.38 spawn.cc
--- spawn.cc	2000/09/08 02:56:55	1.38
+++ spawn.cc	2000/09/13 12:06:50
@@ -453,6 +453,21 @@ spawn_guts (HANDLE hToken, const char * 
 	  *ptr = '\0';
 	}
 
+      /* Replace the script name in argv[0] with its absolute path.
+       * This is necessary if it has been found via PATH.
+       * For example, /usr/local/bin/tkman started as "tkman":
+       * #!/usr/local/bin/wish -f
+       * ...
+       * We should run /usr/local/bin/wish -f /usr/local/bin/tkman,
+       * but not /usr/local/bin/wish -f tkman!
+       * If argv[0] has been calloced, it must be an absolute path.
+       */
+      if (!newargv.calloced)
+	{
+	  newargv[0] = cstrdup (prog_arg);
+	  newargv.calloced++;
+	}
+
       /* pointers:
        * pgm	interpreter name
        * arg1	optional string

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
