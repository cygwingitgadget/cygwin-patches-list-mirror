Return-Path: <cygwin-patches-return-5799-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10206 invoked by alias); 5 Mar 2006 00:49:12 -0000
Received: (qmail 10195 invoked by uid 22791); 5 Mar 2006 00:49:12 -0000
X-Spam-Check-By: sourceware.org
Received: from cgf.cx (HELO cgf.cx) (24.61.23.223)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sun, 05 Mar 2006 00:49:11 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id AF0535A800C; Sat,  4 Mar 2006 19:49:08 -0500 (EST)
Date: Sun, 05 Mar 2006 00:49:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
Message-ID: <20060305004908.GB16741@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060302185429.GD7292@trixie.casa.cgf.cx> <20060303171353.40139.qmail@web53004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060303171353.40139.qmail@web53004.mail.yahoo.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00108.txt.bz2

On Fri, Mar 03, 2006 at 09:13:53AM -0800, Gary Zablackis wrote:
>--- Christopher Faylor
><cgf-no-personal-reply-please@cygwin.com> wrote:
>
>>The "efault.faulted()" two lines above your change is supposed to catch
>>NULL dereferences.  I suspect that you were probably misled by the fact
>>that gdb might show a SEGV in this function but that is to be expected
>>(see lots of discussion in the cygwin mailing list about this) and
>>there are patches pending for gdb which will work around this behavior.
>>
>>So, sorry, but I doubt that this is actually your problem.
>>
>>cgf
>
>Actually, as far as I can see, the "efault.faulted()" does NOT catch
>the NULL dereference, unless it is confused about where to return.  If
>it did, the code I added should not stop my program from crashing.  I
>will go back and look into this further, though, to see if I have
>missed something.

You have missed how efault.faulted() is supposed to be operating and,
AFAICT, *does* operate throughout the Cygwin DLL.  It really is supposed
to be catching NULL dereferences.

It's possible of course, that there is something wrong with efault.faulted()
but that doesn't mean we need to extra code around efault.faulted.  It means
that efault.faulted needs to be fixed.

i.e., we need to fix the problem not the symptom.

cgf
