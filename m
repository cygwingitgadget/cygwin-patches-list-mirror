Return-Path: <cygwin-patches-return-6432-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25205 invoked by alias); 6 Mar 2009 16:33:04 -0000
Received: (qmail 25164 invoked by uid 22791); 6 Mar 2009 16:33:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 06 Mar 2009 16:32:57 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7F3C86D42F4; Fri,  6 Mar 2009 17:32:45 +0100 (CET)
Date: Fri, 06 Mar 2009 16:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] gethostbyname2  again
Message-ID: <20090306163245.GP10046@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0KFW0072QPTQUMJ2@vms173001.mailsrvcs.net> <20090303153801.GA17180@ednor.casa.cgf.cx> <0b1b01c99c28$8a2c6540$4e0410ac@wirelessworld.airvananet.com> <20090306054449.GA3971@ednor.casa.cgf.cx> <029a01c99e69$94a1dbc0$4e0410ac@wirelessworld.airvananet.com> <20090306144928.GA5418@ednor.casa.cgf.cx> <02d701c99e74$10b71a40$4e0410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02d701c99e74$10b71a40$4e0410ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00030.txt.bz2

On Mar  6 10:56, Pierre A. Humblet wrote:
> From: "Christopher Faylor" <cgf-use-the-mailinglist-please>
> | This is ok with one very minor formatting nit.  Please check in with an
> | appropriate changelog.
> | 
> | >+static inline hostent *
> | >+realloc_ent (int sz, hostent * )
> |                                ^
> |                          extra space
> 
> OK. I can't do that before Mon eve. It would be easier if Corinna could merge this
> patch and the previous one (she has the latest version) and apply the whole thing
> at once, with one changelog  block. 

Done.  Thanks again for this function.  This will give us a few new
occasions for the future, as I pointed out in my first reply.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
