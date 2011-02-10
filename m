Return-Path: <cygwin-patches-return-7182-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27984 invoked by alias); 10 Feb 2011 14:09:16 -0000
Received: (qmail 27966 invoked by uid 22791); 10 Feb 2011 14:09:05 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 10 Feb 2011 14:09:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4469E2CA2C0; Thu, 10 Feb 2011 15:08:58 +0100 (CET)
Date: Thu, 10 Feb 2011 14:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] for SIGSEGV, compilation error in gcc 4.6
Message-ID: <20110210140858.GA25992@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <AANLkTinBrYcRrRBztY5eKWzon02GtB4t3S5BcLVoA_+D@mail.gmail.com> <20110210100236.GD2305@calimero.vinschen.de> <4D53DE66.2080805@gmail.com> <4D53EB3F.7010608@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4D53EB3F.7010608@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00037.txt.bz2

On Feb 10 08:42, Charles Wilson wrote:
> On 2/10/2011 7:47 AM, jojelino wrote:
> > On 2011-02-10 19:02, Corinna Vinschen wrote:
> > 
> >> Also, it would be nice if you would add more words to explain what your
> >> patch is doing.  Just a patch with no explanation is not very inviting
> >> to take a look at it at all.
> > 
> > this patch deals with only "two" problem. and this is "first" one.
> > 
> > static char * (*findenv_func)(const char *, int *) = (char *
> > (*)(const char *, int *)) getearly;
> > findenv_func is declared without __stdcall convention, and it is casting
> > getearly having __stdcall convention with function type without
> > __stdcall convention. to fix this problem, add __stdcall to findenv_func.
> 
> "two-liner"
> 
> +typedef char* (__stdcall *pfnenv)(const char*,int*);
> ...
> -static char * (*findenv_func)(const char *, int *) = (char *
> (*)(const char *, int *)) getearly;
> +static pfnenv findenv_func = &getearly;
> 
> 
> > and this is "another" one.
> > 
> > this one deals with compilation error that gcc 4.6 complained. so i just
> > copy & paste __attribute__((regparm (x))) from function declaration to
> > function definition, so i must admit that this one was derived from
> > original cygwin source code. that is, you can fix it without this patch.
> 
> "mechanical repetition of one-liner"
> 
> I think this patch qualifies under the minor change rule for not needing
> an assignment...although it would be good for the OP to go ahead and
> complete the paperwork for future contributions.
> 
> IANAL, blah blah...

Well, if you put it that way...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
