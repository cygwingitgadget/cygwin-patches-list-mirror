Return-Path: <cygwin-patches-return-3919-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25490 invoked by alias); 30 May 2003 02:32:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25453 invoked from network); 30 May 2003 02:32:15 -0000
Message-Id: <3.0.5.32.20030529223239.007fca00@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Fri, 30 May 2003 02:32:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: stat matters
In-Reply-To: <20030529033329.GA14340@redhat.com>
References: <3.0.5.32.20030527194843.008044b0@mail.attbi.com>
 <3.0.5.32.20030527194843.008044b0@mail.attbi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00146.txt.bz2

At 11:33 PM 5/28/2003 -0400, Christopher Faylor wrote:
>On Tue, May 27, 2003 at 07:48:43PM -0400, Pierre A. Humblet wrote:
>
>>   So I suggest a more radical approach: do not check for root dir at all
but
>>   whenever FindFirstFile fails with winerror 2 (although we know the 
>>   file did exist a few ms ago and we have its attributes), call
fstat_helper 
>>   with zero dates and lengths.
>
>I guess this is the best approach.  Want to work up a patch?

Done, but it's not that simple. The error is not 2 for remote drives. Also
I don't know what it might be on all other systems. So I check for directory
but not for specific errors. The worst that can occur is that a directory 
that was being deleted while the stat was in progress will show up with a 
wrong date. 

2003-05-29  Pierre Humblet  <pierre.humblet@ieee.org>

	* fhandler_disk_file.cc (fhandler_disk_file::fstat_by_name): Assume
	an existing directory is a root if FindFirstFile fails.
 
	
Index: fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.53
diff -u -p -r1.53 fhandler_disk_file.cc
--- fhandler_disk_file.cc       27 May 2003 07:44:26 -0000      1.53
+++ fhandler_disk_file.cc       30 May 2003 02:11:36 -0000
@@ -108,18 +108,7 @@ fhandler_disk_file::fstat_by_name (struc
       set_errno (ENOENT);
       res = -1;
     }
-  else if (pc->isdir () && strlen (*pc) <= strlen (pc->root_dir ()))
-    {
-      FILETIME ft = {};
-      res = fstat_helper (buf, pc, ft, ft, ft, 0, 0);
-    }
-  else if ((handle = FindFirstFile (*pc, &local)) == INVALID_HANDLE_VALUE)
-    {
-      debug_printf ("FindFirstFile failed for '%s', %E", (char *) *pc);
-      __seterrno ();
-      res = -1;
-    }
-  else
+  else if ((handle = FindFirstFile (*pc, &local)) != INVALID_HANDLE_VALUE)
     {
       FindClose (handle);
       res = fstat_helper (buf, pc,
@@ -128,6 +117,17 @@ fhandler_disk_file::fstat_by_name (struc
                          local.ftLastWriteTime,
                          local.nFileSizeHigh,
                          local.nFileSizeLow);
+    }
+  else if (pc->isdir ())
+    {
+      FILETIME ft = {};
+      res = fstat_helper (buf, pc, ft, ft, ft, 0, 0);
+    }
+  else 
+    {
+      debug_printf ("FindFirstFile failed for '%s', %E", (char *) *pc);
+      __seterrno ();
+      res = -1;
     }
   return res;
 }
