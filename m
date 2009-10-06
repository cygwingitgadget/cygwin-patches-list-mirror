Return-Path: <cygwin-patches-return-6718-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29085 invoked by alias); 6 Oct 2009 16:15:25 -0000
Received: (qmail 29059 invoked by uid 22791); 6 Oct 2009 16:15:22 -0000
X-SWARE-Spam-Status: No, hits=-3.5 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS,WEIRD_PORT
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Oct 2009 16:15:15 +0000
Received: from compute2.internal (compute2.internal [10.202.2.42]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 760D388F71 	for <cygwin-patches@cygwin.com>; Tue,  6 Oct 2009 12:15:13 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute2.internal (MEProxy); Tue, 06 Oct 2009 12:15:13 -0400
Received: from [192.168.1.3] (user-0c6sbc4.cable.mindspring.com [24.110.45.132]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id E1D6E7BFE; 	Tue,  6 Oct 2009 12:15:12 -0400 (EDT)
Message-ID: <4ACB6D0A.1060307@cwilson.fastmail.fm>
Date: Tue, 06 Oct 2009 16:15:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add wrappers for ExitProcess, TerminateProcess
References: <4ACA4323.5080103@cwilson.fastmail.fm> <20091005202722.GG12789@calimero.vinschen.de> <4ACA5BC7.6090908@cwilson.fastmail.fm> <20091006034229.GA12172@ednor.casa.cgf.cx> <4ACAC079.2020105@cwilson.fastmail.fm> <20091006074620.GA13712@calimero.vinschen.de> <4ACB56D5.4060606@cwilson.fastmail.fm> <20091006154519.GA24301@calimero.vinschen.de>
In-Reply-To: <20091006154519.GA24301@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00049.txt.bz2

Corinna Vinschen wrote:
> Looks good to me.  Let's wait for Chris, though.  I have just one question.

OK.

> Shouldn't exit_process be marked with attribute(noreturn) or is the
> optimizing effect negligible?

It is already marked noreturn, in the declaration at the top of the
file.  I got an error when I marked the definition that way --
apparently gcc4 doesn't like that:

/usr/src/devel/kernel/src/winsup/cygwin/external.cc:181: error:
attributes are not allowed on a function-definition

I even tried to include the attribute on a (forward) declaration AND the
definition, but I got the same error.  The only thing that works is the
way I've already done it: apply the attribute to the (forward)
declaration, but not the definition.

--
Chuck
