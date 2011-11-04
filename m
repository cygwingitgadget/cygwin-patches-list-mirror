Return-Path: <cygwin-patches-return-7537-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21273 invoked by alias); 4 Nov 2011 13:34:26 -0000
Received: (qmail 21090 invoked by uid 22791); 4 Nov 2011 13:34:25 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 04 Nov 2011 13:34:11 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.9]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 04 Nov 2011 13:34:08 +0000
Message-ID: <4EB3E9D1.5090203@dronecode.org.uk>
Date: Fri, 04 Nov 2011 13:34:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:8.0) Gecko/20111101 Thunderbird/8.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Extend faq.using to discuss fork failures
References: <4E570031.4080800@cs.utoronto.ca> <20110830090020.GE30452@calimero.vinschen.de> <4E5CE899.4030605@cs.utoronto.ca> <4EB2C2CD.1080400@dronecode.org.uk> <20111103210519.GA4294@ednor.casa.cgf.cx>
In-Reply-To: <20111103210519.GA4294@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
X-SW-Source: 2011-q4/txt/msg00027.txt.bz2

On 03/11/2011 21:05, Christopher Faylor wrote:
> I would still prefer eschewing actively negative words like "hostile" and just
> neutrally stating that Windows does not use a fork/exec model and does not offer
> any easy way to implement fork.

Hmm, yes, I'll fix that.

> I'd also like to see specific errors mentioned so that when people are searching for
> a solution to the problem they will be able to find it in the FAQ.

Is there something wrong with the itemized list which follows that sentence?
