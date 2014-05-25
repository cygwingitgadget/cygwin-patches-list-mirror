Return-Path: <cygwin-patches-return-7986-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21799 invoked by alias); 25 May 2014 03:53:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21780 invoked by uid 89); 25 May 2014 03:53:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-01-ewr.mailhop.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Sun, 25 May 2014 03:53:41 +0000
Received: from pool-98-110-183-166.bstnma.fios.verizon.net ([98.110.183.166] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1WoPVD-000EeX-Jo	for cygwin-patches@cygwin.com; Sun, 25 May 2014 03:53:39 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 2AEDB600E3	for <cygwin-patches@cygwin.com>; Sat, 24 May 2014 23:53:38 -0400 (EDT)
Received: by ednor (sSMTP sendmail emulation); Sat, 24 May 2014 23:53:38 -0400
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18XdBFARkW3DSbAKBhAmM/J
Date: Sun, 25 May 2014 03:53:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Rename detached debug info as cygwin1.dll.dbg
Message-ID: <20140525035338.GA7252@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <537F4FD9.8050203@dronecode.org.uk> <20140523140534.GB750@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140523140534.GB750@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q2/txt/msg00009.txt.bz2

On Fri, May 23, 2014 at 04:05:34PM +0200, Corinna Vinschen wrote:
>On May 23 14:40, Jon TURNEY wrote:
>> 
>> Not sure if this is wanted, and it obviously has some knock on effects on
>> package and snapshot generation.
>> 
>> But, cygport names detached debug info files by appending the .dbg suffix.
>> This is 'obviously correct' as it means that both a foo.exe and foo.dll can
>> exist and have detached debug info.
>> 
>> For consistency, the attached patch changes the name of the detached debug
>> info file for cygwin1.dll from cygwin1.dbg to cygwin1.dll.dbg
>
>As far as releases go, this is ok.  I'll just have to tweak the next
>cygport file slightly.
>
>Chris might have to tweak the snapshot generation script as well, so
>he probably wants to chime in, too.

It's more than just a tweak.  I've known that there is a discrepancy for
a long time but haven't considered it that big a deal.  I'd prefer that
this change not be made.
