Return-Path: <cygwin-patches-return-9310-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9433 invoked by alias); 8 Apr 2019 12:38:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9424 invoked by uid 89); 8 Apr 2019 12:38:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=furthermore, scenario, databases, chances
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 08 Apr 2019 12:38:22 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Apr 2019 14:38:19 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hDTXW-0007Ak-Q1; Mon, 08 Apr 2019 14:38:18 +0200
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid> <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> <87pnq9jupk.fsf@Rainer.invalid> <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca> <878sww93g9.fsf@Rainer.invalid> <97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca> <236d3269-1b0b-9da0-9816-ed84e489f73e@ssi-schaefer.com> <20190403122648.GY3337@calimero.vinschen.de>
To: cygwin-patches@cygwin.com
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Openpgp: preference=signencrypt
Message-ID: <1ba74039-5ab5-aa09-2d86-24bf761885e0@ssi-schaefer.com>
Date: Mon, 08 Apr 2019 12:38:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190403122648.GY3337@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00017.txt.bz2

On 4/3/19 2:26 PM, Corinna Vinschen wrote:
> On Apr  3 12:38, Michael Haubenwallner wrote:
>> Furthermore, with so called "Stacked Prefix", it is possible to have a second
>> level of Gentoo Prefix, so what I'm after is some option to tell the rebase
>> utility which database to record dll base addresses into, and which multiple(!)
>> databases take into account while performing a rebase.
> 
> rebase is OSS.

Yeah, and I have found the git repo so far.  But I'm wondering if distfiles like
"cygwin-rebase-4.4.4.tar.bz2" are already available somewhere more persistent
than via the current Cygwin distro source package "rebase-4.4.4-1-src.tar.xz"?

> There's nothing keeping you from providing patches
> to make your scenario work ;)

I'm already testing some patch adding a '--destdir' option...

Thanks!
/haubi/
