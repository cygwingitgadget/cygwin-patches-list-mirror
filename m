Return-Path: <SRS0=f0JU=7P=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id 92C754BA2E04
	for <cygwin-patches@cygwin.com>; Sat, 10 Jan 2026 19:28:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 92C754BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 92C754BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1768073312; cv=none;
	b=nyAOuQLlH2YRO7VCK8LpfG+1DyvTINZRhyGG8IfT3jRwWTqC0UiHcWMBqVfR0RmBau9WLhUMSDLU+bFCWQ/hMsSM0M7wko9m/9z9TZUudLUjqORd7eMiFVmDDZ/3FFnsFk4pbTAoYzB4SbeeX/9JZjK7FALDIiIN6VIhyk05v0g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1768073312; c=relaxed/simple;
	bh=yvvNa2Q5NljbzNSqndAmocRGLmSG3991TxDeUTqc1rU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=IiG+tijSx6341aWP+BNJK+4sqeRV6kmT+00RNlGuGMeMWhcHkX42Gdi/7kW0MuNjR8ue364EaXQ5Abxvly0W/WCxdIF4uOg5lZ7fRX1/XCb3o6G6A5gLDo7Iop0EUZCRDOHaLElifdd/os1ucT5NjZ3VFE9mSdIH7m9I/xSWyjg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 92C754BA2E04
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69454323021238ED
X-Originating-IP: [86.140.194.7]
X-OWM-Source-IP: 86.140.194.7
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduuddvheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevvdekgfffteetueehgfdugefgkeevleejudduheevuedtveejfeevvdevvdfgvdenucfkphepkeeirddugedtrdduleegrdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelgedrjedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudegtddqudelgedqjedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotdduuddpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepughhrhdqihhn
	tghoghhnihhtohesgihsgegrlhhlrdhnlh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.194.7) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69454323021238ED; Sat, 10 Jan 2026 19:28:26 +0000
Message-ID: <22c6c4b0-6b4a-499f-b34c-445635c7034d@dronecode.org.uk>
Date: Sat, 10 Jan 2026 19:28:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Rename cross_bootstrap back to mingw_progs to avoid
 confusion.
To: "J.H. vd Water" <dhr-incognito@xs4all.nl>
References: <20260109190415.25785-1-dhr-incognito@xs4all.nl>
 <20260109190415.25785-2-dhr-incognito@xs4all.nl>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260109190415.25785-2-dhr-incognito@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/01/2026 19:04, J.H. vd Water via Cygwin-patches wrote:
> Revert the option name in AC_ARG_WITH([cross_bootstrap] back to its previous name,
> mingw_progs, in order to avoid confusion ... Also revert the meaning of the macro.
> 
> About 10 years ago, Foley (1] was messing around with a stage1 gcc cross-compiler
> for Cygwin on Linux, and decided he only required cygwin1.dll.
> 
> He did not like to rebuild assets, like cygcheck, strace, for which he was forced
> to install the mingw-runtime (then: mingw-crt) and the MinGW toolchain.
> 
> Foley decided to change the option name of the AC_ARG_WITH([mingw_progs] macro in
> winsup/configure.ac; however, he also inverted the meaning of the --with(out)-FOO
> switch (as Foley also inverted the test that follows the macro) ...
> 
>      --with-FOO changed from: "Hunt for mingw" ... to "do NOT hunt for mingw"
>      --without-FOO changed from: "do NOT hunt for mingw" ... to "Hunt for mingw"
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

Indeed!

> Therefore I suggest to revert both the option name of the macro and the meaning of
> the macro to what they were: option name: mingw_progs, meaning: Hunt for the MinGW
> Toolchain (if --with-mingw-progs is specified).

Thanks, applied.

