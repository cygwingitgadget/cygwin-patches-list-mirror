Return-Path: <cygwin-patches-return-5565-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24690 invoked by alias); 9 Jul 2005 08:22:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24501 invoked by uid 22791); 9 Jul 2005 08:22:48 -0000
Received: from p54940fb4.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.15.180)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sat, 09 Jul 2005 08:22:48 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7526B6D4237; Sat,  9 Jul 2005 10:22:57 +0200 (CEST)
Date: Sat, 09 Jul 2005 08:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Add get{delim,line} symbol alias to avoid autoconf detection failures
Message-ID: <20050709082257.GP7507@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cd3b087a05070822235f78def6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd3b087a05070822235f78def6@mail.gmail.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00020.txt.bz2

On Jul  9 01:23, Nicholas Wourms wrote:
> Hi Corinna,
> 
> I saw that you exported __get{delim,line} in the cygwin dll.  I've had
> this modification locally for awhile now.  There are a number of
> autoconfiscated applications which check for these functions and use
> them if present.  Unfortunately, autoconf's AC_CHECK_FUNCS will not
> pickup CPP definitions in headers because the test links to the c
> library using a phony prototype.  Thus, in order to facilitate
> autoconf, I've added the necessary resource aliases.  I've also taken
> the liberty of replacing the CPP definitions with actual function
> prototypes for  improved clarity.   The patch for doing these
> operations is attached.  I hope you find it satisfactory.

Thanks, applied.  I've just shortened the ChangeLog slightly.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
