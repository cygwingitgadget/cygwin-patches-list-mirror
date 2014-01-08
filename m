Return-Path: <cygwin-patches-return-7940-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13628 invoked by alias); 8 Jan 2014 14:38:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13614 invoked by uid 89); 8 Jan 2014 14:38:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.7 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: mho-02-ewr.mailhop.org
Received: from mho-02-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.72) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Wed, 08 Jan 2014 14:38:17 +0000
Received: from pool-108-49-99-58.bstnma.fios.verizon.net ([108.49.99.58] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf-use-the-mailinglist-please@cygwin.com>)	id 1W0uGt-000JaN-Lk	for cygwin-patches@cygwin.com; Wed, 08 Jan 2014 14:38:15 +0000
Received: from ednor (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with SMTP id 19444600D3	for <cygwin-patches@cygwin.com>; Wed,  8 Jan 2014 09:38:14 -0500 (EST)
Received: by ednor (sSMTP sendmail emulation); Wed, 08 Jan 2014 09:38:14 -0500
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1+ltLlC+1NX8a93gMuoPZRT
Date: Wed, 08 Jan 2014 14:38:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix potentially uninitialized variable p
Message-ID: <20140108143814.GA4931@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAOYw7dvP64FFXUJS60ixUqj2jr01Dzf3YrchyR79m7AQEb8TKA@mail.gmail.com> <20131222071118.GB2110@ednor.casa.cgf.cx> <CAOYw7dt68FHWKmaHwQ5bPoOZTODBAhbVFv5UkoiBbY1-kU6kjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOYw7dt68FHWKmaHwQ5bPoOZTODBAhbVFv5UkoiBbY1-kU6kjQ@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SW-Source: 2014-q1/txt/msg00013.txt.bz2

On Wed, Jan 08, 2014 at 11:00:14AM +0000, Ray Donnelly wrote:
>On Sun, Dec 22, 2013 at 7:11 AM, Christopher Faylor wrote:
>> On Sun, Dec 22, 2013 at 12:40:20AM +0000, Ray Donnelly wrote:
>>>-      PWCHAR p;
>>>+      PWCHAR p = NULL;
>>
>> AFAICT, that would result in a NULL dereference.  I've checked in
>> a different change to handle this.
>
>Thanks,
>
>A NULL dereference is maybe more consistent than the random
>dereference that would have otherwise happened.
>
>I was only trying to ensure -Werror builds succeed.

-Werror is the default for Cygwin.  This code has been around for a long
time and the compiler has never complained before.  Nevertheless, if the
compiler found a valid issue, making an invalid change to make it shut
up is hardly "more consistent".

cgf
