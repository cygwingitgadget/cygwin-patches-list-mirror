Return-Path: <cygwin-patches-return-4471-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3634 invoked by alias); 3 Dec 2003 05:13:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3623 invoked from network); 3 Dec 2003 05:13:11 -0000
Message-Id: <3.0.5.32.20031203001035.0082a100@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 03 Dec 2003 05:13:00 -0000
To: Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Create Global Privilege
In-Reply-To: <20031202092639.GD1640@cygbert.vinschen.de>
References: <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031125205533.0082b2a0@incoming.verizon.net>
 <3.0.5.32.20031126104557.00838210@incoming.verizon.net>
 <20031129230722.GB6964@cygbert.vinschen.de>
 <3.0.5.32.20031201225546.0082ce20@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00190.txt.bz2

At 10:26 AM 12/2/2003 +0100, Corinna Vinschen wrote:
>On Mon, Dec 01, 2003 at 10:55:46PM -0500, Pierre A. Humblet wrote:
>> Also, the utmp/wtmp functions use mutexes to insure safe access.
>> That creates two problems, particularly on servers:
>> - When users have private copies of Cygwin with different mounts,
>>   there can be several utmp/wtmp files. Having a global mutex isn't
>>   helpful.
>> - If the utmp/wtmp files are unique, a user may not be have the
>>   privilege to create a global mutex, so that no mutual protection
>>   is achieved.
>> Both problems could be solved very simply by using file locking.
>> Should I do that some day?
>
>Sure, go ahead.

Hmm, the patch below might be a useful preliminary.

Also, on WinME specifying a length of 0 (changed to 0xFFFFFFFF) doesn't 
seem to work when the starting offset is greater than 1.
No time to fully investigate. 
Perhaps start + length must be <= 0x100000000 ???

Pierre

2003-12-03  Pierre Humblet <pierre.humblet@ieee.org>

	* fhandler_disk_file.cc (fhandler_disk_file::lock): Interchange
	values of off_low and off_high.


Index: fhandler_disk_file.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fhandler_disk_file.cc,v
retrieving revision 1.71
diff -u -p -r1.71 fhandler_disk_file.cc
--- fhandler_disk_file.cc       1 Dec 2003 17:26:28 -0000       1.71
+++ fhandler_disk_file.cc       3 Dec 2003 03:44:19 -0000
@@ -536,8 +536,8 @@ fhandler_disk_file::lock (int cmd, struc
 
   DWORD off_high, off_low, len_high, len_low;
 
-  off_high = (DWORD)(win32_start & 0xffffffff);
-  off_low = (DWORD)(win32_start >> 32);
+  off_low = (DWORD)(win32_start & 0xffffffff);
+  off_high = (DWORD)(win32_start >> 32);
   if (win32_len == 0)
     {
       /* Special case if len == 0 for POSIX means lock to the end of
