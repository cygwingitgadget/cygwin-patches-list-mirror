Return-Path: <cygwin-patches-return-4740-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29230 invoked by alias); 12 May 2004 00:56:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29216 invoked from network); 12 May 2004 00:56:48 -0000
Date: Wed, 12 May 2004 00:56:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: tty's on Terminal Services
Message-ID: <20040512005643.GA9634@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040511192134.007d4950@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040511192134.007d4950@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q2/txt/msg00092.txt.bz2

On Tue, May 11, 2004 at 07:21:34PM -0400, Pierre A. Humblet wrote:
>This patch allows the use of tty's from privileged
>accounts on Terminal Services.

What's your feeling for the dangerousness of this patch?  It looks very
reasonable (in fact it looks like a "DUH").  Do you think it's safe
to include given that 1.5.10 is imminent?

If so, please check in.

cgf


>2004-05-12  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* tty.h: Remove the %d or %x from all cygtty strings.
>	(tty::open_output_mutex): Only declare.
>	(tty::open_input_mutex): Ditto.
>	(tty::open_mutex): New definition.
>	* fhandlet_tty.cc (fhandler_tty_slave::open): Declare buf with
>	size CYG_MAX_PATH and replace __small_printf calls by shared_name.
>	* tty.cc (tty::create_inuse): Ditto.
>	(tty::get_event): Ditto.
>	(tty::common_init): Ditto.
>	(tty::open_output_mutex): New method definition.
>	(tty::open_input_mutex): Ditto.
>	(tty::open_mutex): New method.
