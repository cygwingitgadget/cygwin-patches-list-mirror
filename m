Return-Path: <cygwin-patches-return-6003-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4800 invoked by alias); 27 Nov 2006 15:18:08 -0000
Received: (qmail 4783 invoked by uid 22791); 27 Nov 2006 15:18:06 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-54.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.54)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 27 Nov 2006 15:18:01 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 9625413D3C7; Mon, 27 Nov 2006 10:17:59 -0500 (EST)
Date: Mon, 27 Nov 2006 15:18:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC][patch] cygwin/singal.h is not compatible with -std=c89 or -std=c99
Message-ID: <20061127151759.GA30938@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4568655E.6030403@sh.cvut.cz> <20061127083341.GB8385@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127083341.GB8385@calimero.vinschen.de>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00021.txt.bz2

On Mon, Nov 27, 2006 at 09:33:41AM +0100, Corinna Vinschen wrote:
>On Nov 25 16:46, V?clav Haisman wrote:
>> [FreeBSD]
>> struct sigaction {
>>         union {
>>                 void    (*__sa_handler)(int);
>>                 void    (*__sa_sigaction)(int, struct __siginfo *, void *);
>>         } __sigaction_u;                /* signal handler */
>>         int     sa_flags;               /* see signal options below */
>>         sigset_t sa_mask;               /* signal mask to apply */
>> };
>> 
>> #define sa_handler      __sigaction_u.__sa_handler
>> 
>> So, the attached patch is the minimal patch [...]
>
>>   struct sigaction
>>   {
>> !   __extension__ union
>>     {
>>       _sig_func_ptr sa_handler;  		/* SIG_DFL, SIG_IGN, or pointer to a function */
>>       void  (*sa_sigaction) ( int, siginfo_t *, void * );
>
>Thanks for the patch.  Looking into this, I'd rather use the FreeBSD
>approach, which is similary used in Linux.  Please try the below patch.

How about the alternative "Don't do that" approach?  I think there are
other parts of the header files which won't work with -std=c89.  I've
always been coding with the understanding that this is a GNU C environment.
I'm not sure that I am comfortable making a lot of accommodations for
a non GNU environment.

cgf
