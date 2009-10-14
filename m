Return-Path: <cygwin-patches-return-6769-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7508 invoked by alias); 14 Oct 2009 11:49:42 -0000
Received: (qmail 7490 invoked by uid 22791); 14 Oct 2009 11:49:41 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0 	tests=AWL,BAYES_00
X-Spam-Check-By: sourceware.org
Received: from mailout02.t-online.de (HELO mailout02.t-online.de) (194.25.134.17)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 14 Oct 2009 11:49:37 +0000
Received: from fwd09.aul.t-online.de  	by mailout02.t-online.de with smtp  	id 1My1yb-0007tt-03; Wed, 14 Oct 2009 13:25:05 +0200
Received: from localhost (ZZ2LYTZeZhqO2awCYIOJ0c6+TqlzXwzASckiEZxSbVG4yUcRlpXGqNTxWAErA6Ewkg@[172.20.101.250]) by fwd09.aul.t-online.de 	with esmtp id 1My1yO-0KvdnE0; Wed, 14 Oct 2009 13:24:52 +0200
MIME-Version: 1.0
Received: from 194.45.13.131:53756 by cmpweb17.aul.t-online.de with HTTP/1.1  (Kommunikationscenter V9-3-0-6 on API V3-5-4-6)
In-Reply-To: <20091014104003.GA24593@calimero.vinschen.de>
References: <20091004123006.GF4563@calimero.vinschen.de>  <20091004125455.GG4563@calimero.vinschen.de> <4AC8F299.1020303@t-online.de>  <20091004195723.GH4563@calimero.vinschen.de>  <20091004200843.GK4563@calimero.vinschen.de> <4ACFAE4D.90502@t-online.de>  <20091010100831.GA13581@calimero.vinschen.de> <4AD243ED.6080505@t-online.de>  <20091013102502.GG11169@calimero.vinschen.de> <4AD4E38A.2050301@t-online.de>  <20091014104003.GA24593@calimero.vinschen.de>
Date: Wed, 14 Oct 2009 11:49:00 -0000
Reply-To: "Christian Franke" <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
Subject: Re: =?ISO-8859-15?Q?=5BPatch=5D?= Allow to disable root privileges  with CYGWIN=noroot
From: "Christian Franke" <Christian.Franke@t-online.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <1My1yO-0KvdnE0@fwd09.aul.t-online.de>
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
X-SW-Source: 2009-q4/txt/msg00100.txt.bz2

Corinna Vinschen wrote:
> 
> Cool.  Another interesting option could be to remove the domain admins
> group as well, if the user is a domain user and, of course, removing
> any single user right, similar to the "capsh" tool under SELinux.
> 

Yes, makes sense.


> I'm just not sure if that tool should be part of the Cygwin package or
> a package of its own right.  I'm leaning towards the latter choice.
> 
> 

... or add it to the cygutils package ?


Is there any tool to print the info provided by GetTokenInformation() ?

I have a preliminary version of such a tool and can contribute it later
if desired.

Christian


