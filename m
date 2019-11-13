Return-Path: <cygwin-patches-return-9847-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36789 invoked by alias); 13 Nov 2019 16:50:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36718 invoked by uid 89); 13 Nov 2019 16:50:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.4 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW autolearn=ham version=3.3.1 spammy=H*F:D*ca, disturbing, explained, wish
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.12) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Nov 2019 16:50:53 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id Uvqwi3sG8kqGXUvqxifF4Z; Wed, 13 Nov 2019 09:50:47 -0700
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] regtool: allow /proc/registry{,32,64}/ registry path prefix
To: cygwin-patches@cygwin.com
References: <20191110161445.53479-1-Brian.Inglis@SystematicSW.ab.ca> <20191111172859.39062-1-Brian.Inglis@SystematicSW.ab.ca> <20191113084621.GK3372@calimero.vinschen.de> <20191113093801.GP3372@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <25ea45b6-8d61-3cb8-7e7c-db55c2ef8018@SystematicSw.ab.ca>
Date: Wed, 13 Nov 2019 16:50:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191113093801.GP3372@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00118.txt.bz2

On 2019-11-13 02:38, Corinna Vinschen wrote:
> On Nov 13 09:46, Corinna Vinschen wrote:
>> On Nov 11 10:29, Brian Inglis wrote:
>>> The user can supply the registry path prefix /proc/registry{,32,64}/ to
>>> use path completion.
>> The git commit message does not outline why you're changing the example,
>> Given that the example doesn't use /proc/registry anyway, what's the
>> reasoning?  This should either be a patch on its own or at least this
>> should be mentioned in the commit message.

I explained in my earlier reply that it showed forward slashes and fit the doc
pages better; adding /proc/registry/... would be difficult to fit in the width!

> Sigh, I accidentally pushed this patch as is.  Never mind then.

In my earlier reply I said something which could be added to the commit message
with an --amend, if you wish:

Change doc example to be consistent and a better choice to show
forward slashes, and fit the width of the docs.

New COMMIT_MSG:
regtool: allow /proc/registry{,32,64}/ registry path prefix

The user can supply the registry path prefix /proc/registry{,32,64}/
to use path completion.
Change doc example to be consistent and a better choice to show
forward slashes, and fit the width of the docs.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
