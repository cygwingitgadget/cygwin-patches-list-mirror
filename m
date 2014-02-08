Return-Path: <cygwin-patches-return-7964-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25058 invoked by alias); 8 Feb 2014 20:49:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 25047 invoked by uid 89); 8 Feb 2014 20:49:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Sat, 08 Feb 2014 20:49:23 +0000
Received: from pool-71-126-240-215.bstnma.fios.verizon.net ([71.126.240.215] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1WCEq1-0000QT-Lb	for cygwin-patches@cygwin.com; Sat, 08 Feb 2014 20:49:21 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 9699560113	for <cygwin-patches@cygwin.com>; Sat,  8 Feb 2014 15:49:19 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Sat, 08 Feb 2014 15:49:19 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19cSbuFjwciiy93iRKSDiwz
Date: Sat, 08 Feb 2014 20:49:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add minidump write utility
Message-ID: <20140208204919.GA5199@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <52F50B71.8030608@dronecode.org.uk> <52F64682.4090208@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52F64682.4090208@dronecode.org.uk>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00037.txt.bz2

On Sat, Feb 08, 2014 at 03:00:18PM +0000, Jon TURNEY wrote:
>On 07/02/2014 16:36, Jon TURNEY wrote:
>> 
>> This patch adds a 'minidumper' utility, which functions identically to
>> 'dumper' except it writes a Windows minidump, rather than a core file.
>> 	
>> I'm not sure if this is of use to anyone but me, but since I've had the patch
>> sitting around for a couple of years, here it is...
>> 
>> 2014-02-07  Jon TURNEY  <jon.turney@dronecode.org.uk>
>> 
>> 	* minidumper.cc: New file.
>> 	* Makefile.in (CYGWIN_BINS): Add minidumper.
>> 	* utils.xml (minidumper): New section.
>> 
>
>Unfortunately there seems to be a bit of a problem with this patch. It seems
>that cygwin assumes that the JIT debugger will terminate the debugged process.
> I'm not sure if that's always been the case.
>
>Consider the following test case:
>
>$ cat segv-test.c
>
>int main(int argc, char *argv[])
>{
>  *(char *)0 = 0;
>  return 0;
>}
>$ gcc -o segv-test.exe segv-test.c
>
>$ export CYGWIN="error_start:C:\cygwin\bin\true.exe"
>
>$ ./segv-test
>
>seg-test crashes, true runs and exits, and segv-test spins.
>
>dumper.exe does terminate the debugeee, but despite what utils.xml says about
>this, I don't think this hasn't been a Windows API limitation since
>DebugSetProcessKillOnExit() has existed.
>
>I could fix this by making minidumper also terminate the dumped process, but
>that doesn't seem the right approach.
>
>I don't understand what debugging scenarios the waitloop part of
>exceptions.cc:try_to_debug() is useful in, or why it doesn't wait until the
>debugger process exits, so it's not clear to me how to fix this there, but
>I'll note in passing that it seems that the thread's original priority is not
>restored after running the debugger if waitloop=false, so perhaps at least the
>following is needed:
>
>--- cygwin/exceptions.cc        8 Jan 2014 16:51:20 -0000       1.432
>+++ cygwin/exceptions.cc        8 Feb 2014 14:49:59 -0000
>@@ -504,10 +504,8 @@
>
>   if (!dbg)
>     system_printf ("Failed to start debugger, %E");
>-  else
>+  else if (waitloop)
>     {
>-      if (!waitloop)
>-       return dbg;
>       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
>       while (!being_debugged ())
>        Sleep (1);

Go ahead and check in the above but I don't see how it would be possible
in a non-racy way for a dumper process to dump it's parents core unless
the parent was guaranteed to still be alive.

cgf
