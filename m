From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] Mask mnemonics and expressions, help, version, getopts_long() for strace
Date: Sat, 17 Nov 2001 01:48:00 -0000
Message-ID: <20011117104821.A25284@cygbert.vinschen.de>
References: <NCBBIHCHBLCMLBLOBONKMEFPCHAA.g.r.vansickle@worldnet.att.net>
X-SW-Source: 2001-q4/msg00231.html
Message-ID: <20011117014800.nHprOg299I07zjQbOUEJ08Ig_KxvBwc_uder702Gbd0@z>

On Thu, Nov 15, 2001 at 07:24:12AM -0600, Gary R. Van Sickle wrote:
> 12th time's the charm;-)!:
> 
> 2001-11-15  Gary R. Van Sickle  <g.r.vansickle@worldnet.att.net>
> 
> 	* strace.cc (main): Change getopt() to getopt_long().
> 	Add support for help and version info.
> 	Use new parse_mask() function for -m/--mask option.
> 	(longopts): Add long options structure.
> 	(opts): Move options string from getopts call to static var.
> 	(usage): Print usage information.
> 	(SCCSid): Version info.
> 	(version): New function for displaying version info.
> 	(parse_mask): New function supporting parsing of mnemonics,
> 	hex, and basic expressions in masks.
> 	(mnemonic2ul): New mnemonic parsing function.
> 	(tag_mask_mnemonic): New type.
> 	(mnemonic_table): New table of mnemonics for mnemonic2ul() to
> 	search through.


Applied.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
