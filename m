Return-Path: <cygwin-patches-return-4356-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 894 invoked by alias); 11 Nov 2003 15:48:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 868 invoked from network); 11 Nov 2003 15:48:08 -0000
Date: Tue, 11 Nov 2003 15:48:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] stdio initialization
Message-ID: <20031111154807.GB25083@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.WNT.4.44.0311101211450.1520-200000@algeria.intern.net> <20031110135740.GA12455@redhat.com> <3FAF9A9A.3070509@gmx.net> <20031110150952.GA10851@redhat.com> <20031110153018.GA12119@redhat.com> <3FB0F5A6.1050207@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB0F5A6.1050207@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00075.txt.bz2

On Tue, Nov 11, 2003 at 03:43:50PM +0100, Thomas Pfaff wrote:
>Christopher Faylor wrote:
>>Actually, on poking around a little, I wonder if we should be calling
>>_reclaim_reent to get back all of the stuff allocated in the REENT
>>structure?
>
>I think you are right.  Here is my patch to thread.cc that i will apply
>if there are no objections.

Looks ok to me.

cgf

>diff -urp src.org/thread.cc src/thread.cc
>--- src.org/thread.cc	2003-11-11 09:16:39.775574400 +0100
>+++ src/thread.cc	2003-11-11 09:21:24.304707200 +0100
>@@ -377,6 +377,8 @@ pthread::exit (void *value_ptr)
>       mutex.unlock ();
>     }
>
>+  (_reclaim_reent) (_REENT);
>+
>   if (InterlockedDecrement (&MT_INTERFACE->threadcount) == 0)
>     ::exit (0);
>   else
>@@ -1879,6 +1881,7 @@ __reent_t::init_clib (struct _reent& var
>   var._stdout = _GLOBAL_REENT->_stdout;
>   var._stderr = _GLOBAL_REENT->_stderr;
>   var.__sdidinit = _GLOBAL_REENT->__sdidinit;
>+  var.__cleanup = _GLOBAL_REENT->__cleanup;
>   _clib = &var;
> };
