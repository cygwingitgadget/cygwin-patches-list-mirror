Return-Path: <cygwin-patches-return-5533-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27762 invoked by alias); 7 Jun 2005 16:10:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27701 invoked by uid 22791); 7 Jun 2005 16:10:12 -0000
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 07 Jun 2005 16:10:12 +0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 7 Jun 2005 17:10:03 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take 3
Date: Tue, 07 Jun 2005 16:10:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050606235137.GE16960@trixie.casa.cgf.cx>
Message-ID: <SERRANOW6Ex3AkwtsQz00000312@SERRANO.CAM.ARTIMI.COM>
X-SW-Source: 2005-q2/txt/msg00129.txt.bz2

----Original Message----
>From: Christopher Faylor
>Sent: 07 June 2005 00:52

> On Mon, Jun 06, 2005 at 04:11:32PM -0700, Max Kaehn wrote:
>> On Mon, 2005-06-06 at 16:07, Igor Pechtchanski wrote:
>>> I take it you meant
>>> 
>>> -       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) ;\
>>> +       $(RUNTEST) --tool winsup $(RUNTESTFLAGS) &&\
>> 
>> Oh, right, this is the world of shell scripts, not C.  Thanks for
>> catching that.
> 
> Actually neither is right.  The tests are supposed to run to
> completion, not stop on a failure.
> 
> cgf


  I'm of the opinion that cygload should be a subdirectory of
winsup/testsuite/winsup.api, since it's a functionality of the winsup api
that's being tested here, not an entire new tool.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
