Return-Path: <cygwin-patches-return-6803-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27910 invoked by alias); 25 Oct 2009 23:39:28 -0000
Received: (qmail 27900 invoked by uid 22791); 25 Oct 2009 23:39:28 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 25 Oct 2009 23:39:24 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 8B01CBC7D5 	for <cygwin-patches@cygwin.com>; Sun, 25 Oct 2009 19:39:22 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Sun, 25 Oct 2009 19:39:21 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 020652E675; 	Sun, 25 Oct 2009 19:39:21 -0400 (EDT)
Message-ID: <4AE4E16F.6040700@cwilson.fastmail.fm>
Date: Sun, 25 Oct 2009 23:39:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Sync pseudo-reloc.c, round #2
References: <4AE4A701.3050206@cwilson.fastmail.fm>  <4AE4B419.1060502@cwilson.fastmail.fm> <20091025211540.GA1658@ednor.casa.cgf.cx>
In-Reply-To: <20091025211540.GA1658@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00134.txt.bz2

Christopher Faylor wrote:

> I didn't go through this + previous patch in exhaustive detail but if
> you've tested it then I think it's fine to check in.

Thx. Committed. Now I've just got to get the mingw version committed,
and then take the 2-liner revision back to mingw64...

--
Chuck
