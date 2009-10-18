Return-Path: <cygwin-patches-return-6781-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11313 invoked by alias); 18 Oct 2009 14:14:28 -0000
Received: (qmail 11298 invoked by uid 22791); 18 Oct 2009 14:14:26 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 18 Oct 2009 14:14:21 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 57BD1B1711 	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2009 10:14:20 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Sun, 18 Oct 2009 10:14:20 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id E0547A39E; 	Sun, 18 Oct 2009 10:14:19 -0400 (EDT)
Message-ID: <4ADB22B8.5060108@cwilson.fastmail.fm>
Date: Sun, 18 Oct 2009 14:14:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm> <4AD7C107.6000803@byu.net> <4AD7D356.8030703@cwilson.fastmail.fm> <4AD8DE16.3030506@cwilson.fastmail.fm> <20091018084824.GA25560@calimero.vinschen.de>
In-Reply-To: <20091018084824.GA25560@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00112.txt.bz2

Corinna Vinschen wrote:

> The Mingw developers should approve mingw stuff, usually.

Then any interested parties should read the ongoing thread here:
http://thread.gmane.org/gmane.comp.gnu.mingw.devel/3478

IMO, Keith is being unreasonable about "if DESTDIR doesn't work on
win32, we shouldn't add support for it even for those platforms where it
will work".  He's graciously allowed that this patch could go in, IF I
convince the automake and autoconf developers to completely redesign the
 way DESTDIR works so that it accommodates X: paths.

--
Chuck
