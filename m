Return-Path: <cygwin-patches-return-1503-listarch-cygwin-patches=sourceware.cygnus.com@sources.redhat.com>
Received: (qmail 21806 invoked by alias); 17 Nov 2001 09:48:37 -0000
Mailing-List: contact cygwin-patches-help@sourceware.cygnus.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@sources.redhat.com>
List-Post: <mailto:cygwin-patches@sources.redhat.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@sources.redhat.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@sources.redhat.com
Received: (qmail 21592 invoked from network); 17 Nov 2001 09:48:34 -0000
Date: Sun, 14 Oct 2001 06:30:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: [PATCH] Mask mnemonics and expressions, help, version, getopts_long() for strace
Message-ID: <20011117104821.A25284@cygbert.vinschen.de>
Mail-Followup-To: Corinna Vinschen <cygwin-patches@cygwin.com>,
	cygwin-patches@sourceware.cygnus.com
References: <NCBBIHCHBLCMLBLOBONKMEFPCHAA.g.r.vansickle@worldnet.att.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NCBBIHCHBLCMLBLOBONKMEFPCHAA.g.r.vansickle@worldnet.att.net>; from g.r.vansickle@worldnet.att.net on Thu, Nov 15, 2001 at 07:24:12AM -0600
X-SW-Source: 2001-q4/txt/msg00035.txt.bz2

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
