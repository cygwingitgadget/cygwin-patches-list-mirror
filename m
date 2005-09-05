Return-Path: <cygwin-patches-return-5642-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7474 invoked by alias); 5 Sep 2005 10:31:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7458 invoked by uid 22791); 5 Sep 2005 10:31:23 -0000
Received: from host217-40-213-68.in-addr.btopenworld.com (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 05 Sep 2005 10:31:23 +0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 5 Sep 2005 11:31:21 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: "'cygwin-patches mailing-list'" <cygwin-patches@cygwin.com>
Subject: RE: [patch] Don't append extra NUL to registry-strings.
Date: Mon, 05 Sep 2005 10:31:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <n2m-g.dfddna.3vvbaub.1@buzzy-box.bavag>
Message-ID: <SERRANOF2fPmsSVhGOD000000e6@SERRANO.CAM.ARTIMI.COM>
X-SW-Source: 2005-q3/txt/msg00097.txt.bz2

----Original Message----
>From: Buzz
>Sent: 04 September 2005 04:06


>>    To me this is the even more important reason.  Some registry strings
>>  do include the trailing zero, some don't;
> 
> I don't see how this could be.

  Because internally (native API) the registry stores NT-style
UNICODE_STRING structures, which have an explicit length count.  See also 

http://www.sysinternals.com/Information/TipsAndTrivia.html#HiddenKeys

http://blogs.msdn.com/oldnewthing/archive/2004/08/24/219444.aspx
 



    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
