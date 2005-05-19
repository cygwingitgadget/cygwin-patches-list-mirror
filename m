Return-Path: <cygwin-patches-return-5475-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20135 invoked by alias); 19 May 2005 11:05:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15921 invoked from network); 19 May 2005 10:58:42 -0000
Received: from unknown (HELO SERRANO.CAM.ARTIMI.COM) (217.40.213.68)
  by sourceware.org with SMTP; 19 May 2005 10:58:42 -0000
Received: from mace ([192.168.1.25]) by SERRANO.CAM.ARTIMI.COM with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 19 May 2005 11:58:41 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: [Patch]: mkdir -p and network drives
Date: Thu, 19 May 2005 11:05:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050519051326.GA23707@trixie.casa.cgf.cx>
Message-ID: <SERRANOQOkAy2OheSXV00000062@SERRANO.CAM.ARTIMI.COM>
X-OriginalArrivalTime: 19 May 2005 10:58:41.0455 (UTC) FILETIME=[B7C373F0:01C55C61]
X-SW-Source: 2005-q2/txt/msg00071.txt.bz2

----Original Message----
>From: Christopher Faylor
>Sent: 19 May 2005 06:13

> On Wed, May 18, 2005 at 10:09:35PM -0700, Vance Turner wrote:
>> Additional note
>> 
>> ls -lRC - not working
>> ls -RCl - working
>> 
>> If you point out the source I will fix it.
> 
> 1) This is not a bug reporting list.
> 
> 2) This does not, as far as I can tell, have anything to do with the
> subject of this message.  You seem to be starting an unrelated thread.
> 
> Please use the main cygwin mailing list for reporting bugs.
> 
> cgf


  Also, "ls -C" and "ls -l" are mutually exclusive.  Whichever one you place
last on the command line wins.  NAB.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
