Return-Path: <cygwin-patches-return-7517-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17203 invoked by alias); 6 Oct 2011 16:12:58 -0000
Received: (qmail 17181 invoked by uid 22791); 6 Oct 2011 16:12:54 -0000
X-SWARE-Spam-Status: No, hits=-1.1 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_JMF_BR,RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout01.t-online.de (HELO mailout01.t-online.de) (194.25.134.80)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 06 Oct 2011 16:12:40 +0000
Received: from fwd07.aul.t-online.de (fwd07.aul.t-online.de )	by mailout01.t-online.de with smtp 	id 1RBqYo-0001SK-Fz; Thu, 06 Oct 2011 18:12:38 +0200
Received: from [192.168.2.108] (bVYZJGZdghPD7NyXL49t2nhfICeWIA8sOtxlcIkzVqItNUi8arczAUpc3MEIRuxwH0@[79.224.127.17]) by fwd07.t-online.de	with esmtp id 1RBqYm-0bLcqe0; Thu, 6 Oct 2011 18:12:36 +0200
Message-ID: <4E8DD373.2070008@t-online.de>
Date: Thu, 06 Oct 2011 16:12:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110928 Firefox/7.0.1 SeaMonkey/2.4.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Allow usage of union wait for wait() functions and macros
References: <4E8C3828.4010009@t-online.de> <20111005132620.GA8422@ednor.casa.cgf.cx> <4E8CC986.3080001@t-online.de> <20111006023729.GM1955@ednor.casa.cgf.cx> <4E8D8B0D.1060805@t-online.de> <20111006130357.GA20063@ednor.casa.cgf.cx>
In-Reply-To: <20111006130357.GA20063@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q4/txt/msg00007.txt.bz2

Christopher Faylor wrote:
> On Thu, Oct 06, 2011 at 01:03:41PM +0200, Christian Franke wrote:
>> ...
>> OK, __INSIDE_CYGWIN__ is not needed here in practice (but possibly in
>> theory :-)
> I would rather see as little __INSIDE_CYGWIN__ as possible
> in external headers.

OK, removed and Cygwin compilation tested.

>> Would the patch with __INSIDE_CYGWIN__ removed be GTG?
> Yes.

Thanks - patch committed.

Christian
