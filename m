Return-Path: <SRS0=sWMC=7M=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo007.btinternet.com (btprdrgo007.btinternet.com [65.20.50.123])
	by sourceware.org (Postfix) with ESMTP id 4CE094BA2E04
	for <cygwin-patches@cygwin.com>; Wed,  7 Jan 2026 12:51:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4CE094BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4CE094BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.123
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767790308; cv=none;
	b=iNk93P+/i3ByQbepINawJ6m5NGAyTV5ZV8JeMlogFbBtu0mb1iwX01rzG1xTFM75YyYp6rKNTZMjrdRHm5bgkWTwcboCKrS9IzJ6/0VcT8OcxOlcWNeZpEdzNlFJlD3V76O2d7Pvsi/OuEkkvqEhFvqjEDyb9y+ngpaS4CzZWk4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767790308; c=relaxed/simple;
	bh=KWm8ANaKs/aaJYneaCtn57KAMI4mI+oLRtX+1kjgg90=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=m2DYy5v1IhD8GNlRRXg/TWuqy86wePXwi9AGrMsuGFZNNcai0zB6vdOR/H9MHY0tUCD+X1629oaOt9v8ftyN/rAQ+EZ+rN8SxYz0wF02cUvnnn8CuO+eomxQXtRpdWVq0CDVii1hNZli3XuFSOPZqleLBkkfNiqDUYN01F344Kc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4CE094BA2E04
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 693FF8BE022FDFC5
X-Originating-IP: [86.143.43.76]
X-OWM-Source-IP: 86.143.43.76
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdefuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefggfejhfejheeigfeiveejffehjeetffduiedvgfehgfefgeetgfffieejveejvdenucffohhmrghinheptgihghifihhnrdgtohhmpdgtohhnfhhighhurhgvrdgrtgenucfkphepkeeirddugeefrdegfedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegfedrgeefrdejiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegfedqgeefqdejiedrrhgrnhhgvgekiedqudegfedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtjedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdq
	phgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepughhrhdqihhntghoghhnihhtohesgihsgegrlhhlrdhnlh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.143.43.76) by btprdrgo007.btinternet.com (authenticated as jonturney@btinternet.com)
        id 693FF8BE022FDFC5; Wed, 7 Jan 2026 12:51:41 +0000
Message-ID: <2a9915c7-6c3c-4115-8d1d-0f8a27779d67@dronecode.org.uk>
Date: Wed, 7 Jan 2026 12:51:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Renaming AC_ARG_WITH([cross_bootstrap] to ... in
 order to avoid confusion.
To: "J.H. vd Water" <dhr-incognito@xs4all.nl>
References: <20260106160517.4785-1-dhr-incognito@xs4all.nl>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260106160517.4785-1-dhr-incognito@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 06/01/2026 16:05, J.H. vd Water via Cygwin-patches wrote:
> Renaming macro  AC_ARG_WITH([cross_bootstrap]  to  AC_ARG_WITH([skip_mingw],  in
> order to avoid confusion ...
> 
> About 10 years ago, Foley (a] was "messing around" with a stage1 gcc compiler for
> Cygwin, and decided to rebuild cygwin1.dll, as he required only cygwin1.dll.
> 
> He did not like to rebuild assets, like cygcheck, strace, for which he was forced
> to install mingw-runtime (then: mingw-crt) and the MinGW toolchain.
> 
> To meet his intention, Foley decided to change the AC_ARG_WITH([mingw_progs] macro
> in winsup/configure.ac; he not only changed the option name of the macro, he also
> inverted the meaning of the  --with-FOO  switch (as Foley also inverted both tests
> that follow the macro) ...
> 
>      with-FOO changed from: "Hunt for mingw" ... to "do NOT hunt for mingw".

Thanks for looking into this. And thanks for providing a patch.

Yes, this is all messed up!

This all looks fine.

I think changing the option name is the best approach, as it's just 
completely unclear what it means either way around, and would be even 
more confusing if we suddenly inverted its meaning.

But how do you feel about reverting to the previous name 
'--without-mingw-progs' (this exactly matches what the logic does now, 
since the extra things that '--with(out?)-cross_bootstrap' was omitting 
have been unconditionally removed in the meantime)?

> 
> Originally:
> AC_ARG_WITH([mingw_progs], ...
> if test "x$with_mingw_progs" != xno; then
>    Hunt for mingw
> 
> Foley:
> AC_ARG_WITH([cross_bootstrap], ...
> if test "x$with_cross_bootstrap" != "xyes"; then
>    Hunt for mingw
> 
> Foley changed the option name of the macro to "cross-bootstrap", which confused not
> only Corinna V. [2], but is still confusing to everyone today!
> 
> A better name would have been: "skip_mingw".
> 
> Once more: by --withOUT cross-bootstrap,  Foley meant:  Hunt for mingw (contrary to
> how the switch is usually interpreted) ...
> 
> [1]
>   - https://cygwin.com/cgit/newlib-cygwin/commit/winsup/configure.ac?id=e7e6119241d02241c3d114cff037340c12245393
>     ( Rename without-mingw-progs to with-cross-bootstrap ) ... 2016-04-02
> 
> [2]
>   - https://cygwin.com/cgit/cygwin-htdocs/commit/faq/faq.html?id=9d693eea564ec608569c2f5d78536827e99f1661
>     ( Cygwin 3.5.0 release ) ... 2024-02-01
> 
> Therefore I suggest to change the option name of the macro into  "skip_mingw" , as
> follows:
