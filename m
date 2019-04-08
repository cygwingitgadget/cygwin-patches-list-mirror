Return-Path: <cygwin-patches-return-9312-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100567 invoked by alias); 8 Apr 2019 14:57:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100554 invoked by uid 89); 8 Apr 2019 14:57:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_40,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=inglis, Inglis, readers, calgary
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 08 Apr 2019 14:57:55 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id DViahJcQtsAGkDVibhlr4n; Mon, 08 Apr 2019 08:57:53 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
References: <0f0d7cd6-e770-fc32-f28f-817b700e4d87@SystematicSw.ab.ca> <f5ab5a82-8d26-4898-7ea4-ecef5c377299@ssi-schaefer.com> <abf543bb-e8df-9eeb-5ae8-63e5d59cca9a@SystematicSw.ab.ca> <87sgv65eyc.fsf@Rainer.invalid> <5fa27e1c-a790-f03d-b4b3-1985f26df128@SystematicSw.ab.ca> <87pnq9jupk.fsf@Rainer.invalid> <a83dedc6-ea5b-5fc9-4bbc-f06a9cf19472@SystematicSw.ab.ca> <878sww93g9.fsf@Rainer.invalid> <97aec921-d9b1-3b0e-de7a-d492832ba481@SystematicSw.ab.ca> <236d3269-1b0b-9da0-9816-ed84e489f73e@ssi-schaefer.com> <20190403122648.GY3337@calimero.vinschen.de> <1ba74039-5ab5-aa09-2d86-24bf761885e0@ssi-schaefer.com>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <ff209f54-3d82-4cb0-56d4-87c97ac704c5@SystematicSw.ab.ca>
Date: Mon, 08 Apr 2019 14:57:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1ba74039-5ab5-aa09-2d86-24bf761885e0@ssi-schaefer.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00019.txt.bz2

On 2019-04-08 06:38, Michael Haubenwallner wrote:
> On 4/3/19 2:26 PM, Corinna Vinschen wrote:
>> On Apr  3 12:38, Michael Haubenwallner wrote:
>>> Furthermore, with so called "Stacked Prefix", it is possible to have a second
>>> level of Gentoo Prefix, so what I'm after is some option to tell the rebase
>>> utility which database to record dll base addresses into, and which multiple(!)
>>> databases take into account while performing a rebase.
>> rebase is OSS.
> Yeah, and I have found the git repo so far.  But I'm wondering if distfiles like
> "cygwin-rebase-4.4.4.tar.bz2" are already available somewhere more persistent
> than via the current Cygwin distro source package "rebase-4.4.4-1-src.tar.xz"?

http://www.crouchingtigerhiddenfruitbat.org/Cygwin/timemachine.html

as long as that is around: dependent on health, and ability to fund, of one guy,
Peter Castro, like some of the software we use.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
