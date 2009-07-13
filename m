Return-Path: <cygwin-patches-return-6571-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22845 invoked by alias); 13 Jul 2009 08:50:31 -0000
Received: (qmail 22823 invoked by uid 22791); 13 Jul 2009 08:50:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 13 Jul 2009 08:50:20 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 705646D5598; Mon, 13 Jul 2009 10:50:09 +0200 (CEST)
Date: Mon, 13 Jul 2009 08:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
Message-ID: <20090713085009.GA11234@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com> <4A53BC5D.7010401@gmail.com> <4A53E449.4020504@gmail.com> <20090713015220.GA1392@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090713015220.GA1392@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00025.txt.bz2

On Jul 12 21:52, Christopher Faylor wrote:
> On Wed, Jul 08, 2009 at 01:11:53AM +0100, Dave Korn wrote:
> >Dave Korn wrote:
> >>It doesn't do anything about the reload failure, which is a bug in
> >>GCC-3, since the usage is a standard usage supported by the
> >>documentation.  It's possible that it may disappear as a side-effect,
> >>in which case all the better.
> >
> >Nope, no such luck.
> 
> I just bugged Dave in private email about this without doing my
> homework first.  How embarrassing.
> 
> There is a subtle difference in the generated code if you do this:
> 
> --- winbase.h   7 Jul 2009 21:41:43 -0000       1.16
> +++ winbase.h   13 Jul 2009 01:46:17 -0000
> @@ -56,7 +56,7 @@
>  {
>    return
>    ({
> -    register long ret __asm ("%eax");
> +    register long ret;
>      __asm __volatile ("lock cmpxchgl %2, %1"
>         : "=a" (ret), "=m" (*t)
>         : "r" (v), "m" (*t), "0" (c)
> 
> but does it really matter?  This causes the esi register to be used
> rather than the edx register.
> 
> with _asm ("%eax")
>     160e:       8b 5d 08                mov    0x8(%ebp),%ebx
>     1611:       8d 53 08                lea    0x8(%ebx),%edx
>     1614:       f0 0f b1 0a             lock cmpxchg %ecx,(%edx)
>     1618:       85 c0                   test   %eax,%eax
>     161a:       74 37                   je     1653 <pthread_mutex::_trylock(pthread*)+0x53>
> 
> without
>     1616:       8b 5d 08                mov    0x8(%ebp),%ebx
>     1619:       8d 73 08                lea    0x8(%ebx),%esi
>     161c:       f0 0f b1 0e             lock cmpxchg %ecx,(%esi)
>     1620:       85 c0                   test   %eax,%eax
>     1622:       74 44                   je     1668 <pthread_mutex::_trylock(pthread*)+0x68>
> 
> 
> And, more crucially, it compiles with gcc 3.4.
> 
> Should I check this variation in?

The affected operations have nothing to do with %eax.  Why does the
compiler change the usage of some entirely unrelated register?  This
looks suspicious.

Is there a chance that using the esi register obliterates data in the
calling function?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
