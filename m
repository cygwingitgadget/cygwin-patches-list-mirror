Return-Path: <cygwin-patches-return-7961-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28481 invoked by alias); 8 Feb 2014 15:00:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 28459 invoked by uid 89); 8 Feb 2014 15:00:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: smtpout07.bt.lon5.cpcloud.co.uk
Received: from smtpout07.bt.lon5.cpcloud.co.uk (HELO smtpout07.bt.lon5.cpcloud.co.uk) (65.20.0.127) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 08 Feb 2014 15:00:13 +0000
X-CTCH-RefID: str=0001.0A090207.52F6467A.0029,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=7/97,refid=2.7.2:2014.2.8.94814:17:7.944,ip=,rules=__MOZILLA_MSGID, __HAS_MSGID, __SANE_MSGID, __HAS_FROM, __USER_AGENT, __MOZILLA_USER_AGENT, __MIME_VERSION, __TO_MALFORMED_2, __BOUNCE_CHALLENGE_SUBJ, __BOUNCE_NDR_SUBJ_EXEMPT, __SUBJ_ALPHA_END, __IN_REP_TO, __CT, __CT_TEXT_PLAIN, __CTE, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __RUS_OBFU_PHONE, __SUBJ_ALPHA_NEGATE, __FORWARDED_MSG, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from [192.168.1.72] (86.174.32.243) by smtpout07.bt.lon5.cpcloud.co.uk (8.6.100.99.10223) (authenticated as jonturney@btinternet.com)        id 52F02CE6004A811B for cygwin-patches@cygwin.com; Sat, 8 Feb 2014 15:00:10 +0000
Message-ID: <52F64682.4090208@dronecode.org.uk>
Date: Sat, 08 Feb 2014 15:00:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Add minidump write utility
References: <52F50B71.8030608@dronecode.org.uk>
In-Reply-To: <52F50B71.8030608@dronecode.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-SW-Source: 2014-q1/txt/msg00034.txt.bz2

On 07/02/2014 16:36, Jon TURNEY wrote:
> 
> This patch adds a 'minidumper' utility, which functions identically to
> 'dumper' except it writes a Windows minidump, rather than a core file.
> 	
> I'm not sure if this is of use to anyone but me, but since I've had the patch
> sitting around for a couple of years, here it is...
> 
> 2014-02-07  Jon TURNEY  <jon.turney@dronecode.org.uk>
> 
> 	* minidumper.cc: New file.
> 	* Makefile.in (CYGWIN_BINS): Add minidumper.
> 	* utils.xml (minidumper): New section.
> 

Unfortunately there seems to be a bit of a problem with this patch. It seems
that cygwin assumes that the JIT debugger will terminate the debugged process.
 I'm not sure if that's always been the case.

Consider the following test case:

$ cat segv-test.c

int main(int argc, char *argv[])
{
  *(char *)0 = 0;
  return 0;
}
$ gcc -o segv-test.exe segv-test.c

$ export CYGWIN="error_start:C:\cygwin\bin\true.exe"

$ ./segv-test

seg-test crashes, true runs and exits, and segv-test spins.

dumper.exe does terminate the debugeee, but despite what utils.xml says about
this, I don't think this hasn't been a Windows API limitation since
DebugSetProcessKillOnExit() has existed.

I could fix this by making minidumper also terminate the dumped process, but
that doesn't seem the right approach.

I don't understand what debugging scenarios the waitloop part of
exceptions.cc:try_to_debug() is useful in, or why it doesn't wait until the
debugger process exits, so it's not clear to me how to fix this there, but
I'll note in passing that it seems that the thread's original priority is not
restored after running the debugger if waitloop=false, so perhaps at least the
following is needed:

--- cygwin/exceptions.cc        8 Jan 2014 16:51:20 -0000       1.432
+++ cygwin/exceptions.cc        8 Feb 2014 14:49:59 -0000
@@ -504,10 +504,8 @@

   if (!dbg)
     system_printf ("Failed to start debugger, %E");
-  else
+  else if (waitloop)
     {
-      if (!waitloop)
-       return dbg;
       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
       while (!being_debugged ())
        Sleep (1);

