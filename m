Return-Path: <cygwin-patches-return-7520-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24603 invoked by alias); 8 Oct 2011 15:04:19 -0000
Received: (qmail 24572 invoked by uid 22791); 8 Oct 2011 15:03:58 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 08 Oct 2011 15:03:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CCAFE2CBDB0; Sat,  8 Oct 2011 17:03:38 +0200 (CEST)
Date: Sat, 08 Oct 2011 15:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add locale.exe option for querying Windows UI languages
Message-ID: <20111008150338.GA3189@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAHWeT-ar0PNJ83P64iKOZq9f-AmjzsAqA9J=BHW_M24=URbKEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHWeT-ar0PNJ83P64iKOZq9f-AmjzsAqA9J=BHW_M24=URbKEg@mail.gmail.com>
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
X-SW-Source: 2011-q4/txt/msg00010.txt.bz2

Hi Andy,

On Oct  8 10:24, Andy Koppe wrote:
> The attached patch adds a --interface/-i option to locale.exe that
> makes the --system/-s and --user/-u options print the respective
> default UI language instead of the default locale.
> 
> 	* locale.cc: Add --interface option for printing Windows default UI
> 	languages.
> 
> For background, here's what Windows' various default locales and languages do:
> 
> - LOCALE_USER_DEFAULT: This reflects the setting on the Formats tab of
> the (Windows 7) Region&Language control panel, which affects the
> format of times, dates, numbers, and currency.
> 
> - LOCALE_SYSTEM_DEFAULT: This reflects the "Language for non-Unicode
> programs" on the Adminstrative tab of Region&Language control panel,
> which also determines the ANSI and OEM codepages.
> 
> - GetUserDefaultUILanguage(): This is the current user's Windows UI
> language, also called display language. On Windows installs with
> multiple UI languages, a setting for this appears on the "Keyboards
> and Languages" tab of the Region&Language control panel.
> 
> - GetSystemDefaultUILanguage(): The is the system-wide UI language
> used for things that aren't user-specific, e.g. the login screen. As
> far as I know it's determined at Windows install time and can''t be
> changed.

I like the idea of the patch, but I'm wondering if this is the right
approach.  I wasn't aware of the difference between the LOCALE_FOO_DEFAULT
values and what the GetFooDefaultUILanguage functions return, otherwise
I would have probably used the GetFooDefaultUILanguage functions right from
the start.

What I mean is this.  The locale -u/-s functionality was supposed to be
used to set the $LANG value preferredly.  Since LANG means language in
the first place, the UI language is a much more natural choice for the
default -s/-u functionality, isn't it?

Therefore, afaics, it would be better if we change locale to use the
GetFooDefaultUILanguage functions by default, and we add a modifier
(-r/--region?) to switch to LOCALE_FOO_DEFAULT.

Either way, the usage output will have to be improved.  Maybe we should
explicitely state that the values printed refer to the Windows values,
and that one of them is the UI locale and the other is the... hmm...
how to say it..., maybe the "region settings locale" or so.

> Looking at those, and if we wanted to base the Cygwin locale settings
> on the Windows ones, I think LC_NUMERIC, LC_TIME, and LC_MONETARY
> should be determined by LOCALE_USER_DEFAULT, but LC_MESSAGES should be
> determined by GetUserDefaultUILanguage(). Not sure about LC_CTYPE and
> LC_COLLATE, but I suppose it would make sense for character
> classification and sorting to match the UI language.

The system should not set the LC_xxx values at all.  From my POV the
system should only default to some $LANG, while setting the LC_xxx
values is the job of the user if the $LANG value doesn't suffice.
However, if the user wants to do that, we will have the new flag.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
