Return-Path: <cygwin-patches-return-4297-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17278 invoked by alias); 15 Oct 2003 03:20:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17269 invoked from network); 15 Oct 2003 03:20:13 -0000
Message-Id: <3.0.5.32.20031014231622.0082c1b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 15 Oct 2003 03:20:00 -0000
To: Micha Nelissen <M.Nelissen@student.tue.nl>,
 Corinna Vinschen <cygwin-patches@cygwin.com>
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Ncurses frame drawing
In-Reply-To: <3F8C5BF3.4050200@student.tue.nl>
References: <20031014145507.GC14344@cygbert.vinschen.de>
 <20031014145507.GC14344@cygbert.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q4/txt/msg00016.txt.bz2

At 10:26 PM 10/14/2003 +0200, Micha Nelissen wrote:
>@@ -1110,6 +1117,12 @@
> 	       break;
> 	     case 9:    /* dim */
> 	       dev_state->intensity = INTENSITY_DIM;
>+	       break;
>+             case 10:   /* end alternate charset */
>+               alternate_charset_active = FALSE;
>+	       break;
>+             case 11:   /* start alternate charset */
>+               alternate_charset_active = TRUE;
> 	       break;
> 	     case 24:
> 	       dev_state->underline = FALSE;

FWIW, wouldn't it be cleaner to make "alternate_charset_active" a 
member of dev_state instead of introducing a new global variable?

Pierre
