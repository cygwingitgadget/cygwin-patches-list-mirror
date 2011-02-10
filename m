Return-Path: <cygwin-patches-return-7180-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1747 invoked by alias); 10 Feb 2011 12:45:04 -0000
Received: (qmail 1687 invoked by uid 22791); 10 Feb 2011 12:45:02 -0000
X-SWARE-Spam-Status: No, hits=-0.9 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-pz0-f43.google.com (HELO mail-pz0-f43.google.com) (209.85.210.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 10 Feb 2011 12:44:57 +0000
Received: by pzk28 with SMTP id 28so295507pzk.2        for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 04:44:55 -0800 (PST)
Received: by 10.142.135.17 with SMTP id i17mr344145wfd.1.1297341895480;        Thu, 10 Feb 2011 04:44:55 -0800 (PST)
Received: from [192.168.1.2] ([183.106.96.22])        by mx.google.com with ESMTPS id y42sm1857862wfd.10.2011.02.10.04.44.53        (version=SSLv3 cipher=RC4-MD5);        Thu, 10 Feb 2011 04:44:54 -0800 (PST)
Message-ID: <4D53DE66.2080805@gmail.com>
Date: Thu, 10 Feb 2011 12:45:00 -0000
From: jojelino <jojelino@gmail.com>
User-Agent: Mozilla/5.0 (Windows NT 5.2; rv:2.0b12pre) Gecko/20110209 Thunderbird/3.3a3pre
MIME-Version: 1.0
Newsgroups: gmane.os.cygwin.patches
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] for SIGSEGV, compilation error in gcc 4.6
References: <AANLkTinBrYcRrRBztY5eKWzon02GtB4t3S5BcLVoA_+D@mail.gmail.com> <20110210100236.GD2305@calimero.vinschen.de>
In-Reply-To: <20110210100236.GD2305@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-SW-Source: 2011-q1/txt/msg00035.txt.bz2

On 2011-02-10 19:02, Corinna Vinschen wrote:

> Also, it would be nice if you would add more words to explain what your
> patch is doing.  Just a patch with no explanation is not very inviting
> to take a look at it at all.

this patch deals with only "two" problem. and this is "first" one.

static char * (*findenv_func)(const char *, int *) = (char *
(*)(const char *, int *)) getearly;
findenv_func is declared without __stdcall convention, and it is casting 
getearly having __stdcall convention with function type without 
__stdcall convention. to fix this problem, add __stdcall to findenv_func.

and this is "another" one.

this one deals with compilation error that gcc 4.6 complained. so i just 
copy & paste __attribute__((regparm (x))) from function declaration to 
function definition, so i must admit that this one was derived from 
original cygwin source code. that is, you can fix it without this patch.

 > Did you read http://cygwin.com/contrib.html and the "Before you get
 > started" section?  Did you already send a copyright assignment?

what i understood is, i fill out the assignment form and snail it to 
provided address in http://cygwin.com/assign.txt

i didn't snail it yet.
