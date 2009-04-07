Return-Path: <cygwin-patches-return-6495-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12087 invoked by alias); 7 Apr 2009 15:08:29 -0000
Received: (qmail 12052 invoked by uid 22791); 7 Apr 2009 15:08:27 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-58-89.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.58.89)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Apr 2009 15:08:20 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 21C9113C022 	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2009 11:08:10 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 1E802604025; Tue,  7 Apr 2009 11:08:10 -0400 (EDT)
Date: Tue, 07 Apr 2009 15:08:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix type inconsistencies in stdint.h
Message-ID: <20090407150810.GF22338@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <49D6B8D7.4020907@gmail.com> <20090404033545.GA3386@ednor.casa.cgf.cx> <49D6DDDD.4030504@gmail.com> <20090404062459.GB22452@ednor.casa.cgf.cx> <49D70B05.6020509@gmail.com> <20090407144659.GA22338@ednor.casa.cgf.cx> <49DB69BE.80203@cwilson.fastmail.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49DB69BE.80203@cwilson.fastmail.fm>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q2/txt/msg00037.txt.bz2

On Tue, Apr 07, 2009 at 10:57:02AM -0400, Charles Wilson wrote:
>Christopher Faylor wrote:
>> I don't entirely understand when people think it's ok to make sweeping
>> changes for 1.7 and when they think we need to be conservative.
>
>MHO is that 1.7+gcc4 is already such a sweeping change (e.g.
>"conservative" left the building sometime last year), that if we DO plan
>on any more such sweeping changes before cygwin2.dll it's better to do
>'em now.
>
>OTOH, if we DON'T actually plan on any more such changes, then there's
>no reason to make changes gratuitously, no matter how Just Mean We Are.
>
>> I think it is very regrettable that Cygwin doesn't have the same int
>> types as linux and it would be interesting to see how much would be
>> broken by changing these types.
>
>"Interesting" in the sense of the old Chinese curse [*], I assume?

Or as in the "WJM" aforementioned sense.

cgf
