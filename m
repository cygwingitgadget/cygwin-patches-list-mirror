Return-Path: <cygwin-patches-return-4797-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24865 invoked by alias); 30 May 2004 17:20:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24851 invoked from network); 30 May 2004 17:20:25 -0000
Date: Sun, 30 May 2004 17:20:00 -0000
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make add_item smarter
Message-ID: <20040530172025.GA3873@coe.bosbc.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040530010121.007cd970@incoming.verizon.net> <20040530043431.GA12896@coe.bosbc.com> <3.0.5.32.20040530002148.0081b840@incoming.verizon.net> <3.0.5.32.20040530002148.0081b840@incoming.verizon.net> <3.0.5.32.20040530103810.007d3910@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040530103810.007d3910@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
yrom: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
From: cgf@timesys.com (Christopher Faylor)
X-SW-Source: 2004-q2/txt/msg00149.txt.bz2

On Sun, May 30, 2004 at 10:38:10AM -0400, Pierre A. Humblet wrote:
>At 09:41 AM 5/30/2004 -0400, Pierre A. Humblet wrote:
>>Here it is again, after a cup of coffee and some extra cleanup.
>>
>
>Oops, use this one instead.
>
>2004-05-30  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* path.cc (mount_info::add_item): Make sure native path has drive 
>	or UNC form. Call normalize_xxx_path instead of [back]slashify.
>	Remove test for double slashes. Reorganize to always debug_print. 

Go ahead and checkin.

Thanks.
cgf
