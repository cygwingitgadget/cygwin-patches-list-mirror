From: Mumit Khan <khan@NanoTech.Wisc.EDU>
To: cygwin-patches@sourceware.cygnus.com
Subject: (patch) munmap infinite loop fix
Date: Thu, 11 May 2000 14:56:00 -0000
Message-id: <200005112156.QAA30741@pluto.xraylith.wisc.edu>
X-SW-Source: 2000-q2/msg00053.html

I'm very short of time right now, on top of slow/flaky modem access, 
so would very much appreciate if you others could do a quick sanity 
check of the rest of the code in there (imagine user code doing tons
of interleaving mmaps and munmaps). I'll have a bit more time 
over the weekend.

2000-05-11  Mumit Khan  <khan@xraylith.wisc.edu>

	* mmap.cc (list::erase): Increment loop counter.
	(map::erase): Likewise.

Index: mmap.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mmap.cc,v
retrieving revision 1.1.1.1
diff -u -3 -p -u -p -r1.1.1.1 mmap.cc
--- mmap.cc	2000/02/17 19:38:31	1.1.1.1
+++ mmap.cc	2000/05/11 21:52:53
@@ -83,7 +83,7 @@ list::add_record (mmap_record r)
 void
 list::erase (int i)
 {
-  while (i < nrecs-1)
+  for (; i < nrecs-1; i++)
     recs[i] = recs[i+1];
   nrecs--;
 }
@@ -137,7 +137,7 @@ map::add_list (list *l, int fd)
 void
 map::erase (int i)
 {
-  while (i < nlists-1)
+  for (; i < nlists-1; i++)
     lists[i] = lists[i+1];
   nlists--;
 }

Regards,
Mumit
