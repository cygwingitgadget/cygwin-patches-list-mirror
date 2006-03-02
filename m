Return-Path: <cygwin-patches-return-5781-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19236 invoked by alias); 2 Mar 2006 18:54:33 -0000
Received: (qmail 19224 invoked by uid 22791); 2 Mar 2006 18:54:32 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 02 Mar 2006 18:54:31 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 2F5CD5A800C; Thu,  2 Mar 2006 13:54:30 -0500 (EST)
Date: Thu, 02 Mar 2006 18:54:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
Message-ID: <20060302185429.GD7292@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20060302181139.52070.qmail@web53004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302181139.52070.qmail@web53004.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00090.txt.bz2

On Thu, Mar 02, 2006 at 10:11:39AM -0800, Gary Zablackis wrote:
>Since installing Cygwin1.dll v 1.5.19-4, I have a problem with the
>computer algebra system SAGE dying at startup with no error messages
>(i.e.  I get returned to the bash prompt with no messages of any sort).
>I tracked the problem down to verifyable_object_isvalid() in
>winsup/thread.cc.  The added the check below corrects this problem:
>
>CHANGELOG:
>2006-03-02 Gary Zablackis gzabl@yahoo.com
> * thread.cc (verifyable_object_isvalid): check for
>NULL object or reference

The "efault.faulted()" two lines above your change is supposed to catch
NULL dereferences.  I suspect that you were probably misled by the fact
that gdb might show a SEGV in this function but that is to be expected
(see lots of discussion in the cygwin mailing list about this) and there
are patches pending for gdb which will work around this behavior.

So, sorry, but I doubt that this is actually your problem.

cgf

>CVS DIFF FILE:
>Index: cygwin/thread.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
>retrieving revision 1.196
>diff -u -p -r1.196 thread.cc
>--- cygwin/thread.cc    6 Feb 2006 18:24:06 -0000     
> 1.196
>+++ cygwin/thread.cc    2 Mar 2006 18:06:50 -0000
>@@ -122,6 +122,9 @@ verifyable_object_isvalid (void
>const *
>   if (efault.faulted ())
>     return INVALID_OBJECT;
>
>+  if(!object || !*object)
>+     return INVALID_OBJECT;
>+
>   if ((static_ptr1 && *object == static_ptr1) ||
>       (static_ptr2 && *object == static_ptr2) ||
>       (static_ptr3 && *object == static_ptr3))
