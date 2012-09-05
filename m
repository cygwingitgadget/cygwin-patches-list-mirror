Return-Path: <cygwin-patches-return-7720-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26468 invoked by alias); 5 Sep 2012 14:48:35 -0000
Received: (qmail 26432 invoked by uid 22791); 5 Sep 2012 14:48:31 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-01-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.71)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 Sep 2012 14:48:18 +0000
Received: from pool-173-76-55-36.bstnma.fios.verizon.net ([173.76.55.36] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1T9Gtt-000KzP-Ut	for cygwin-patches@cygwin.com; Wed, 05 Sep 2012 14:48:18 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 224D6428012	for <cygwin-patches@cygwin.com>; Wed,  5 Sep 2012 10:48:17 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18BLjV9A7MOr8nkR3PYsKgU
Date: Wed, 05 Sep 2012 14:48:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
Message-ID: <20120905144817.GA7309@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <503982F3.9010004@gmail.com> <20120902102718.GC13401@calimero.vinschen.de> <50439CAE.6080603@gmail.com> <50441E6B.7060703@cwilson.fastmail.fm> <504479A3.6080609@users.sourceforge.net> <20120903103518.GK13401@calimero.vinschen.de> <50448E3E.208@users.sourceforge.net> <20120903112428.GN13401@calimero.vinschen.de> <504757C5.80203@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504757C5.80203@users.sourceforge.net>
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
X-SW-Source: 2012-q3/txt/msg00041.txt.bz2

On Wed, Sep 05, 2012 at 09:46:45PM +0800, JonY wrote:
>On 9/3/2012 19:24, Corinna Vinschen wrote:
>> It differs a lot from the original source, so you might contemplate
>> to send a follow up mail to the mingw-w64 devel with the attached
>> patch.
>
>It looks like mingw-w64 is already using it all along according to Kai.

Using what exactly?  There's no way that they could be using Corinna's
version since it is new.

cgf
