Return-Path: <cygwin-patches-return-4299-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9455 invoked by alias); 15 Oct 2003 08:23:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9446 invoked from network); 15 Oct 2003 08:23:46 -0000
Date: Wed, 15 Oct 2003 08:23:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Ncurses frame drawing
Message-ID: <20031015082345.GI14344@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20031014145507.GC14344@cygbert.vinschen.de> <3F8C5BF3.4050200@student.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8C5BF3.4050200@student.tue.nl>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00018.txt.bz2

Good idea, that.  I've applied the patch with two small change:

On Tue, Oct 14, 2003 at 10:26:27PM +0200, Micha Nelissen wrote:
> Index: fhandler_console.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
> retrieving revision 1.115
> diff -u -w -r1.115 fhandler_console.cc
> --- fhandler_console.cc	27 Sep 2003 02:36:50 -0000	1.115
> +++ fhandler_console.cc	14 Oct 2003 20:20:51 -0000
> @@ -66,6 +66,13 @@
>  inline BOOL
>  str_to_con (char *d, const char *s, DWORD sz)
>  {
> +  if (alternate_charset_active)
> +    {
> +      /* no translation when alternate charset is active */
> +      memcpy(d, s, sz);
> +      return TRUE;
> +    }
> +  else
>    return cp_convert (GetConsoleOutputCP (), d, get_cp (), s, sz);
  ^^^^^^^^^^
  this requires to either reindent the `return' statement or, since the
  `then' part of the if-clause returns anyway, do without the else at all.
  I removed the `else' here.

> 2003-10-13  Micha Nelissen  <M.Nelissen@student.tue.nl>
> 
>         * fhandler_console.cc (char_command): Add escape sequence for codepage
>         ansi <-> oem switching for ncurses frame drawing capabilities.
> 
>         * dcrt0.cc: Add local variable alternate_charset_active.
> 
>         * winsup.h: Add global external variable alternate_charset_active.

The ChangeLog entries are fine, I've just removed the empty lines between
them.  We're using empty lines mostly only to separate two distinct groups
of patches in one entry.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
