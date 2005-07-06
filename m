Return-Path: <cygwin-patches-return-5562-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17927 invoked by alias); 6 Jul 2005 15:49:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17890 invoked by uid 22791); 6 Jul 2005 15:49:52 -0000
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 06 Jul 2005 15:49:52 +0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.211);
	 Wed, 6 Jul 2005 16:49:25 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: cygcheck exit status
Date: Wed, 06 Jul 2005 15:49:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.GSO.4.61.0507061133490.18488@slinky.cs.nyu.edu>
Message-ID: <SERRANOUaUFNjbyAU9P000003f8@SERRANO.CAM.ARTIMI.COM>
X-SW-Source: 2005-q3/txt/msg00017.txt.bz2

----Original Message----
>From: Igor Pechtchanski
>Sent: 06 July 2005 16:36

> On Wed, 6 Jul 2005, Eric Blake wrote:
> 
>> Igor Pechtchanski <pechtcha <at> cs.nyu.edu> writes:
>>>> Because it's in a for loop, and when the first file fails but second
>>>> succeeds, you still want the overall command to exit with failure.
>>> 
>>> That's the correct intent, but shouldn't it be &&= instead of &=,
>>> technically?
>> 
>> There's no such thing as &&=.  And even if there was, you wouldn't want
>> to use it, because it would short-circuit running cygcheck().  The whole
>> point of the boolean collector is to run the test on every file, but to
>> remember if any of the tests failed.  Maybe thinking of a short-circuit
>> in the reverse direction will help you understand:
>> [snip]
> 
> Ok, ok, IOWTWIWT... :-)  I'm well aware of the short circuiting
> behavior of &&.
> 	Igor


  I thought it too when I first looked at the code, but realised the
short-circuit implication before I had time to write a reply....   But it
_was_ news to me that there's no &&= operator!


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
