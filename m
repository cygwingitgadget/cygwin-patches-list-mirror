Return-Path: <cygwin-patches-return-6730-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26223 invoked by alias); 6 Oct 2009 21:19:18 -0000
Received: (qmail 26213 invoked by uid 22791); 6 Oct 2009 21:19:17 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 21:19:11 +0000
Received: from compute1.internal (compute1.internal [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 3721588D30 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 17:19:10 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Tue, 06 Oct 2009 17:19:10 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id CEDA14548; 	Tue,  6 Oct 2009 17:19:09 -0400 (EDT)
Message-ID: <4ACBB447.5070908@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 21:19:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACAC079.2020105@cwilson.fastmail.fm>  <20091006074620.GA13712@calimero.vinschen.de>  <4ACB56D5.4060606@cwilson.fastmail.fm>  <4ACB670F.2070209@cwilson.fastmail.fm>  <20091006182221.GD18135@ednor.casa.cgf.cx>  <4ACB9042.3070104@cwilson.fastmail.fm>  <20091006193502.GA18384@ednor.casa.cgf.cx>  <4ACB9FBE.5080700@cwilson.fastmail.fm>  <20091006202915.GA18969@ednor.casa.cgf.cx>  <4ACBB03A.6030009@cwilson.fastmail.fm> <20091006210906.GB18969@ednor.casa.cgf.cx> <4ACBB350.1090302@cwilson.fastmail.fm>
In-Reply-To: <4ACBB350.1090302@cwilson.fastmail.fm>
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
X-SW-Source: 2009-q4/txt/msg00061.txt.bz2

Charles Wilson wrote:

> Oh, ok. I'm sorry; I misread that.  Sure, int is fine. I'll do that,
> check that it actually builds and works (!), and check it in.  Thanks.

Do I need to increment the minor version when adding a new
cygwin_internal call?  It seems so:

2009-01-09  Christopher Faylor

        * include/sys/cygwin.h (CW_SETERRNO): Define.
        * external.cc (CW_SETERRNO): Implement.
        * include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR to 192 to
        reflect the above change.

--
Chuck
