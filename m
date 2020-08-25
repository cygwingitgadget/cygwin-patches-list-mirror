Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 4B8E13857C7D
 for <cygwin-patches@cygwin.com>; Tue, 25 Aug 2020 11:02:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4B8E13857C7D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M8yU2-1kEO433QFa-0069lt for <cygwin-patches@cygwin.com>; Tue, 25 Aug 2020
 13:02:21 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 436A6A80403; Tue, 25 Aug 2020 13:02:21 +0200 (CEST)
Date: Tue, 25 Aug 2020 13:02:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: malloc tune-up
Message-ID: <20200825110221.GG3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200824045913.1216-1-mark@maxrnd.com>
 <20200824094843.GZ3272@calimero.vinschen.de>
 <65eafa55-54e3-7d5b-3fa0-4f3dce99a668@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <65eafa55-54e3-7d5b-3fa0-4f3dce99a668@maxrnd.com>
X-Provags-ID: V03:K1:/61H0IvnzG6uMk2wnOLmXvvviFwPkKQHbIxFcr27nlYnlKl7xjk
 Yokh6QGDHVzFKe8ylZml8JzrbCkI0ooOdNtkt0mL60bq9t9qmPnw8ZLXbKePbKSKZ8K9R2M
 9Bs9JjmKvDZ5cMST82RSygiRWEHxEDfdqKRexE1EIKuj2F0J2MZxySsy2MZzHlwrOAVPkHJ
 P1XjIMiiEWRVqHaohtOkQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EYGV/yAIlN0=:9Eyutgrp7FXrOM7GBe4lN2
 orfomc+8/oSC47YoCqeiyyLVLpJhTXcaiyf+G9C4Nof/2RwdfikDdtZJSVEAvgsyhn8B4QzgJ
 +IwjJUSXp9/OKf3v4bE2gO8E98D+aL3Zg68b5WQZb+fsM1NPSiZyU6hYGOajuZ+M8LMgk+2dS
 RPJNdzrAqVq0yXdM7C6ly5SiFmsUOSWuN6UVstFmovsJ+Xb9+9Bpqr4BbSCJ+A1KXu9kVz33l
 hPXGjBF8T9s0vg7GUDqbIIGmbqlCI14Gy79bBM3T2HdWYMe6/KmDicHmdH6u16ykTbwJPOrhW
 8N5p6GFsOaIRCKQTT+2sYsExnQMeIH5V43+tW1+P/MrKNFvjgKS9iW/jFAOzZMWCgFzRTNoUw
 x2qvI4UqzBQYlx/xJOaDPWTcgz7b0jXnVHFXQp7UGUmSKNqNGbkRhf/5WHwDyUJVrkpCaSbRH
 F+7nZ0L3UgLOM3KlntfXd1uSwV+uAva4hmHjZEXeswTiV3/55d1AHfyavDQayeLTtq0PLVK6M
 WMuUQqsphPtFkFPGFwbAKdZCZ3r0oDCIuqqzbJYBFsGUESVRGWrz8Rujk9NNpJlDEh75IGQzT
 Ha8oTrwZQRx/Bjms9fV11FkRr4wDHnwsR2NfkDUhRUHXGfzuIbOdJ0VwxXOl6MiOyoSGKInFH
 SVJQuPr+MFeCf4jQAILevtLAUvgd3SWht7d/Mxn3cljZtj5JB6UphzApm0NFplG8AL5HgPRU/
 QCLTbOe4V+MEAmgLRXa6ThP28ARu8D5OMmqTNHUREoWflyxSLgtnxLXmCkxjzKSFih90ka5BL
 kgCblHkvB476kj4SZgk8bTuf8ck8C4HBTf9WrxiYwHEkRJIwSiZYnqZwlYxi7usDTaF4W08Ga
 F9fmKhQT0Vn+C1lzYK2A==
X-Spam-Status: No, score=-99.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 25 Aug 2020 11:02:25 -0000

Hi Mark,

On Aug 25 00:29, Mark Geisert wrote:
> Hi Corinna,
> Well, this patch turned out to be half-baked.  Locking is working correctly
> because USE_LOCKS was set to 1 for malloc.cc's compilation.  The torture
> test I run validated that.  OTOH as you said, MSPACES was set 1 for
> malloc.cc but 0 for malloc_wrapper.cc.  So this patch yields a malloc
> facility like pre-3.2 but using internal locking on data structures instead
> of function-level locking.  An improvement, but not the whole package that
> I'm attempting to deliver because there's still thread contention on the
> internal locks.  Properly operating mspaces should get rid of that or at
> least lower it significantly.
> 
> I appreciate your comments on TLS variables and fork safety.  I will
> investigate this area further.  The mspaces should/will survive a fork but
> obviously the threads that created them won't.  Memory blocks can be freed
> by any thread; there's no need to create threads in the child process just
> to manage mspaces.

I was not worried about the malloced spaces themselves, but about the
TLS pointer of the thread calling fork().  The TLS pointer itself
(the one returned by TlsGetValue) is not propagated to the child process.
Therefore, this pointer is wrong in the child.  If that's not a problem,
fine.  But if it has to be preserved over fork, then the cygtls area
is definitely the way to propagate thread-specific info via fork.


Corinna
