Return-Path: <cygwin-patches-return-5779-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22829 invoked by alias); 1 Mar 2006 22:25:09 -0000
Received: (qmail 22804 invoked by uid 22791); 1 Mar 2006 22:25:08 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 01 Mar 2006 22:25:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 237BD544001; Wed,  1 Mar 2006 23:25:02 +0100 (CET)
Date: Wed, 01 Mar 2006 22:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] regtool: Add load/unload commands and --binary option
Message-ID: <20060301222502.GW3184@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <43D6876F.9080608@t-online.de> <20060125105240.GM8318@calimero.vinschen.de> <43D7E666.8080803@t-online.de> <20060126091944.GT8318@calimero.vinschen.de> <20060211103418.GM14219@calimero.vinschen.de> <43F0E145.6080109@t-online.de> <20060215104302.GA13856@calimero.vinschen.de> <4405F274.6080009@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4405F274.6080009@t-online.de>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00088.txt.bz2

On Mar  1 20:13, Christian Franke wrote:
> Attached is version 2 of the patch, including an update of utils.sgml
> 
> REG_BINARY can now be ether read as binary from stdin:
> 
> $ echo 0: 01 02 FE FF | xxd -r | regtool -b set KEY/BINVALUE -
> 
> $ regtool get KEY/BINVALUE | regtool -b set KEY/BINVALUE -
> 
> or specified as hex arguments:
> 
> $ regtool -b set KEY/BINVALUE 01 02 FE FF
> 
> $ x=$(regtool -b get KEY/BINVALUE)
> $ regtool -b set KEY/BINVALUE $x
> 
> 
> The load/unload actions are unchanged.
> 
> Christian
> 
> =====================
> 
> 2006-03-01  Christian Franke <franke@computer.org>
> 
>        * regtool.cc: Add actions load/unload and option -b, --binary.
>        * utils.sgml (regtool): Document it.

Your patch looks pretty good to me, but I have a few minor nits.

First, be a bit more verbose in your ChangeLog entry.  Add explicit
entries for each changed function or global datastructure.

> retrieving revision 1.19
> diff -u -r1.19 regtool.cc

Could you please use diff -up?  It helps (at least me) navigating through
a patch.

> +	  cygwin_conv_to_win32_path(argv[1], win32_path);

This happens a couple of times.  When you're calling functions, could
you please always add a space between the function name and the opening
parenthesis?

> +	  rv = RegLoadKey(base, n, win32_path);

Ditto, etc.

>    //printf("key `%s' value `%s'\n", n, value);

Why is this printf commented out?  If it's not needed, please remove.

> @@ -577,7 +647,14 @@
>    switch (vtype)
>      {
>      case REG_BINARY:
> -      fwrite (data, dsize, 1, stdout);
> +      if (key_type == KT_BINARY)	// hack

Hack?  Why hack?  Otherwise, please remove this comment.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
