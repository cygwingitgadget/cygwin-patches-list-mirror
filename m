Return-Path: <cygwin-patches-return-6618-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4254 invoked by alias); 9 Sep 2009 13:24:32 -0000
Received: (qmail 4174 invoked by uid 22791); 9 Sep 2009 13:24:30 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-bw0-f207.google.com (HELO mail-bw0-f207.google.com) (209.85.218.207)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 09 Sep 2009 13:24:26 +0000
Received: by bwz3 with SMTP id 3so423552bwz.2         for <cygwin-patches@cygwin.com>; Wed, 09 Sep 2009 06:24:23 -0700 (PDT)
Received: by 10.223.143.73 with SMTP id t9mr316949fau.14.1252502662740;         Wed, 09 Sep 2009 06:24:22 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id h2sm1497227fkh.6.2009.09.09.06.24.21         (version=SSLv3 cipher=RC4-MD5);         Wed, 09 Sep 2009 06:24:21 -0700 (PDT)
Message-ID: <4AA7AFCE.2060705@gmail.com>
Date: Wed, 09 Sep 2009 13:24:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [1.7] bugs in faccessat
References: <loom.20090903T175736-252@post.gmane.org>  <4AA01449.6060707@byu.net>  <20090903191856.GB3998@ednor.casa.cgf.cx>  <20090903210438.GA25677@calimero.vinschen.de>  <20090907200539.GA4489@ednor.casa.cgf.cx>  <20090908191657.GA17515@calimero.vinschen.de> <20090908201635.GA25289@ednor.casa.cgf.cx>
In-Reply-To: <20090908201635.GA25289@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00072.txt.bz2

Christopher Faylor wrote:
> On Tue, Sep 08, 2009 at 09:16:57PM +0200, Corinna Vinschen wrote:
>> On Sep  7 16:05, Christopher Faylor wrote:
>>> On Thu, Sep 03, 2009 at 11:04:38PM +0200, Corinna Vinschen wrote:
>>>> Thanks for the patches Eric, but, here's a problem.  We still have no
>>>> copyright assignment in place from you.  The fcntl patch is barely
>>>> trivial, but the faccessat patch certainly isn't anymore.  Would it
>>>> be a big problem for you to send the filled out copyright assignemnt form
>>> >from http://cygwin.com/assign.txt to Red Hat ASAP?  With any luck it
>>>> will have arrived and will be signed before I'm back from vacation.
>>> I don't understand why this isn't considered trivial but a basically
>>> equivalent change to fix other errnos is:
>>>
>>> http://cygwin.com/ml/cygwin/2009-09/msg00178.html
>> It's 2 vs. 30 lines of changes.  That's hardly equivalent.
> 
> But each of those changes were obvious and each could have been
> contributed separately, one for every function.  That would have
> made them trivial.

  There's no simple answer to this, it seems.  On the one hand(*), the GNU
maintainers' handbook suggests that multiple trivial patches /can/ over time
add up to a substantial contribution(**):

> A change of just a few lines (less than 15 or so) is not legally
> significant for copyright. A regular series of repeated changes, such as
> renaming a symbol, is not legally significant even if the symbol has to be
> renamed in many places. Keep in mind, however, that a series of minor
> changes by the same person can add up to a significant contribution. What
> counts is the total contribution of the person; it is irrelevant which
> parts of it were contributed when.

  On the other hand, for example, in accord with the second sentence of that
paragraph, binutils just accepted a *huge* patch without an assignment - but
it was completely mechanical (renaming symbols to avoid c++ compilation
errors).  There's going to be a big gray area in between this kind of trivial,
potentially-automatable mechanical replacement that is obviously OK and the
level of a patch with (e.g.) a big bunch of new functions or code that is
obviously not OK (without an assignment).  I'm not sure where this patch
falls, except to say that it's in there somewhere.  I think I'd be inclined to
accept it if anyone argued that the repeated cutting-and-pasting of the
set_errno hunk was one change with some mechanical repetition and counted it
as only five lines.

    cheers,
      DaveK
-- 
(*) - disclaimer: Cygwin is of course a RedHat project and so need not operate
to the same standards as the FSF holds to; examples are only examples and not
represented as definitive, canonical, or legally binding; contents may have
settled in shipping or packing; YMMV, IANALATEIHSMBSI, fnord!

(**) - http://www.gnu.org/prep/maintain/maintain.html#Legally-Significant
