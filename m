Return-Path: <cygwin-patches-return-5638-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10198 invoked by alias); 30 Aug 2005 10:33:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10126 invoked by uid 22791); 30 Aug 2005 10:33:28 -0000
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 30 Aug 2005 10:33:28 +0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 30 Aug 2005 11:33:26 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [patch] Don't append extra NUL to registry-strings.
Date: Tue, 30 Aug 2005 10:33:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050829082119.GA24845@calimero.vinschen.de>
Message-ID: <SERRANO4brJta07SaZ600000362@SERRANO.CAM.ARTIMI.COM>
X-SW-Source: 2005-q3/txt/msg00093.txt.bz2

----Original Message----
>From: Corinna Vinschen
>Sent: 29 August 2005 09:21

> On Aug 28 22:49, Bas van Gompel wrote:
>> Hi,
>> 
>> When RegQueryValueEx returns a string-type, the final NUL is included
>> in the returned size. I suggest dropping it.
> 
> I see what you're up to, but there would be two reasons not to drop the
> trailing \0.  First, the \0 is part of the "file content" in a way.

  To me this is the even more important reason.  Some registry strings do
include the trailing zero, some don't; cygwin shouldn't tamper with it.  And
it would seem _very_ wrong to me if by querying a value, and then using the
result returned to re-set the value, the value should change in length.

  And since the patch unconditionally chops one off the size without
verifying whether or not the nul terminator is actually present, it would do
the wrong thing for some strings.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
