Return-Path: <cygwin-patches-return-6383-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17254 invoked by alias); 9 Dec 2008 16:11:24 -0000
Received: (qmail 17239 invoked by uid 22791); 9 Dec 2008 16:11:22 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 09 Dec 2008 16:10:26 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 7A0B46D4356; Tue,  9 Dec 2008 17:12:21 +0100 (CET)
Date: Tue, 09 Dec 2008 16:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: <resolv.h> requires <netinet/in.h>
Message-ID: <20081209161221.GO12905@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <493DA370.30006@users.sourceforge.net> <024501c95989$2c07cc70$940410ac@wirelessworld.airvananet.com> <493DB346.2070909@users.sourceforge.net> <20081209092302.GA31008@calimero.vinschen.de> <028f01c95a10$9b232c80$940410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028f01c95a10$9b232c80$940410ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00027.txt.bz2

On Dec  9 10:12, Pierre A. Humblet wrote:
> I don't know why the original resolv.h didn't include netinet/in.h and 
> I have no problem adding it in Cygwin, given it was added in Linux.
> The minires package is nearing its life end, so I would make the change
> starting with the built-in resolver.

Ok.  I applied Yaakov's patch.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
