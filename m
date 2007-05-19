Return-Path: <cygwin-patches-return-6093-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22568 invoked by alias); 19 May 2007 12:04:34 -0000
Received: (qmail 22556 invoked by uid 22791); 19 May 2007 12:04:33 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout08.sul.t-online.com (HELO mailout08.sul.t-online.com) (194.25.134.20)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 19 May 2007 12:04:27 +0000
Received: from fwd31.aul.t-online.de  	by mailout08.aul.t-online.de with smtp  	id 1HpNfb-0003KO-00; Sat, 19 May 2007 14:04:23 +0200
Received: from [10.3.2.2] (XpNZm8ZeZer2IKO6AEYNd53HiH0HEy7i7-15FybGlYW9hU-CcfFBcn@[217.235.228.84]) by fwd31.sul.t-online.de 	with esmtp id 1HpNfR-0qEk1w0; Sat, 19 May 2007 14:04:13 +0200
Message-ID: <464EE7C1.3000709@t-online.de>
Date: Sat, 19 May 2007 12:04:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]  ddrescue  1.3)
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx> <464ECCBA.3000700@portugalmail.pt>
In-Reply-To: <464ECCBA.3000700@portugalmail.pt>
Content-Type: multipart/mixed;  boundary="------------030803000606040204040504"
X-ID: XpNZm8ZeZer2IKO6AEYNd53HiH0HEy7i7-15FybGlYW9hU-CcfFBcn
X-TOI-MSGID: 05a0182b-58a3-42b3-8783-e653f9ea55e9
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00039.txt.bz2

This is a multi-part message in MIME format.
--------------030803000606040204040504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1179

Pedro Alves wrote:
> Christopher Faylor escreveu:
>> On Fri, May 18, 2007 at 09:02:15PM +0200, Christian Franke wrote:
>>> Hi,
>>>
>>> Cygwin 1.5.24-2 segfaults on unaligned lseek() on raw block devices 
>>> with sector size >512 bytes.
>>>
>>> Testcases:
>>> $ dd skip=1000 bs=2047 if=/dev/scd0 of=/dev/null
>>>
>>> $ ddrescue -c 1 /dev/scd0 file.iso
>>>
>>>
>>> This is due to a fixed 512 byte buffer in fhandler_dev_floppy::lseek().
>>> It is still present in HEAD revision.
>>>
>>> The attached patch should fix. It should work for any sector size.
>>> (Smoke-)tested with 1.5.24-2 (too busy to test with current CVS, 
>>> sorry).
>>>
>>> 2007-05-18  Christian Franke <franke@computer.org>
>>>
>>>     * fhandler_floppy.cc (fhandler_dev_floppy::lseek): Fixed 
>>> segfault on
>>>     unaligned seek due to fixed size buffer.
>>>
>>
>> It seems like this could be done without the heavyweight use of malloc,
>> like use an automatic array of length 512 + 4 and calculate an aligned
>> address from that.
>>
>
> Or use alloca instead?
>
> -  char buf[512];
> +  char *buf = (char *) alloca (512);
>

Yes, thanks.

Makes the new patch really simple, see attachment.

Christian


--------------030803000606040204040504
Content-Type: text/plain;
 name="cygwin-1.5.24-2-rawseek-2.patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-1.5.24-2-rawseek-2.patch.txt"
Content-length: 874

--- cygwin-1.5.24-2.orig/winsup/cygwin/fhandler_floppy.cc	2006-07-18 14:56:37.001000000 +0200
+++ cygwin-1.5.24-2/winsup/cygwin/fhandler_floppy.cc	2007-05-19 13:07:33.484375000 +0200
@@ -12,6 +12,7 @@ details. */
 #include "winsup.h"
 #include <sys/termios.h>
 #include <unistd.h>
+#include <stdlib.h>
 #include <winioctl.h>
 #include <asm/socket.h>
 #include <cygwin/rdevio.h>
@@ -408,7 +409,6 @@ fhandler_dev_floppy::raw_write (const vo
 _off64_t
 fhandler_dev_floppy::lseek (_off64_t offset, int whence)
 {
-  char buf[512];
   _off64_t lloffset = offset;
   LARGE_INTEGER sector_aligned_offset;
   _off64_t bytes_left;
@@ -454,6 +454,7 @@ fhandler_dev_floppy::lseek (_off64_t off
   if (bytes_left)
     {
       size_t len = bytes_left;
+      char *buf = (char *) alloca (len);
       raw_read (buf, len);
     }
   return sector_aligned_offset.QuadPart + bytes_left;

--------------030803000606040204040504--
