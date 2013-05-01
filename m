Return-Path: <cygwin-patches-return-7873-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1091 invoked by alias); 1 May 2013 00:31:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1079 invoked by uid 89); 1 May 2013 00:31:57 -0000
X-Spam-SWARE-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE autolearn=ham version=3.3.1
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72)    by sourceware.org (qpsmtpd/0.84/v0.84-167-ge50287c) with ESMTP; Wed, 01 May 2013 00:31:56 +0000
Received: from pool-173-76-41-247.bstnma.fios.verizon.net ([173.76.41.247] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1UXKxf-000JFT-14	for cygwin-patches@cygwin.com; Wed, 01 May 2013 00:31:55 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 3658660117	for <cygwin-patches@cygwin.com>; Tue, 30 Apr 2013 20:31:54 -0400 (EDT)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/P6m0dQhyw81HvFKcSM59L
Date: Wed, 01 May 2013 00:31:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] DocBook XML toolchain modernization
Message-ID: <20130501003154.GB3781@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130424185210.GE26397@calimero.vinschen.de> <51783EBC.30409@etr-usa.com> <20130425084305.GA29270@calimero.vinschen.de> <517F15AF.5080307@etr-usa.com> <20130430184703.GB6865@ednor.casa.cgf.cx> <51801469.9070606@etr-usa.com> <20130430190706.GC6865@ednor.casa.cgf.cx> <51802510.5000803@etr-usa.com> <20130430202737.GA1858@ednor.casa.cgf.cx> <51803D76.5010302@etr-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51803D76.5010302@etr-usa.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2013-q2/txt/msg00011.txt.bz2

On Tue, Apr 30, 2013 at 03:53:58PM -0600, Warren Young wrote:
>On 4/30/2013 14:27, Christopher Faylor wrote:
>> On Tue, Apr 30, 2013 at 02:09:52PM -0600, Warren Young wrote:
>>>   Embedding <html> within <html> is eeevil.
>>
>> faq.html is a pretty simple file and it seems to work.  Are there any
>> non-religious advantages to doing this?
>
>Conceivably browsers could stop tolerating it.

Yeah, that's what I thought you'd say.  I don't think it's worth the
effort and expense of duplicating Cygwin's CSS elsewhere but maybe
there's a clever way to avoid the html nesting which wouldn't require
that.

>>> - Any comments about the other items in my FUTURE WORK section?
>>> Unconditional green light, or do you want to approve them one by one?
>>
>> You have the right to change anything in the doc directory.  Anything
>> outside of that will require approval.
>
>The final removal of doctool requires replacing the DOCTOOL/SGML 
>comments in winsup/cygwin/{path,pinfo}.cc with Doxygen comments, and 
>folding most of the contents of winsup/cygwin/*.sgml into Doxygen 
>comments within the relevant source files.

I'd rather just move this out of the code entirely.  The user visible
interfaces aren't going to change and we haven't made a habit of
adding new DOCTOOL tags.  I don't know who first thought that adding
these was a good idea (it may predate my time on the project even
though CVS insists that I added it with version 1.1) but, if Corinna
agrees when she gets back, I'd like to just get rid of these.

cgf
