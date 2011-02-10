Return-Path: <cygwin-patches-return-7181-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21791 invoked by alias); 10 Feb 2011 13:42:35 -0000
Received: (qmail 21774 invoked by uid 22791); 10 Feb 2011 13:42:32 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 10 Feb 2011 13:42:28 +0000
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])	by gateway1.messagingengine.com (Postfix) with ESMTP id EAC612137C	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 08:42:25 -0500 (EST)
Received: from frontend2.messagingengine.com ([10.202.2.161])  by compute2.internal (MEProxy); Thu, 10 Feb 2011 08:42:25 -0500
Received: from [192.168.1.3] (user-0c6se63.cable.mindspring.com [24.110.56.195])	by mail.messagingengine.com (Postfix) with ESMTPSA id 8BA2A44D231;	Thu, 10 Feb 2011 08:42:25 -0500 (EST)
Message-ID: <4D53EB3F.7010608@cwilson.fastmail.fm>
Date: Thu, 10 Feb 2011 13:42:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] for SIGSEGV, compilation error in gcc 4.6
References: <AANLkTinBrYcRrRBztY5eKWzon02GtB4t3S5BcLVoA_+D@mail.gmail.com> <20110210100236.GD2305@calimero.vinschen.de> <4D53DE66.2080805@gmail.com>
In-Reply-To: <4D53DE66.2080805@gmail.com>
Content-Type: text/plain; charset=UTF-8
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
X-SW-Source: 2011-q1/txt/msg00036.txt.bz2

On 2/10/2011 7:47 AM, jojelino wrote:
> On 2011-02-10 19:02, Corinna Vinschen wrote:
> 
>> Also, it would be nice if you would add more words to explain what your
>> patch is doing.  Just a patch with no explanation is not very inviting
>> to take a look at it at all.
> 
> this patch deals with only "two" problem. and this is "first" one.
> 
> static char * (*findenv_func)(const char *, int *) = (char *
> (*)(const char *, int *)) getearly;
> findenv_func is declared without __stdcall convention, and it is casting
> getearly having __stdcall convention with function type without
> __stdcall convention. to fix this problem, add __stdcall to findenv_func.

"two-liner"

+typedef char* (__stdcall *pfnenv)(const char*,int*);
...
-static char * (*findenv_func)(const char *, int *) = (char *
(*)(const char *, int *)) getearly;
+static pfnenv findenv_func = &getearly;


> and this is "another" one.
> 
> this one deals with compilation error that gcc 4.6 complained. so i just
> copy & paste __attribute__((regparm (x))) from function declaration to
> function definition, so i must admit that this one was derived from
> original cygwin source code. that is, you can fix it without this patch.

"mechanical repetition of one-liner"

I think this patch qualifies under the minor change rule for not needing
an assignment...although it would be good for the OP to go ahead and
complete the paperwork for future contributions.

IANAL, blah blah...

--
Chuck
