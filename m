Return-Path: <cygwin-patches-return-4913-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4892 invoked by alias); 22 Aug 2004 21:13:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4881 invoked from network); 22 Aug 2004 21:13:53 -0000
Message-Id: <3.0.5.32.20040822170941.007c2c90@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 22 Aug 2004 21:13:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Truncate
In-Reply-To: <20040822155534.GA17449@cygbert.vinschen.de>
References: <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
 <3.0.5.32.20040821183627.008186a0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00065.txt.bz2

At 05:55 PM 8/22/2004 +0200, you wrote:
>Hi Pierre,
>
>Looks good to me.  But wouldn't it be better to fill in the zeros only
>if SetEndOfFile succeeded?  That would avoid a lengthy write operation
>if the application was, say, too optimistic about the space left on disk.

In that case we can't reuse the code already present in ::write
because when ::write calls GetFileSize it will get the length
already updated by SetEndOfFile.

The way ::write is written, it will restore the FilePointer at
the beginning of the 0 filled region if the disk gets full. But
because 0's may have been written, the EOF may have moved and the
file may have been extended.
When ftruncate calls SetEndOfFile, it will succeed and truncate
the file back to its original position. That's OK, but it should
then return an error. See updated patch below. 

As an aside, should ::write also call SetEndOfFile to truncate the
0's it has written? What do Cygwin on NT and Linux do when lseek
has been optimistic (and sparse files are off)?

Pierre

2004-08-23  Pierre Humblet <pierre.humblet@ieee.org>
 
 	* syscalls.cc (ftruncate64): On 9x, call write with a zero length
 	to zero fill when the file is extended.


Index: syscalls.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
retrieving revision 1.342
diff -u -p -r1.342 syscalls.cc
--- syscalls.cc 3 Aug 2004 14:37:26 -0000       1.342
+++ syscalls.cc 22 Aug 2004 21:00:49 -0000
@@ -1675,7 +1675,7 @@ setmode (int fd, int mode)
 extern "C" int
 ftruncate64 (int fd, _off64_t length)
 {
-  int res = -1;
+  int res = -1, res_bug = 0;
 
   if (length < 0)
     set_errno (EINVAL);
@@ -1692,10 +1692,15 @@ ftruncate64 (int fd, _off64_t length)
              _off64_t prev_loc = cfd->lseek (0, SEEK_CUR);
 
              cfd->lseek (length, SEEK_SET);
+             /* Fill the space with 0, if needed */
+             if (wincap.has_lseek_bug ())
+               res_bug = cfd->write (&res, 0);
+             /* In the lseek_bug case, this may restore the file to
+                its initial length */
              if (!SetEndOfFile (h))
                __seterrno ();
              else
-               res = 0;
+               res = res_bug;
 
              /* restore original file pointer location */
              cfd->lseek (prev_loc, SEEK_SET);

