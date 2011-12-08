Return-Path: <cygwin-patches-return-7561-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16643 invoked by alias); 8 Dec 2011 17:02:49 -0000
Received: (qmail 16625 invoked by uid 22791); 8 Dec 2011 17:02:47 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Dec 2011 17:02:34 +0000
Received: from fwd10.aul.t-online.de (fwd10.aul.t-online.de )	by mailout08.t-online.de with smtp 	id 1RYhMe-0004lr-8y; Thu, 08 Dec 2011 18:02:32 +0100
Received: from [192.168.2.108] (bjQCt4ZVohiUoFDPB5ZNqL2vavqJ9vDDGykl+EVDuu68dugfgLlRTF0KZVn9NXSQza@[79.224.109.40]) by fwd10.t-online.de	with esmtp id 1RYhMV-2EWWWW0; Thu, 8 Dec 2011 18:02:23 +0100
Message-ID: <4EE0ED9C.7060905@t-online.de>
Date: Thu, 08 Dec 2011 17:02:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110928 Firefox/7.0.1 SeaMonkey/2.4.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Problem with: Re: [PATCH] Allow usage of union wait for wait() functions and macros
References: <4E8CC986.3080001@t-online.de> <20111006023729.GM1955@ednor.casa.cgf.cx> <4E8D8B0D.1060805@t-online.de> <20111006130357.GA20063@ednor.casa.cgf.cx> <4E8DD373.2070008@t-online.de> <20111006171749.GC22971@ednor.casa.cgf.cx> <20111207223609.GA24624@ednor.casa.cgf.cx> <4EDFF3F7.1090704@t-online.de> <20111208023353.GA26402@ednor.casa.cgf.cx> <4EE05C68.8070106@t-online.de> <20111208162541.GB11458@ednor.casa.cgf.cx>
In-Reply-To: <20111208162541.GB11458@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q4/txt/msg00051.txt.bz2

Christopher Faylor wrote:
> On Thu, Dec 08, 2011 at 07:42:48AM +0100, Christian Franke wrote:
>> Fix:
>> #ifdef __cplusplus
>> +extern "C++" {
>> ...
>> inline int __wait_status_to_int(int __status) { .... }
>> inline int __wait_status_to_int(const union wait&__status) { .... }
>> ...
>> +}
>> #endif
> I've added that to sys/wait.h.  Thanks.

Unfortunately sys/wait.h 1.6 is incomplete. The extern "C++" block 
should include all overloaded C++ functions. Otherwise g++ issues 
similar errors for the wait*() functions as seen in the original message.

Christian
