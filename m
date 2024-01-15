Return-Path: <SRS0=kceB=IZ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-045.btinternet.com (mailomta12-sa.btinternet.com [213.120.69.18])
	by sourceware.org (Postfix) with ESMTPS id 78FEE3858D1E
	for <cygwin-patches@cygwin.com>; Mon, 15 Jan 2024 13:27:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78FEE3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 78FEE3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705325270; cv=none;
	b=ChXuXyaEnOmGla3ic4/4VFZ5z5SfnpsTWlDDVbLyxkqBbLNQ26iG4oJ2mA57+PENN3GhGRkkN4vUX3DyPZyCgyQ6CMCm0I7E82ptsA/FlsZHbQ84VjSt/4gXGoaY4HnYLXU0PN2fn1cxRmNzlsO6sNX9UBiYK9+WN2F+m8+h/Eg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705325270; c=relaxed/simple;
	bh=/NgIaoqN+qo2Q2Ch2VUPVfq02n7dqWYGFEhsxQhrLHI=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=mOuif9zd6rTGuTYkq4ZEPSqCWZQb1wtW16+sjsjLemOrMO8SajJFa+BPgrFUH/6ZxeCa2gPn498F+/sN8l9ExWxg8aetfgHBg3hVAPrtULo1B3X9936Kgx7H7m1eBb89oov3pPwDY+Id7T0aBmZ1EMvopKLaa9uZVS+GZOLSReo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-005.btmx-prd.synchronoss.net ([10.2.38.8])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20240115132746.TXJK29451.sa-prd-fep-045.btinternet.com@sa-prd-rgout-005.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Mon, 15 Jan 2024 13:27:46 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6567D008060EC218
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddufeelrdduheekrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdejngdpihhnvghtpeekiedrudefledrudehkedruddtfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehs
	rgdqphhrugdqrhhgohhuthdqtddthe
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.107] (86.139.158.103) by sa-prd-rgout-005.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567D008060EC218 for cygwin-patches@cygwin.com; Mon, 15 Jan 2024 13:27:46 +0000
Message-ID: <3dafa845-a583-4b47-b0d6-3b16f46c8a67@dronecode.org.uk>
Date: Mon, 15 Jan 2024 13:27:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <0e5b64f3-9d36-438d-96ad-20d231bccfeb@dronecode.org.uk>
 <ZaT-_Prh2gnn9v9y@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ZaT-_Prh2gnn9v9y@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 15/01/2024 09:46, Corinna Vinschen wrote:
> On Jan 13 14:20, Jon Turney wrote:
>> On 12/01/2024 14:09, Jon Turney wrote:
>>> +
>>> +  PWCHAR cp = dumper_command;
>>> +  cp = wcpcpy (cp, L"\"");
>>> +  cp = wcpcpy (cp, dll_dir);
>>> +  cp = wcpcpy (cp, L"\\dumper.exe");
>>> +  cp = wcpcpy (cp, L"\" ");
>>> +  cp = wcpcpy (cp, L"\"");
>>> +  cp = wcpcpy (cp, global_progname);
>>
>> I wonder if this should be program_invocation_short_name, so that the
>> coredump is created in the cwd, rather than next to the executable.
> 
> program_invocation_short_name would be nice, but does it really matter?
> 
> Because...
> 
>> But then, there's then no way to get similar behaviour if you decide you
>> want to use minidumps instead (by setting CYGWIN="error_start=minidumper"),
>> as the first argument to dumper/minidump is the full path to the program (to
>> match the 'prog procID' style of invoking gdb), but they only use it to add
>> an .core/.dmp extension to name the file to write.
>>
>> I guess that could by fixed by adding an option to the dumpers to strip
>> paths, or more control about how the JIT command is formatted.
> 
> dumper/minidumper are both called with the current working directory set
> to the ... current working directory, right?  With the full pathname as
> input, and the CWD already set the same as the dumped application, they
> can easily generate any target path for the corefile they like.
> 
> Given the actual path of the corefile can be generated by the dumpers,
> the question is how to specify where to store the corefile. For instance
> 
> - no option: CWD
> - some option -c/--coredir for anywhere else
> 
> Under Linux versions using systemd, corefiles are by default not stored
> in the CWD anymore, but to /var/lib/systemd/coredump, so there is a
> use case for arbitrary corefile paths.

Yeah, I guess an option to the dumper to control where the file is 
written is probably the best way to address this, which is something 
which can perhaps be added later...

