Return-Path: <cygwin-patches-return-6619-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23768 invoked by alias); 9 Sep 2009 15:59:19 -0000
Received: (qmail 23724 invoked by uid 22791); 9 Sep 2009 15:59:17 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-76-54-238.bstnma.fios.verizon.net (HELO cgf.cx) (173.76.54.238)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 09 Sep 2009 15:59:13 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id F281D13C0C4 	for <cygwin-patches@cygwin.com>; Wed,  9 Sep 2009 11:59:00 -0400 (EDT)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id BE3622B35F; Wed,  9 Sep 2009 11:59:00 -0400 (EDT)
Date: Wed, 09 Sep 2009 15:59:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
Message-ID: <20090909155900.GA29003@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20090903T175736-252@post.gmane.org>  <4AA01449.6060707@byu.net>  <20090903191856.GB3998@ednor.casa.cgf.cx>  <20090903210438.GA25677@calimero.vinschen.de>  <20090907200539.GA4489@ednor.casa.cgf.cx>  <20090908191657.GA17515@calimero.vinschen.de>  <20090908201635.GA25289@ednor.casa.cgf.cx>  <4AA7AFCE.2060705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AA7AFCE.2060705@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00073.txt.bz2

On Wed, Sep 09, 2009 at 02:38:22PM +0100, Dave Korn wrote:
>Christopher Faylor wrote:
>> On Tue, Sep 08, 2009 at 09:16:57PM +0200, Corinna Vinschen wrote:
>>> On Sep  7 16:05, Christopher Faylor wrote:
>>>> On Thu, Sep 03, 2009 at 11:04:38PM +0200, Corinna Vinschen wrote:
>>>>> Thanks for the patches Eric, but, here's a problem.  We still have no
>>>>> copyright assignment in place from you.  The fcntl patch is barely
>>>>> trivial, but the faccessat patch certainly isn't anymore.  Would it
>>>>> be a big problem for you to send the filled out copyright assignemnt form
>>>> >from http://cygwin.com/assign.txt to Red Hat ASAP?  With any luck it
>>>>> will have arrived and will be signed before I'm back from vacation.
>>>> I don't understand why this isn't considered trivial but a basically
>>>> equivalent change to fix other errnos is:
>>>>
>>>> http://cygwin.com/ml/cygwin/2009-09/msg00178.html
>>> It's 2 vs. 30 lines of changes.  That's hardly equivalent.
>> 
>> But each of those changes were obvious and each could have been
>> contributed separately, one for every function.  That would have
>> made them trivial.
>
>There's no simple answer to this, it seems.  On the one hand(*), the
>GNU maintainers' handbook suggests that multiple trivial patches /can/
>over time add up to a substantial contribution(**):

Perhaps it wasn't clear but I'm explaining the criteria that I've used
while running this project both when I worked for Red Hat and
subsequently.

But, regardless, if we were to follow the above advice then presumably
Eric's change in the cygwin list wouldn't be accepted either.

Of course, all of the hundreds of changes that have gone into newlib
really are suspect too.  Why is it ok to change something in one
directory and not another?  I think (and have always thought) that there
is a huge hole in that there are lots of changes in the newlib directory
which have never been assigned.

And, not too long ago (until I changed it) Cygwin was including parts of
libiberty which were definitely not owned by Red Hat.

cgf
