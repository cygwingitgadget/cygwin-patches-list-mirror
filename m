Return-Path: <cygwin-patches-return-6835-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13350 invoked by alias); 11 Nov 2009 20:21:22 -0000
Received: (qmail 13335 invoked by uid 22791); 11 Nov 2009 20:21:21 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-77.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.77)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 11 Nov 2009 20:21:17 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 44A383B0002 	for <cygwin-patches@cygwin.com>; Wed, 11 Nov 2009 15:21:07 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 191542B352; Wed, 11 Nov 2009 15:21:06 -0500 (EST)
Date: Wed, 11 Nov 2009 20:21:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add get_nprocs, get_nprocs_conf
Message-ID: <20091111202106.GA17519@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AFA6675.6070408@users.sourceforge.net>  <20091111094119.GA3564@calimero.vinschen.de>  <4AFA907E.1050408@users.sourceforge.net>  <4AFAB42C.1020404@byu.net>  <4AFB0042.90602@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AFB0042.90602@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00166.txt.bz2

On Wed, Nov 11, 2009 at 12:19:46PM -0600, Yaakov (Cygwin/X) wrote:
>On 11/11/2009 06:55, Eric Blake wrote:
>> +1 on the concept from me, although why does sys/sysinfo.h have to
>> forward to cygwin/sysinfo.h, rather than directly declaring the two functions?
>
>I simply followed the pattern of many of the sys/*.h headers, and by 
>their copyright dates are relatively newer, which redirected to a 
>cygwin/*.h equivalent.  If there is supposed to be some rhyme and reason 
>to which ones redirect and which ones do not, please feel free to clue 
>me in. :-)

The only time I add a cygwin/foo.h is when newlib has a version of the
same file and I don't feel like wildly ifdef'ing it.

It looks like Corinna has added a few of these so I guess she'll have
to provide the r&r.

cgf
