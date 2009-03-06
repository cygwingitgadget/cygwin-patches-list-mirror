Return-Path: <cygwin-patches-return-6430-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22321 invoked by alias); 6 Mar 2009 14:49:46 -0000
Received: (qmail 22293 invoked by uid 22791); 6 Mar 2009 14:49:45 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-42-111.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.42.111)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Mar 2009 14:49:40 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 7BDB613C022 	for <cygwin-patches@cygwin.com>; Fri,  6 Mar 2009 09:49:29 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 121E52B385; Fri,  6 Mar 2009 09:49:28 -0500 (EST)
Date: Fri, 06 Mar 2009 14:49:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] gethostbyname2  again
Message-ID: <20090306144928.GA5418@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net> <20090303153801.GA17180@ednor.casa.cgf.cx> <0b1b01c99c28$8a2c6540$4e0410ac@wirelessworld.airvananet.com> <20090306054449.GA3971@ednor.casa.cgf.cx> <029a01c99e69$94a1dbc0$4e0410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <029a01c99e69$94a1dbc0$4e0410ac@wirelessworld.airvananet.com>
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
X-SW-Source: 2009-q1/txt/msg00028.txt.bz2

On Fri, Mar 06, 2009 at 09:41:00AM -0500, Pierre A. Humblet wrote:
>
>----- Original Message ----- 
>[snip]

I see you've joined the throng of people who duplicate bits from the
header in the body of a message.  Do you really need to do this?

>
>| On Tue, Mar 03, 2009 at 12:50:21PM -0500, Pierre A. Humblet wrote:
>| >
>| >To avoid real-time checks, I could do as what dup_ent does, and have 4 versions
>| >of the realloc_ent function, one main one with dst and sz arguments (that one
>| >would be called by dup_ent without any  run-time checks) and 3 (actually only
>| >1 is needed for now) that invoke the main one with the correct dst based on the
>| >type of the src argument . The src argument would be null but would have the
>| >right type! That seems to meet your wishes. OK?
>| 
>| Yes.
>
>OK, here it the patch for realloc_ent. See also attachement.
>The third chunk (the change to dup_ent) is not essential.
>
>In addition in the patch that Corinna sent on March 3, the line
>+  ret = (hostent *) realloc_ent (sz, unionent::t_hostent);
>should be changed to
>ret = realloc_ent (sz,  (hostent *) NULL);
>
>In the Changelog the line
>  (dup_ent): Remove dst argument and call realloc_ent.
>should either be deleted or "Remove dst argument and c" should
>be replaced by "C".

This is ok with one very minor formatting nit.  Please check in with an
appropriate changelog.

>+static inline hostent *
>+realloc_ent (int sz, hostent * )
                                ^
                          extra space

cgf
