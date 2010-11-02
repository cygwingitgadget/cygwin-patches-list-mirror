Return-Path: <cygwin-patches-return-7130-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1964 invoked by alias); 31 Oct 2010 07:46:48 -0000
Received: (qmail 1952 invoked by uid 22791); 31 Oct 2010 07:46:47 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mail.lysator.liu.se (HELO mail.lysator.liu.se) (130.236.254.3)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 31 Oct 2010 07:46:43 +0000
Received: from mail.lysator.liu.se (localhost [127.0.0.1])	by mail.lysator.liu.se (Postfix) with ESMTP id 85CB64000B	for <cygwin-patches@cygwin.com>; Sun, 31 Oct 2010 05:56:00 +0100 (CET)
Received: from [192.168.0.33] (h57n3fls301o1095.telia.com [81.230.178.57])	(using TLSv1 with cipher AES256-SHA (256/256 bits))	(No client certificate requested)	by mail.lysator.liu.se (Postfix) with ESMTP id 600C940003	for <cygwin-patches@cygwin.com>; Sun, 31 Oct 2010 05:56:00 +0100 (CET)
Message-ID: <4CCCF6DF.5000902@lysator.liu.se>
Date: Tue, 02 Nov 2010 17:06:00 -0000
From: Peter Rosin <peda@lysator.liu.se>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: "regtool -m set" writes 2 extra bytes at the end
References: <20101031003731.GA30070@dpotapov.dyndns.org> <20101031014235.GA13538@ednor.casa.cgf.cx>
In-Reply-To: <20101031014235.GA13538@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1
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
X-SW-Source: 2010-q4/txt/msg00009.txt.bz2
Message-ID: <20101102170600.ZqOGc4KinhEjXw4z88kXrv-JBERCcntB3-z9U4_H0xg@z>

Den 2010-10-31 02:42 skrev Christopher Faylor:
> [Apologies for previously sending this as private email.  Don't know how
> that happened]
> On Sun, Oct 31, 2010 at 03:37:31AM +0300, Dmitry Potapov wrote:
>> Hi,
>>
>> The easiest way to demonstrate the problem is to run the following shell
>> script:
>>
>> ---- >8 ---
>> regtool -m set /HKEY_LOCAL_MACHINE/SOFTWARE/Test 1234
>> expected="31 00 32 00 33 00 34 00 00 00 00 00"
>> actual="`regtool get -b /HKEY_LOCAL_MACHINE/SOFTWARE/Test`"
>>
>> if [ "$actual" != "$expected" ]; then
>> 	echo FAILED
>> else
>> 	echo OK
>> fi
>> ---- >8 ---
> 
> I've checked this in but isn't there one too many trailing "00 00"s in
> the above, i.e., shouldn't it be "n" rather than "n + 1"?

One terminator for the string, and one for the multi-string.  I have
double terminators for natively created multi-strings.

Cheers,
Peter
