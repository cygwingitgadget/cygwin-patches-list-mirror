Return-Path: <cygwin-patches-return-1747-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 10907 invoked by alias); 18 Jan 2002 23:27:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10848 invoked from network); 18 Jan 2002 23:27:21 -0000
Date: Fri, 18 Jan 2002 15:27:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: Dennis Vshivkov <walrus@amur.ru>
Cc: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] No codepage translation in cygwin console
Message-ID: <20020119002711.A24934@cygbert.vinschen.de>
Mail-Followup-To: Dennis Vshivkov <walrus@amur.ru>,
	cygpatch <cygwin-patches@cygwin.com>
References: <20020115194622.A3962@amur.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020115194622.A3962@amur.ru>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00104.txt.bz2

On Tue, Jan 15, 2002 at 07:46:22PM +0300, Dennis Vshivkov wrote:
>     Hello.
> 
>     There are times when it's very convenient to change Windows console
> codepage using chcp.com, for example, an interactive ssh session to a host
> with a different codepage used.  Unfortunately, the current release of cygwin
> enforces either of the two main codepages, ansi or oem, to be used, mainly
> because of considerations of their importance for filename and clipboard
> conversions, etc.  There's a patch attached, it extends functionality of the
> `codepage' option, set in CYGWIN environment variable, to allow for setting no
> codepage translation of console input and output.
> 
>     The way the option should look now is
> 
>     codepage=ansi|oem[:con-asis]
> 
>     If con-asis suboption is specified, console input and output goes
> unchanged.  Hope this helps someone.

Hi,

actually your patch seems to be useful when having to switch
between different codepages.

But I have two problems with that patch:

- First of all, your patch isn't `trivial' enough so that we
  can incorporate it without getting a signed copyright assignment
  form from you as described on http://cygwin.com/contrib.html.
  Please send us the signed form via snail mail.  As soon as we
  received it we can use your patch.

- Your ChangeLog entry isn't correctly indented.  And please use
  your real name, not a pseudonym.

Otherwise I'd be happy to apply your patch to Cygwin.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
