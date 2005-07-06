Return-Path: <cygwin-patches-return-5558-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8680 invoked by alias); 6 Jul 2005 14:13:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8643 invoked by uid 22791); 6 Jul 2005 14:13:23 -0000
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 06 Jul 2005 14:13:23 +0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 6 Jul 2005 15:13:21 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: cygcheck exit status
Date: Wed, 06 Jul 2005 14:13:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.61.0507061001050.17582@slinky.cs.nyu.edu>
Message-ID: <SERRANOCv3uS7sBdxki000003e4@SERRANO.CAM.ARTIMI.COM>
X-SW-Source: 2005-q3/txt/msg00013.txt.bz2

----Original Message----
>From: Igor Pechtchanski
>Sent: 06 July 2005 15:02

> On Tue, 5 Jul 2005, Eric Blake wrote:
> 
>> Christopher Faylor <cgf-no-personal-reply-please <at> cygwin.com> writes:
>> 
>>> 
>>> On Tue, Jul 05, 2005 at 08:49:06PM +0000, Eric Blake wrote:
>>>> <at>  <at>  -1677,7 +1681,7  <at>  <at>  main (int argc, char **argv) 
>>>>        { if (i)
>>>>          puts ("");
>>>> -       cygcheck (argv[i]);
>>>> +       ok &= cygcheck (argv[i]);
>>> 
>>> Why are you anding the result here?  Why not just set ok = cygcheck
>>> (...)? 
>> 
>> Because it's in a for loop, and when the first file fails but second
>> succeeds, you still want the overall command to exit with failure.
> 
> That's the correct intent, but shouldn't it be &&= instead of &=,
> technically?
> 	Igor


  Nope, because then it wouldn't evaluate operand (== call the function)
after the first failure.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
