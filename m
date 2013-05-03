Return-Path: <cygwin-patches-return-7878-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7536 invoked by alias); 3 May 2013 20:30:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7518 invoked by uid 89); 3 May 2013 20:30:03 -0000
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,RCVD_IN_SEMBACKSCATTER autolearn=no version=3.3.1
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Fri, 03 May 2013 20:30:03 +0000
Received: from pool-173-76-41-247.bstnma.fios.verizon.net ([173.76.41.247] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1UYMcD-000Jpt-U1	for cygwin-patches@cygwin.com; Fri, 03 May 2013 20:30:01 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 65B116012F	for <cygwin-patches@cygwin.com>; Fri,  3 May 2013 16:30:01 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX18/hySmHGXVKwAo/68rBhNp
Date: Fri, 03 May 2013 20:30:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130503203001.GA6868@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx> <51803D76.5010302@etr-usa.com> <20130501003154.GB3781@ednor.casa.cgf.cx> <51806FB3.5040902@etr-usa.com> <5181AFEA.9010301@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5181AFEA.9010301@etr-usa.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q2/txt/msg00016.txt.bz2

On Wed, May 01, 2013 at 06:14:34PM -0600, Warren Young wrote:
>On 4/30/2013 19:28, Warren Young wrote:
>>
>> I have decided: the script shall be called bodysnatcher.pl. :)
>
>I've created this.  There is a new output, winsup/doc/faq/faq.body, 
>generated from faq.html whenever it changes.
>
>The core of the script is only about 10 lines, as expected.  Comments, 
>whitespace and error checking balloon that to 44 LOC.

It looks like you broke the ability to build outside of the source tree.
We don't support building *in* the source tree so that's a pretty serious
breakage.

% make
make: *** No rule to make target `faq*.xml', needed by `faq/faq.html'.  Stop.
