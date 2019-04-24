Return-Path: <cygwin-patches-return-9381-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21804 invoked by alias); 24 Apr 2019 17:39:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 21792 invoked by uid 89); 24 Apr 2019 17:39:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.4 required=5.0 tests=AWL,BAYES_40,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=secure, english, English, press
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 24 Apr 2019 17:39:19 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id JLrYhwxXKsAGkJLrZhcrbN; Wed, 24 Apr 2019 11:39:17 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [rebase PATCH] Introduce --no-rebase flag
To: cygwin-patches@cygwin.com
References: <990610f4-8ba8-92a1-0ece-5b22c275945a@ssi-schaefer.com> <87bm1axsls.fsf@Rainer.invalid>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <67ff51f0-4628-fd68-aa5f-840986aebd30@SystematicSw.ab.ca>
Date: Wed, 24 Apr 2019 17:39:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87bm1axsls.fsf@Rainer.invalid>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00088.txt.bz2

On 2019-04-13 01:38, Achim Gratz wrote:
> Michael Haubenwallner writes:
>> The --no-rebase flag is to update the database for new files, without
>> performing a rebase.  The file names provided should have been rebased
>> using the --oblivious flag just before.
> 
> That name is somewhat strange, how about "--enlist"?
Option enlist is strange in English - it means enrol as a private in the army -
not seeing a relevant meaning!
Synonyms are call up, draft, employ, engage, enrol, enter, get, hire, induct,
join, levy, mobilize, muster, obtain, press, procure, rally, recruit, secure,
sign on, sign up, take on, volunteer, win over; antonyms are discharge, leave,
spurn (from OED site).

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
