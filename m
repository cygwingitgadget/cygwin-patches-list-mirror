Return-Path: <cygwin-patches-return-5440-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32279 invoked by alias); 9 May 2005 23:42:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32211 invoked from network); 9 May 2005 23:42:09 -0000
Received: from unknown (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
  by sourceware.org with SMTP; 9 May 2005 23:42:09 -0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 10 May 2005 00:41:56 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch]: mkdir -p and network drives
Date: Mon, 09 May 2005 23:42:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <427BEFAC.8090502@byu.net>
Message-ID: <SERRANOISPim9OciPXk000002a8@SERRANO.CAM.ARTIMI.COM>
X-OriginalArrivalTime: 09 May 2005 23:41:56.0760 (UTC) FILETIME=[AFC2F180:01C554F0]
X-SW-Source: 2005-q2/txt/msg00036.txt.bz2

----Original Message----
>From: Eric Blake
>Sent: 06 May 2005 23:29


> Also, what should //.. resolve to, / or //?  And if it resolves to /,
> should // be an entry in the readdir() of /?  I would argue that //..
> should resolve to //, meaning we just have two distinct roots in the
> directory tree.


  Wouldn't it work to just have a magic directory called '/' in the root
dir, just like the other magic dirs 'dev' and 'proc'?  Then it would be
called '//', and it could have '.' and '..' entries just like '/dev' and
'/proc' do.

  Well, like /proc does, anyway.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
