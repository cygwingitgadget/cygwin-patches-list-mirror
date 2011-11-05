Return-Path: <cygwin-patches-return-7541-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17228 invoked by alias); 5 Nov 2011 17:01:03 -0000
Received: (qmail 17217 invoked by uid 22791); 5 Nov 2011 17:01:02 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,TW_CG,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout04.t-online.de (HELO mailout04.t-online.de) (194.25.134.18)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 05 Nov 2011 17:00:39 +0000
Received: from fwd05.aul.t-online.de (fwd05.aul.t-online.de )	by mailout04.t-online.de with smtp 	id 1RMjbh-0003X5-HR; Sat, 05 Nov 2011 18:00:37 +0100
Received: from [192.168.2.108] (S92HcsZvrhUALniMoWCXDHavSRlg0cJIyIx9PVe6xQ5e2vYRu4DkhjmObXSrPA-wlA@[79.224.121.62]) by fwd05.t-online.de	with esmtp id 1RMjbV-0SN3rM0; Sat, 5 Nov 2011 18:00:25 +0100
Message-ID: <4EB56BA9.6010803@t-online.de>
Date: Sat, 05 Nov 2011 17:01:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110928 Firefox/7.0.1 SeaMonkey/2.4.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Prevent restart of crashing non-Cygwin exe
References: <4E037D68.6090907@t-online.de> <20110624075743.GR3437@calimero.vinschen.de> <4EB19FBB.5060800@t-online.de> <20111103120720.GF9159@calimero.vinschen.de> <20111103213455.GA4709@ednor.casa.cgf.cx>
In-Reply-To: <20111103213455.GA4709@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="------------020203000203040606070805"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00031.txt.bz2

This is a multi-part message in MIME format.
--------------020203000203040606070805
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1504

Christopher Faylor wrote:
> On Thu, Nov 03, 2011 at 01:07:20PM +0100, Corinna Vinschen wrote:
>> On Nov  2 20:53, Christian Franke wrote:
>>> On Jun 24, Corinna Vinschen wrote:
>>>> Hi Christian,
>>>>
>>>> On Jun 23 19:52, Christian Franke wrote:
>>>>> If a non-Cygwin .exe started from a Cygwin shell window segfaults,
>>>>> Cygwin restarts the .exe 5 times.
>>>>> [...l]
>>>>> 	* sigproc.cc (child_info::sync): Add exit_code to debug
>>>>> 	message.
>>>>> 	(child_info::proc_retry): Don't retry on unknown exit_code
>>>>> 	from non-cygwin programs.
>>>> This looks ok to me, but cgf should have a say here.  He's on vacation
>>>> for another week, though.
>>>>
>>> Problem can still be reproduced with current CVS.  Patch is still
>>> valid.
>> Sorry, I forgot about this patch entirely.  Chris, is that patch ok
>> with you as well?
> No, it isn't.  Sorry for not stating this earlier.  The problem that
> this code was intended to solve was actually a transient exit codes from
> a non-Cygwin process which began with 0xc...
>
> I don't believe that I ever saw STATUS_ACCESS_VIOLATION in any of my
> testing though so adding that earlier in the switch would fix this
> particular problem.  I'll do that.

Works as expected with testcase from my first mail:

$ i686-w64-mingw32-gcc -o crash-w crash.c

$ ./crash-w
Hello,


A drawback is that non-Cygwin programs crash silently.
I attached an experimental patch which sets WTERMSIG(status) = SIGSEGV:

$ ./crash-w
Hello, Segmentation fault

Christian


--------------020203000203040606070805
Content-Type: text/x-patch;
 name="fake-sigsegv.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fake-sigsegv.patch"
Content-length: 591

diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index 5a77d8f..7d60d62 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -148,9 +148,13 @@ status_exit (DWORD x)
 void
 pinfo::set_exit_code (DWORD x)
 {
-  if (x >= 0xc0000000UL)
+  int sig = sigExeced;
+  if (x == STATUS_ACCESS_VIOLATION && !sig)
+    /* Report segfault to parent process.  */
+    sig = SIGSEGV;
+  else if (x >= 0xc0000000UL)
     x = status_exit (x);
-  self->exitcode = EXITCODE_SET | (sigExeced ?: (x & 0xff) << 8);
+  self->exitcode = EXITCODE_SET | (sig ?: (x & 0xff) << 8);
 }
 
 void

--------------020203000203040606070805--
