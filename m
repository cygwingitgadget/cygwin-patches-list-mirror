Return-Path: <cygwin-patches-return-7722-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8331 invoked by alias); 5 Sep 2012 15:10:34 -0000
Received: (qmail 8311 invoked by uid 22791); 5 Sep 2012 15:10:31 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_CG
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 Sep 2012 15:10:17 +0000
Received: from pool-173-76-55-36.bstnma.fios.verizon.net ([173.76.55.36] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1T9HFA-000240-9U	for cygwin-patches@cygwin.com; Wed, 05 Sep 2012 15:10:16 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 2BA9D42800E	for <cygwin-patches@cygwin.com>; Wed,  5 Sep 2012 11:10:15 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/IPz0xkFuM4vt3aRUoEQ7l
Date: Wed, 05 Sep 2012 15:10:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] suggestion for faster pseudo-reloc.
Message-ID: <20120905151015.GA7624@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20120902102718.GC13401@calimero.vinschen.de> <50439CAE.6080603@gmail.com> <50441E6B.7060703@cwilson.fastmail.fm> <504479A3.6080609@users.sourceforge.net> <20120903103518.GK13401@calimero.vinschen.de> <50448E3E.208@users.sourceforge.net> <20120903112428.GN13401@calimero.vinschen.de> <504757C5.80203@users.sourceforge.net> <20120905144817.GA7309@ednor.casa.cgf.cx> <504768CB.8090107@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504768CB.8090107@users.sourceforge.net>
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
X-SW-Source: 2012-q3/txt/msg00043.txt.bz2

On Wed, Sep 05, 2012 at 10:59:23PM +0800, JonY wrote:
>On 9/5/2012 22:48, Christopher Faylor wrote:
>> On Wed, Sep 05, 2012 at 09:46:45PM +0800, JonY wrote:
>>> On 9/3/2012 19:24, Corinna Vinschen wrote:
>>>> It differs a lot from the original source, so you might contemplate
>>>> to send a follow up mail to the mingw-w64 devel with the attached
>>>> patch.
>>>
>>> It looks like mingw-w64 is already using it all along according to Kai.
>> 
>> Using what exactly?  There's no way that they could be using Corinna's
>> version since it is new.
>> 
>> cgf
>> 
>
>It referring to the faster pseudo-reloc code.
>Quote from Kai:
>
>> Hi JonY,
>> 
>> there is no need for backporting this to our branch.  This patch is
>> originated by our trunk version and is already fixed there.
>> 
>> No port from that direction.

I don't believe that Corinna's patch originated in the mingw64 trunc
version.  The point of this effort was to try to keep the two code bases
in sync.  I'd be surprised if that was actually the case.  Maybe there
is some speed improvement in mingw64 (in which case, for shame for not
sharing with Cygwin) but I doubt that it has any common ancestry with
Corinna's patch.

cgf
