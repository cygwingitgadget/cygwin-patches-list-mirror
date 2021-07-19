Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-043.btinternet.com (mailomta28-re.btinternet.com
 [213.120.69.121])
 by sourceware.org (Postfix) with ESMTPS id E0A093951899
 for <cygwin-patches@cygwin.com>; Mon, 19 Jul 2021 14:23:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E0A093951899
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.54.8])
 by re-prd-fep-043.btinternet.com with ESMTP id
 <20210719142357.CTUO22650.re-prd-fep-043.btinternet.com@re-prd-rgout-005.btmx-prd.synchronoss.net>
 for <cygwin-patches@cygwin.com>; Mon, 19 Jul 2021 15:23:57 +0100
Authentication-Results: btinternet.com;
 auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 60DCD71102B98FEF
X-Originating-IP: [86.139.167.43]
X-OWM-Source-IP: 86.139.167.43 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvtddrfedtgdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgeeuhfekvdefieeghfehtdejheeigedthefhhfehfffgheehgedtffeljeetueeunecukfhppeekiedrudefledrudeijedrgeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurdduuddungdpihhnvghtpeekiedrudefledrudeijedrgeefpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqecuuefqffgjpeekuefkvffokffogfdprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheq
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.111] (86.139.167.43) by
 re-prd-rgout-005.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 60DCD71102B98FEF for cygwin-patches@cygwin.com;
 Mon, 19 Jul 2021 15:23:57 +0100
Subject: Re: [PATCH 1/3] Cygwin: New tool: profiler
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210716044957.5298-1-mark@maxrnd.com>
 <YPVON/D5dvOYFwfU@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Message-ID: <616e4815-1b8b-8c3d-0dfc-ff6c6dc6fd85@dronecode.org.uk>
Date: Mon, 19 Jul 2021 15:23:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPVON/D5dvOYFwfU@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3571.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Mon, 19 Jul 2021 14:24:01 -0000

On 19/07/2021 11:04, Corinna Vinschen wrote:
> Hi Matt,
> 
> On Jul 15 21:49, Mark Geisert wrote:
>> The new tool formerly known as cygmon is renamed to 'profiler'.  For the
>> name I considered 'ipsampler' and could not think of any others.  I'm open
>> to a different name if any is suggested.
>>
>> I decided that a discussion of the pros and cons of this profiler vs the
>> existing ssp should probably be in the "Profiling Cygwin Programs" section
>> of the Cygwin User's Guide rather than in the help for either.  That
>> material will be supplied at some point.
>>
>> CONTEXT buffers are made child-specific and thus thread-specific since
>> there is one profiler thread for each child program being profiled.
>>
>> The SetThreadPriority() warning comment has been expanded.
>>
>> chmod() works on Cygwin so the "//XXX ineffective" comment is gone.
>>
>> I decided to make the "sample all executable sections" and "sample
>> dynamically generated code" suggestions simply expanded comments for now.
>>
>> The profiler program is now a Cygwin exe rather than a native exe.
> 
> The patchset LGTM, but for the details I'd like jturney to have a look
> and approve it eventually.

Thanks.  I applied these patches.

A few small issues you might consider addressing in follow-ups.

> +
> +/* Set up interfaces to Cygwin internal funcs and path.cc helper funcs. */
> +extern "C" {
> +uintptr_t cygwin_internal (int, ...);

Since this is a now cygwin application, you can include <sys/cygwin.h> 
for this prototype.

> +WCHAR cygwin_dll_path[32768];
> +}

This is unused.

> +int
> +main (int argc, char **argv)
> +{
> +  /* Make sure to have room for the _cygtls area *and* to initialize it.
> +   * This is required to make sure cygwin_internal calls into Cygwin work
> +   * reliably.  This problem has been noticed under AllocationPreference
> +   * registry setting to 0x100000 (TOP_DOWN).
> +   */
> +  char buf[CYGTLS_PADSIZE];
> +
> +  RtlSecureZeroMemory (buf, sizeof (buf));

Since you aren't dynamically loading cygwin1.dll, none of this guff is 
needed.

> +    <refsynopsisdiv>
> +    <screen>
> +gmondump [OPTION]... FILENAME...
> +    </screen>
> +    </refsynopsisdiv>

This says that 1 or more FILENAME are expected, but actually 0 is handled.

So perhaps either document the actual behaviour, or make providing no 
filenames to gmondump an error.

> +    <para>The <command>profiler</command> utility executes a given program, and
> +      optionally the children of that program, collecting the location of the
> +      CPU instruction pointer (IP) many times per second.

I don't think this says what you mean.  It's not optional that the child 
processes are executed, it's optional that they are profiled.
