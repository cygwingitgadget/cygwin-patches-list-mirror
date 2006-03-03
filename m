Return-Path: <cygwin-patches-return-5791-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17319 invoked by alias); 3 Mar 2006 17:13:56 -0000
Received: (qmail 17309 invoked by uid 22791); 3 Mar 2006 17:13:56 -0000
X-Spam-Check-By: sourceware.org
Received: from web53004.mail.yahoo.com (HELO web53004.mail.yahoo.com) (206.190.49.34)     by sourceware.org (qpsmtpd/0.31) with SMTP; Fri, 03 Mar 2006 17:13:55 +0000
Received: (qmail 40141 invoked by uid 60001); 3 Mar 2006 17:13:53 -0000
Message-ID: <20060303171353.40139.qmail@web53004.mail.yahoo.com>
Received: from [69.141.137.97] by web53004.mail.yahoo.com via HTTP; Fri, 03 Mar 2006 09:13:53 PST
Date: Fri, 03 Mar 2006 17:13:00 -0000
From: Gary Zablackis <gzabl@yahoo.com>
Subject: Re: Patch for silent crash with Cygwin1.dll v 1.5.19-4
To: cygwin-patches@cygwin.com
In-Reply-To: <20060302185429.GD7292@trixie.casa.cgf.cx>
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
X-SW-Source: 2006-q1/txt/msg00100.txt.bz2

--- Christopher Faylor
<cgf-no-personal-reply-please@cygwin.com> wrote:

> The "efault.faulted()" two lines above your change
> is supposed to catch
> NULL dereferences.  I suspect that you were probably
> misled by the fact
> that gdb might show a SEGV in this function but that
> is to be expected
> (see lots of discussion in the cygwin mailing list
> about this) and there
> are patches pending for gdb which will work around
> this behavior.
> 
> So, sorry, but I doubt that this is actually your
> problem.
> 
> cgf
> 

Christopher,

Actually, as far as I can see, the "efault.faulted()"
does NOT catch the NULL dereference, unless it is
confused about where to return. If it did, the code I
added should not stop my program from crashing. I will
go back and look into this further, though, to see if
I have missed something.

Thanks for your time.

Gary

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
