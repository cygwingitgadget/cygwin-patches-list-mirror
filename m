Return-Path: <cygwin-patches-return-4601-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1526 invoked by alias); 12 Mar 2004 03:11:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1517 invoked from network); 12 Mar 2004 03:11:52 -0000
Date: Fri, 12 Mar 2004 03:11:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Signal mask handling
Message-ID: <20040312031150.GA9217@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net> <3.0.5.32.20040310232619.007fac50@incoming.verizon.net> <3.0.5.32.20040310232619.007fac50@incoming.verizon.net> <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net> <3.0.5.32.20040311210405.007f81e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040311210405.007f81e0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00091.txt.bz2

On Thu, Mar 11, 2004 at 09:04:05PM -0500, Pierre A. Humblet wrote:
>2004-02-11  Pierre Humblet <pierre.humblet@ieee.org>
>	
>	* cygtls.h (_cygtls::newmask): Delete member.
>	(_cygtls::newmask): New member.
>	* gendef (_sigdelayed): Replace the call to 
>	set_process_mask by a call to set_process_mask_delta.
>	* exceptions.cc (handle_sigsuspend): Do not filter tempmask.
>	Or SIG_NONMASKABLE in deltamask as a flag.
>	(_cygtls::interrupt_setup): Set deltamask only.
>	(set_process_mask_delta): New function.
>	(_cygtls::call_signal_handler): Replace the first call to 
>	set_process_mask by a call to set_process_mask_delta.

I checked this in with a minor tweak to the ChangeLog and a minor change
to _cygtls::call_signal_handler to use set_signal_mask.  Now only one
place uses set_process_mask.

Thanks.

cgf
