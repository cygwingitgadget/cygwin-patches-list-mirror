Return-Path: <cygwin-patches-return-9503-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 34449 invoked by alias); 21 Jul 2019 07:15:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 34406 invoked by uid 89); 21 Jul 2019 07:15:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=Ken, H*f:sk:8dce094, H*f:sk:e97cff2, H*i:sk:e97cff2
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 21 Jul 2019 07:15:24 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id p63whohmIsAGkp63xhy54E; Sun, 21 Jul 2019 01:15:17 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] Cygwin: make path_conv::isdevice() return false on socket files
To: cygwin-patches@cygwin.com
References: <20190718200026.1377-1-kbrown@cornell.edu> <20190719082845.GO3772@calimero.vinschen.de> <8dce0946-6f7e-a3f4-62b1-98cdbbe277ef@cornell.edu> <e97cff22-2083-b5ec-1dac-31a34b0c86c3@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <619bf054-ae39-75af-eb12-e9b3b6115555@SystematicSw.ab.ca>
Date: Sun, 21 Jul 2019 07:15:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e97cff22-2083-b5ec-1dac-31a34b0c86c3@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00023.txt.bz2

On 2019-07-20 19:46, Ken Brown wrote:
> On 7/20/2019 6:53 PM, Ken Brown wrote:
>> On 7/19/2019 4:28 AM, Corinna Vinschen wrote:
>>> I see what you're doing here, but it's totally non-obvious from the 
>>> commit message why this fixes the problem and doesn't introduce weird 
>>> side-effects.
>> Thanks.  I was pretty careless with this patch.
>> There's a new patch series on the way that (I hope) does it right.
>>> An editorial note: While looking into your patch it occured to me that
>>> it would be about time to go over all the is***device() methods and
>>> clean up the mess.  E.g., is_fs_device() is used by is_lnk_special()
>>> only, is_auto_device() doesn't have much meaning,
>> I've removed is_fs_device() and is_auto_device()
>>> some funcs have underscores, some don't.
>> The convention seems to be that is<something> uses underscores if and only if
>> "something" is a single word.
>                ^
>               not
>> The only exception I saw is isctty_capable.
>> I didn't bother changing this, but I could if you want me to.

Anything beginning is or to followed by a lower case letter may be used by the
(library) implementation and may be considered reserved: best to interpose an
underscore as systems with better language support inc. BSDs are adding classes.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
