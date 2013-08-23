Return-Path: <cygwin-patches-return-7895-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26274 invoked by alias); 23 Aug 2013 20:22:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26231 invoked by uid 89); 23 Aug 2013 20:22:40 -0000
X-Spam-SWARE-Status: No, score=-0.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE autolearn=ham version=3.3.2
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Fri, 23 Aug 2013 20:22:39 +0000
Received: from pool-173-48-46-190.bstnma.fios.verizon.net ([173.48.46.190] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1VCxsU-000CGE-AD	for cygwin-patches@cygwin.com; Fri, 23 Aug 2013 20:22:38 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 64EB060066	for <cygwin-patches@cygwin.com>; Fri, 23 Aug 2013 16:22:37 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX19f9ANwuLAmPb/Biea+dpWr
Date: Fri, 23 Aug 2013 20:22:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygcheck -p
Message-ID: <20130823202237.GF4503@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <announce.20130823172713.GA6948@ednor.casa.cgf.cx> <20130823192251.GA3454@ednor.casa.cgf.cx> <5217BC12.9040601@users.sourceforge.net> <5217C1EC.9010606@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5217C1EC.9010606@users.sourceforge.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q3/txt/msg00002.txt.bz2

On Fri, Aug 23, 2013 at 03:11:24PM -0500, Yaakov (Cygwin/X) wrote:
>On 2013-08-23 14:46, Yaakov (Cygwin/X) wrote:
>> On 2013-08-23 14:22, Christopher Faylor wrote:
>>> On Fri, Aug 23, 2013 at 01:27:13PM -0400, Christopher Faylor wrote:
>>>> I'm working on bringing Cygwin's package search into the multi-arch
>>>> world so it will be down for a while while I tweak things.
>>>
>>> This went much faster than I expected.  The new package interface allows
>>> you to switch between x86 and x86_64 when searching for or displaying
>>> packages.
>>>
>>> This interface now uses javascript to control which arch is displayed.
>>
>> Patch to adapt 'cygcheck -p' for this change attached.
>
>Never mind, cgf fixed this already.

I had it sitting in my sandbox, ready to check in but I've been
investigating an odd snapshot-generation problem.

cgf
