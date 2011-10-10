Return-Path: <cygwin-patches-return-7522-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29872 invoked by alias); 10 Oct 2011 09:53:26 -0000
Received: (qmail 29791 invoked by uid 22791); 10 Oct 2011 09:52:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 10 Oct 2011 09:52:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BED902CBDB0; Mon, 10 Oct 2011 11:52:29 +0200 (CEST)
Date: Mon, 10 Oct 2011 09:53:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add locale.exe option for querying Windows UI languages
Message-ID: <20111010095229.GB3189@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAHWeT-ar0PNJ83P64iKOZq9f-AmjzsAqA9J=BHW_M24=URbKEg@mail.gmail.com> <20111008150338.GA3189@calimero.vinschen.de> <CAHWeT-a1d2uGQNGmspRdqGOuTBNerv3g90zLwJW23n_UadV=GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHWeT-a1d2uGQNGmspRdqGOuTBNerv3g90zLwJW23n_UadV=GA@mail.gmail.com>
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
X-SW-Source: 2011-q4/txt/msg00012.txt.bz2

On Oct  9 11:31, Andy Koppe wrote:
> On 8 October 2011 16:03, Corinna Vinschen wrote:
> > Therefore, afaics, it would be better if we change locale to use the
> > GetFooDefaultUILanguage functions by default, and we add a modifier
> > (-r/--region?) to switch to LOCALE_FOO_DEFAULT.
> >
> > Either way, the usage output will have to be improved.  Maybe we should
> > explicitely state that the values printed refer to the Windows values,
> > and that one of them is the UI locale and the other is the... hmm...
> > how to say it..., maybe the "region settings locale" or so.
> 
> How about having one option for each of the Windows settings, and
> dividing the help output into groups, like so:
> 
> POSIX locale options:
>   -a, --all-locales    List all available supported locales
>   -c, --category-name  List information about given category NAME
>   -k, --keyword-name   Print information about given keyword NAME
>   -m, --charmaps       List all available character maps
> 
> Windows locale options:
>   -u, --user-lang      Print user default UI language
>   -s, --system-lang    Print system default UI language
>   -f, --format         Print user format setting for times, numbers & currency
>   -n, --non-unicode    Print system locale for non-Unicode programs
>   -U, --utf            Attach ".UTF-8" to the result
> 
> Other options:
>   -v, --verbose        More verbose output
>   -h, --help           This text

I had something like this grouping in mind, too.  I applied a matching
patch now.  The help text is just a bit different since it's based on
the output of the glibc locale --help text.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
