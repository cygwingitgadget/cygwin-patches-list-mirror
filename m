From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@cygwin.com
Subject: Wait_sig can't dispatch SIGCONT.
Date: Wed, 10 Jan 2001 05:43:00 -0000
Message-id: <s1sd7dvplpg.fsf@jaist.ac.jp>
X-SW-Source: 2001-q1/msg00022.html

Wait_sig can't dispatch SIGCONT.
For example, cat will choke aftern the following session.
$ cat
^Z
[1]+  Stopped                 cat
$ fg
cat

The following patch can solve this problem.

ChangeLog:
Wed Jan 10 22:08:30 2001  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* sigproc.cc (wait_sig): Don't block SIGCONT incorrectly.

Index: sigproc.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sigproc.cc,v
retrieving revision 1.67
diff -u -p -r1.67 sigproc.cc
--- sigproc.cc	2001/01/08 04:02:01	1.67
+++ sigproc.cc	2001/01/10 13:03:20
@@ -1150,7 +1150,7 @@ wait_sig (VOID *)
 
 	      if (sig > 0 && sig != SIGKILL && sig != SIGSTOP &&
 		  (sigismember (& myself->getsigmask (), sig) ||
-		   myself->process_state & PID_STOPPED))
+		   (sig != SIGCONT && myself->process_state & PID_STOPPED)))
 		{
 		  sigproc_printf ("sig %d blocked", sig);
 		  break;

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
