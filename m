Return-Path: <cygwin-patches-return-7880-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15745 invoked by alias); 4 May 2013 05:27:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 15732 invoked by uid 89); 4 May 2013 05:27:50 -0000
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE autolearn=ham version=3.3.1
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Sat, 04 May 2013 05:27:49 +0000
Received: from pool-173-76-41-247.bstnma.fios.verizon.net ([173.76.41.247] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1UYV0d-000ERu-J9	for cygwin-patches@cygwin.com; Sat, 04 May 2013 05:27:47 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id D4F0260134	for <cygwin-patches@cygwin.com>; Sat,  4 May 2013 01:27:46 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18tSJBiKk/QkhdqqrZjht6t
Date: Sat, 04 May 2013 05:27:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130504052746.GA4222@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx> <51803D76.5010302@etr-usa.com> <20130501003154.GB3781@ednor.casa.cgf.cx> <51806FB3.5040902@etr-usa.com> <5181AFEA.9010301@etr-usa.com> <20130503203001.GA6868@ednor.casa.cgf.cx> <518438B0.1080206@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <518438B0.1080206@etr-usa.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q2/txt/msg00018.txt.bz2

On Fri, May 03, 2013 at 04:22:40PM -0600, Warren Young wrote:
>On 5/3/2013 14:30, Christopher Faylor wrote:
>> It looks like you broke the ability to build outside of the source tree.
>
>Sorry about that.
>
>It looks like you're in the middle of fixing it, so rather than fight 
>with you over the tree, I'll just let you continue.

I'm not in the middle of anything.  I checked in enough so that I can
once again build a snapshot.

>I've got one element of the fix here that you haven't yet checked in, 
>though.  You need to change the XInclude in cygwin-api.in.xml back to a 
>DOCTOOL directive:

I'm not planning on changing anything else.  If my change doesn't result
in usable documentation then I'd appreciate it if you would fix it.

cgf
