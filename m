Return-Path: <cygwin-patches-return-4291-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26273 invoked by alias); 13 Oct 2003 17:06:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26255 invoked from network); 13 Oct 2003 17:06:03 -0000
Date: Mon, 13 Oct 2003 17:06:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Ncurses frame drawing
Message-ID: <20031013170602.GN14344@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3F8AD512.20004@student.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8AD512.20004@student.tue.nl>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00010.txt.bz2

On Mon, Oct 13, 2003 at 06:38:42PM +0200, Micha Nelissen wrote:
> Hi,
> 
> Attached is a patch to enable correct ncurses frame drawing. It does so 
> by implementing the escape sequence for 'start/end alternate charset'. 
> This is code \E[11m and \E[10m respectively in the linux termcap.

This patch is a nice idea but it's not quite correct.  You can't
rely on "current_codepage" being ansi_cp.  Since the user can set
it to oem_cp in the CYGWIN environment variable, you have to memorize
the old value on \E[11m and to restore to the old value on \E[10m.

Corinna

> Regards,
> 
> Micha.

> Index: fhandler_console.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/fhandler_console.cc,v
> retrieving revision 1.115
> diff -u -w -r1.115 fhandler_console.cc
> --- fhandler_console.cc	27 Sep 2003 02:36:50 -0000	1.115
> +++ fhandler_console.cc	13 Oct 2003 16:31:13 -0000
> @@ -1111,6 +1111,12 @@
>  	     case 9:    /* dim */
>  	       dev_state->intensity = INTENSITY_DIM;
>  	       break;
> +             case 10:   /* end alternate charset */
> +               current_codepage = ansi_cp;
> +	       break;
> +             case 11:   /* start alternate charset */
> +               current_codepage = oem_cp;
> +	       break;
>  	     case 24:
>  	       dev_state->underline = FALSE;
>  	       break;

> 2003-10-13  Micha Nelissen  <M.Nelissen@student.tue.nl>
> 
> * fhandler_console.cc (char_command): added escape sequence for codepage
> ansi <-> oem switching for ncurses frame drawing capabilities.
> 


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
