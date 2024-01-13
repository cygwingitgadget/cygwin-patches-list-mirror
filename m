Return-Path: <SRS0=HHq1=IX=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-046.btinternet.com (mailomta8-sa.btinternet.com [213.120.69.14])
	by sourceware.org (Postfix) with ESMTPS id 39D8A3858D1E
	for <cygwin-patches@cygwin.com>; Sat, 13 Jan 2024 14:20:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 39D8A3858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 39D8A3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705155634; cv=none;
	b=BUtgTkS/mi2oRVslARhVgQkjktXF/jxgUWYailmX0K8Gi/niCcQBXweVQSR9OcRlrTUgB9lANwfOKv1ZaXBKDagTGRClDcvAjzSA4aoc363cPwKV7Q30/OWDAZp7HL63fgtd/hRMJ0G0eKLzkDQrBhAfU1mH1pu2gO+oFqnGqK8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705155634; c=relaxed/simple;
	bh=wP7GgROO2QR6nPDJKrr9O4FwSrQ4rwfUPRepSU3MNo4=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=B6AzYOK8n2upp12weA11qtsT6hVmIXgnO57W8PCuppU/+m2EP7AcKVZGQct3C9qYPwmeSRyp9TC7n0FURO+UcX7luVx3+MDNAHUyE+2Awp54Jbz7WyI69FIYAc6HKsIfYxUr7EuZ985LFOqNaZqV1J1TtWt3HMWxI3NBqy/pGss=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
          by sa-prd-fep-046.btinternet.com with ESMTP
          id <20240113142031.XGYE17034.sa-prd-fep-046.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Sat, 13 Jan 2024 14:20:31 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6567CEC105DA17C6
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeijedgieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddufeelrdduheekrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdejngdpihhnvghtpeekiedrudefledrudehkedruddtfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehs
	rgdqphhrugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.107] (86.139.158.103) by sa-prd-rgout-004.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6567CEC105DA17C6 for cygwin-patches@cygwin.com; Sat, 13 Jan 2024 14:20:31 +0000
Message-ID: <0e5b64f3-9d36-438d-96ad-20d231bccfeb@dronecode.org.uk>
Date: Sat, 13 Jan 2024 14:20:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
Content-Language: en-GB
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20240112140958.1694-2-jon.turney@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 12/01/2024 14:09, Jon Turney wrote:
> +
> +  PWCHAR cp = dumper_command;
> +  cp = wcpcpy (cp, L"\"");
> +  cp = wcpcpy (cp, dll_dir);
> +  cp = wcpcpy (cp, L"\\dumper.exe");
> +  cp = wcpcpy (cp, L"\" ");
> +  cp = wcpcpy (cp, L"\"");
> +  cp = wcpcpy (cp, global_progname);

I wonder if this should be program_invocation_short_name, so that the 
coredump is created in the cwd, rather than next to the executable.


But then, there's then no way to get similar behaviour if you decide you 
want to use minidumps instead (by setting 
CYGWIN="error_start=minidumper"), as the first argument to 
dumper/minidump is the full path to the program (to match the 'prog 
procID' style of invoking gdb), but they only use it to add an 
.core/.dmp extension to name the file to write.

I guess that could by fixed by adding an option to the dumpers to strip 
paths, or more control about how the JIT command is formatted.


