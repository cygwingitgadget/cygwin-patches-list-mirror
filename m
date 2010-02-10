Return-Path: <cygwin-patches-return-6951-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 547 invoked by alias); 10 Feb 2010 01:13:55 -0000
Received: (qmail 537 invoked by uid 22791); 10 Feb 2010 01:13:54 -0000
X-SWARE-Spam-Status: No, hits=-3.6 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 10 Feb 2010 01:13:47 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 3AA7CE0B65 	for <cygwin-patches@cygwin.com>; Tue,  9 Feb 2010 20:13:46 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])   by compute1.internal (MEProxy); Tue, 09 Feb 2010 20:13:46 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id BEBE74AC1C3; 	Tue,  9 Feb 2010 20:13:45 -0500 (EST)
Message-ID: <4B72083C.2090205@cwilson.fastmail.fm>
Date: Wed, 10 Feb 2010 01:13:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
References: <4B266F9B.6070204@towo.net>  <20091214171323.GS8059@calimero.vinschen.de>  <20091215130036.GA19394@calimero.vinschen.de>  <4B28ACE8.1050305@towo.net>  <20091216145627.GM8059@calimero.vinschen.de>  <4B29934A.80902@towo.net>  <4B2C0715.8090108@towo.net>  <20091221101216.GA5632@calimero.vinschen.de>  <20100125190806.GA9166@calimero.vinschen.de>  <4B5F0585.9070903@towo.net> <20100126161036.GA31281@calimero.vinschen.de> <4B718CB8.7070308@towo.net>
In-Reply-To: <4B718CB8.7070308@towo.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00067.txt.bz2

Thomas Wolff wrote:
> Actually, I just remember again that I though I should change the
> terminfo entry too. Just - where's the source to patch?

http://mirrors.kernel.org/sources.redhat.com/cygwin/release/terminfo/terminfo-5.7_20091114-13-src.tar.bz2

That -src package is basically just a wrapper around terminfo.src from
ncurses-5.7 (as of patch level 20091114).  So, the ultimate upstream
source is actually ncurses.  But I split it out specifically so that we
could do faster updates of terminfo (rebuilding all of ncurses simply to
change two characters in /usr/share/terminfo/[63|c]/cygwin is rather silly).

So, send me patches against terminfo.src from that -src tarball, and
once we've got it figured out, I'll push it upstream to the ncurses
maintainer.

--
Chuck
