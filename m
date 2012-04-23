Return-Path: <cygwin-patches-return-7646-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26634 invoked by alias); 23 Apr 2012 20:06:48 -0000
Received: (qmail 26622 invoked by uid 22791); 23 Apr 2012 20:06:47 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-01-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.71)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 23 Apr 2012 20:06:32 +0000
Received: from pool-98-110-183-154.bstnma.fios.verizon.net ([98.110.183.154] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1SMPWp-000Bmr-Qc	for cygwin-patches@cygwin.com; Mon, 23 Apr 2012 20:06:31 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 1825013C076	for <cygwin-patches@cygwin.com>; Mon, 23 Apr 2012 16:06:31 -0400 (EDT)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+MnzYDaklsyoBaf5WOmXxo
Date: Mon, 23 Apr 2012 20:06:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Building for nocygwin
Message-ID: <20120423200631.GC4504@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6BFA9AF2C7556E42AFF3F187ECAB07B802F9CFD0@bespdc01.mediaxim.local> <CA+sc5m=cKU5DaZFeJuEas-nfXD9uAsxq4V_9hcoUAM77u3OKNA@mail.gmail.com> <6BFA9AF2C7556E42AFF3F187ECAB07B802F9CFEF@bespdc01.mediaxim.local> <CA+sc5m=mC16bBFTBpPACoewcxKWt4KSsH22mUiVu0BrYCVObyQ@mail.gmail.com> <6BFA9AF2C7556E42AFF3F187ECAB07B802F9D004@bespdc01.mediaxim.local> <20120423140440.GG7097@calimero.vinschen.de> <6BFA9AF2C7556E42AFF3F187ECAB07B802F9D01E@bespdc01.mediaxim.local> <20120423153719.GB1133@ednor.casa.cgf.cx> <4F95AEF4.7040407@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F95AEF4.7040407@users.sourceforge.net>
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
X-SW-Source: 2012-q2/txt/msg00015.txt.bz2

On Mon, Apr 23, 2012 at 02:35:16PM -0500, Yaakov (Cygwin/X) wrote:
>On 2012-04-23 10:37, Christopher Faylor wrote:
>> On Mon, Apr 23, 2012 at 04:52:54PM +0200, Michel Bardiaux wrote:
>>> I *get* that. My problem was, the web is so cluttered with pages mentioning
>>> the no-cygwin thing (including the cygwin FAQ!) that finding a good howto is
>>> nearly impossible.
>>>
>>> Is there a deep reason not to amend the FAQ?
>>
>> No, there is no reason not to change the FAQ.
>>
>> Could someone provide some appropriate words?
>
>Patch attached.

Thanks very much.  Please check in (with typo correction mentioned in
followon mail).

I suspect that we'll probably need to flesh this out over time but at
least we aren't suggesting the use of a deprecated compiler option now.

cgf
