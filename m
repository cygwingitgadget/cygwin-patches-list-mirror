Return-Path: <cygwin-patches-return-5019-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18939 invoked by alias); 6 Oct 2004 03:01:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18929 invoked from network); 6 Oct 2004 03:01:43 -0000
From: "Gary R. Van Sickle" <g.r.vansickle@worldnet.att.net>
To: <cygwin-patches@cygwin.com>
Subject: RE: More pipe problems (was Re: [Fwd: 1.5.11-1: sftp performance problem])
Date: Wed, 06 Oct 2004 03:01:00 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <20041005162633.4295AE556@wildcard.curl.com>
X-SW-Source: 2004-q4/txt/msg00020.txt.bz2
Message-ID: <20041006030100.P9X17Zun82Uu0XuHhxpWMl2djzFpuP4xlSg9C9ko8vs@z>

[snip]
> But there is a strange twist:  When a read is pending on an 
> empty pipe, then WriteQuotaAvailable is also decremented!  I 
> can't imagine why this would be the case, but it is easy to 
> demonstrate using a pair of small test programs that I wrote 
> to experiment with pipe buffering.
> 

God.  Leave it to Bill.  I wonder if WriteQuotaAvailable isn't actually the
counter of the semaphore that gets pended on.

-- 
Gary R. Van Sickle
 
