Return-Path: <cygwin-patches-return-6864-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13399 invoked by alias); 14 Dec 2009 17:02:31 -0000
Received: (qmail 13386 invoked by uid 22791); 14 Dec 2009 17:02:30 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_JMF_BL
X-Spam-Check-By: sourceware.org
Received: from demumfd002.nsn-inter.net (HELO demumfd002.nsn-inter.net) (93.183.12.31)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Dec 2009 17:02:23 +0000
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55]) 	by demumfd002.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id nBEH2JaR001462 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL) 	for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2009 18:02:19 +0100
Received: from [10.149.155.84] ([10.149.155.84]) 	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id nBEH2J5H018261 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO) 	for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2009 18:02:19 +0100
Message-ID: <4B266F9B.6070204@towo.net>
Date: Mon, 14 Dec 2009 17:02:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net> <20091214162953.GO8059@calimero.vinschen.de>
In-Reply-To: <20091214162953.GO8059@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2009-q4/txt/msg00195.txt.bz2

Hi, please excuse some basic questions about CVS best practice:

Corinna Vinschen wrote:
> ...  Patches are supposed to be against
> the latest from CVS.  And it's also not cumbersome, it's rather quite
> simple.  CVS is doing that for you usually anyway.  If you have a
> patched CVS source tree, just call `cvs up' and the current HEAD is
> merged with your local changes.  Given that fhandler_console.cc wasn't
> changed for a while anyway, you should not see any merge conflicts.
>   
In this case yes. In general, if there are merging conflicts, I would 
have to dig around in reject logs, right? (Or do a fresh checkout and 
repatch.)
Also, since with this workflow I'd have the patched latest version only, 
what is the most convenient way to create the patch diff? Do you 
maintain two checkouts, an unpatched one to base on?

Thomas
