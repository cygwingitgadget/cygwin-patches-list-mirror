Return-Path: <cygwin-patches-return-4338-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9226 invoked by alias); 4 Nov 2003 08:41:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9195 invoked from network); 4 Nov 2003 08:41:30 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3FA76629.9070802@gmx.net>
Date: Tue, 04 Nov 2003 08:41:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix debugger attach for threads
References: <3FA2D012.5060607@gmx.net> <20031031212316.GA8668@redhat.com>
In-Reply-To: <20031031212316.GA8668@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------090300090606050906010307"
X-SW-Source: 2003-q4/txt/msg00057.txt.bz2

This is a multi-part message in MIME format.
--------------090300090606050906010307
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1040

Christopher Faylor wrote:
> On Fri, Oct 31, 2003 at 10:11:46PM +0100, Thomas Pfaff wrote:
> 
>>This patch allows a debugger to attach when an exception occurs in a 
>>thread other than the mainthread.
>>
>>I am not happy about the wait in handle_exceptions, but it works on my 
>>machine. I think that a waitloop until the debugger is attached is 
>>cleaner, but there must be a reason why the debbugging loop is 
>>implemented this way.
> 
> 
> The intent is for an attached debugger to immediately see the location
> that died.  If you loop in the try_to_debug code then it is a pain to
> figure out exactly where the exception occurred.
> 

I never see immediately the location, i must always continue the program 
to get it.

Anyway, attached is new attempt that does not make use of 
Suspend/ResumeThread and keeps the process running until the debugger is 
attached.

2003-11-04  Thomas Pfaff  <tpfaff@gmx.net>

	* exceptions.cc (handle_exceptions): Keep process running when
	debugger is attaching. Give debugger CPU time to attach.

--------------090300090606050906010307
Content-Type: plain/text;
 name="handle_exceptions.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="handle_exceptions.patch"
Content-length: 755

--- exceptions.cc.org	2003-11-04 09:19:29.470659200 +0100
+++ exceptions.cc	2003-11-04 09:24:02.796536000 +0100
@@ -424,9 +424,19 @@ handle_exceptions (EXCEPTION_RECORD *e, 
   static int NO_COPY debugging = 0;
   static int NO_COPY recursed = 0;
 
-  if (debugging && ++debugging < 500000)
+  if (debugging)
     {
-      SetThreadPriority (hMainThread, THREAD_PRIORITY_NORMAL);
+      if (!being_debugged ())
+        {
+          /*
+           * Give debugger CPU time to attach
+           */
+          LONG prio = GetThreadPriority (GetCurrentThread ());
+          SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
+          Sleep (0);
+          SetThreadPriority (GetCurrentThread (), prio);
+        }
+
       return 0;
     }
 

--------------090300090606050906010307--
