Return-Path: <cygwin-patches-return-3897-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23447 invoked by alias); 25 May 2003 21:54:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23403 invoked from network); 25 May 2003 21:54:14 -0000
Message-Id: <3.0.5.32.20030525175432.00807100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Sun, 25 May 2003 21:54:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: df and ls for root directories on Win9X
In-Reply-To: <20030525164823.GA8773@redhat.com>
References: <20030525091901.GA875@cygbert.vinschen.de>
 <3.0.5.32.20030523183423.008059c0@mail.attbi.com>
 <20030525091901.GA875@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q2/txt/msg00124.txt.bz2

At 12:48 PM 5/25/2003 -0400, Christopher Faylor wrote:
>On Sun, May 25, 2003 at 11:19:01AM +0200, Corinna Vinschen wrote:
>>On Fri, May 23, 2003 at 06:34:23PM -0400, Pierre A. Humblet wrote:
>>> 2003-05-23  Pierre Humblet  <pierre.humblet@ieee.org>
>>> 
>>> 	* autoload.cc (GetDiskFreeSpaceEx): Add.
>>> 	* syscalls.cc (statfs): Call full_path.root_dir() instead of
>>> 	rootdir(full_path). Use GetDiskFreeSpaceEx when available and
>>> 	report space available in addition to free space.
>>> 	* fhandler_disk_file.cc (fhandler_disk_file::fstat_by_name):
>>> 	Do not call FindFirstFile for disk root directories.
>>
>>Applied.
>
>Um.  I am still reviewing the fstat_by_name stuff.  I will be making
>changes to this.
>
I hope you find a more elegant way to determine when it's a root directory.


Meanwhile I found out that my statfs change fixing the MS GetFreeDiskSpace
bug exposes (on WinME only) a MS GetFreeDiskSpaceEx bug.
<http://support.microsoft.com/default.aspx?scid=kb%3ben-us%3b314417>  

Experimentally, that can be fixed by calling GetFreeDiskSpaceEx before
GetFreeDiskSpace, but not more than once per 3 sec... BTW, looking
up the disk properties in Windows has the same feature.

Pierre

2003-05-25  Pierre Humblet  <pierre.humblet@ieee.org>

	* syscalls.cc (statfs): Call GetDiskFreeSpaceEx before GetDiskFreeSpace.



Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.270
diff -u -p -r1.270 syscalls.cc
--- syscalls.cc 25 May 2003 09:18:43 -0000      1.270
+++ syscalls.cc 25 May 2003 21:45:12 -0000
@@ -1876,6 +1876,11 @@ statfs (const char *fname, struct statfs
 
   syscall_printf ("statfs %s", root);
 
+  /* GetDiskFreeSpaceEx must be called before GetDiskFreeSpace on 
+     WinME, to avoid the MS KB 314417 bug */
+  ULARGE_INTEGER availb, freeb, totalb;
+  BOOL status = GetDiskFreeSpaceEx (root, &availb, &totalb, &freeb);
+
   DWORD spc, bps, availc, freec, totalc;
 
   if (!GetDiskFreeSpace (root, &spc, &bps, &freec, &totalc))
@@ -1884,9 +1889,7 @@ statfs (const char *fname, struct statfs
       return -1;
     }
 
-  ULARGE_INTEGER availb, freeb, totalb;
-
-  if (GetDiskFreeSpaceEx (root, &availb, &totalb, &freeb))
+  if (status)
     {
       availc = availb.QuadPart / (spc*bps);
       totalc = totalb.QuadPart / (spc*bps);

