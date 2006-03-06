Return-Path: <cygwin-patches-return-5801-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4216 invoked by alias); 6 Mar 2006 14:14:16 -0000
Received: (qmail 4201 invoked by uid 22791); 6 Mar 2006 14:14:15 -0000
X-Spam-Check-By: sourceware.org
Received: from web53001.mail.yahoo.com (HELO web53001.mail.yahoo.com) (206.190.49.31)     by sourceware.org (qpsmtpd/0.31) with SMTP; Mon, 06 Mar 2006 14:14:13 +0000
Received: (qmail 85094 invoked by uid 60001); 6 Mar 2006 14:14:12 -0000
Message-ID: <20060306141411.85092.qmail@web53001.mail.yahoo.com>
Received: from [69.141.137.97] by web53001.mail.yahoo.com via HTTP; Mon, 06 Mar 2006 06:14:11 PST
Date: Mon, 06 Mar 2006 14:14:00 -0000
From: Gary Zablackis <gzabl@yahoo.com>
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
To: cygwin-patches@cygwin.com
In-Reply-To: <20060305004908.GB16741@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00110.txt.bz2

--- Christopher Faylor
<cgf-no-personal-reply-please@cygwin.com> wrote:

> You have missed how efault.faulted() is supposed to
> be operating and,
> AFAICT, *does* operate throughout the Cygwin DLL. 
> It really is supposed
> to be catching NULL dereferences.
> 
> It's possible of course, that there is something
> wrong with efault.faulted()
> but that doesn't mean we need to extra code around
> efault.faulted.  It means
> that efault.faulted needs to be fixed.
> 
> i.e., we need to fix the problem not the symptom.
> 
> cgf
> 
I did some more research over the weekend and my
problem seems to only come when loading a dll via
dlopen() and run_ctors() is called from dll:init() and
pthread_key_create() is called during the time that
run_ctors() is active. I still have not found who is
calling pthread_key_create(), but will be working on
this as time permits this week.

It's been several years since I did any assembly
language coding, so I have to study what's going on
when efault.faulted() returns non-zero - and figure
out how to get gdb to step through the assembly code.

Thanks,
Gary

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
