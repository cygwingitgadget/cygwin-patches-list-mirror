Return-Path: <SRS0=bxUU=I2=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-048.btinternet.com (mailomta18-re.btinternet.com [213.120.69.111])
	by sourceware.org (Postfix) with ESMTPS id 436B63858D1E
	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2024 13:52:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 436B63858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 436B63858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.111
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705413149; cv=none;
	b=jTMk7eLKdvNZmYFlyoGkVQpOIP+dKFvXA+2SShFOY9gGLskc+WU/iJshqcoPyGd0j6YO5d2GDOuaNV3/TLc6Y900innhbMm/OU5wJ/IBwz62WLRKY0aEi3Ybwm16GUHB+fVaurNcsJsUQ0sY1zzPDDbFfgmq9aI8iRe2DMnm1RM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705413149; c=relaxed/simple;
	bh=y6wQNz4oy9hTTnY24uDFBnbSti+aBFeORO4H/+xlokE=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=CegCZUCygQBxWvgwha/05JQEhRKfD0t15erDX6oqZbFPmCMXXJdQJURUZR27M5reLDeAPC/aDcBs1I7zUFksoL+q4jlGZW0jZTyPk2DlmOD2PTWBJ+HdW+k13DsAHkz7gv2x3ta6AJ4ZwagvVgGkLq62FyKx2FYMDIaCc22sQ0E=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-048.btinternet.com with ESMTP
          id <20240116135224.TZD17945.re-prd-fep-048.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2024 13:52:24 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B87C04364839
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejfedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddufeelrdduheekrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdejngdpihhnvghtpeekiedrudefledrudehkedruddtfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehr
	vgdqphhrugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.107] (86.139.158.103) by re-prd-rgout-004.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B87C04364839 for cygwin-patches@cygwin.com; Tue, 16 Jan 2024 13:52:23 +0000
Message-ID: <dde2da5f-7f91-4f71-9a6f-dbedb05e1298@dronecode.org.uk>
Date: Tue, 16 Jan 2024 13:52:22 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Cygwin: Make 'ulimit -c' control writing a coredump
References: <20240112140958.1694-1-jon.turney@dronecode.org.uk>
 <20240112140958.1694-2-jon.turney@dronecode.org.uk>
 <0e5b64f3-9d36-438d-96ad-20d231bccfeb@dronecode.org.uk>
 <ZaT-_Prh2gnn9v9y@calimero.vinschen.de>
 <3dafa845-a583-4b47-b0d6-3b16f46c8a67@dronecode.org.uk>
 <ZaVBHu-dY8_FOvm0@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ZaVBHu-dY8_FOvm0@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 15/01/2024 14:28, Corinna Vinschen wrote:
> On Jan 15 13:27, Jon Turney wrote:
>> On 15/01/2024 09:46, Corinna Vinschen wrote:
>>> On Jan 13 14:20, Jon Turney wrote:
>>>> On 12/01/2024 14:09, Jon Turney wrote:
>>>>> +
>>>>> +  PWCHAR cp = dumper_command;
>>>>> +  cp = wcpcpy (cp, L"\"");
>>>>> +  cp = wcpcpy (cp, dll_dir);
>>>>> +  cp = wcpcpy (cp, L"\\dumper.exe");
>>>>> +  cp = wcpcpy (cp, L"\" ");
>>>>> +  cp = wcpcpy (cp, L"\"");
>>>>> +  cp = wcpcpy (cp, global_progname);
>>>>
>>>> I wonder if this should be program_invocation_short_name, so that the
>>>> coredump is created in the cwd, rather than next to the executable.

So, when I actually look further into this, what I wrote is utter 
nonsense. dumper/minidumper includes the following:

>       ssize_t len = cygwin_conv_path (CCP_POSIX_TO_WIN_A | CCP_RELATIVE,
>                                       *(argv + optind), NULL, 0);
>       char *win32_name = (char *) alloca (len);
>       cygwin_conv_path (CCP_POSIX_TO_WIN_A | CCP_RELATIVE,  *(argv + optind),
>                         win32_name, len);
>       if ((p = strrchr (win32_name, '\\')))
>         p++;
>       else
>         p = win32_name;

My eyes moving over this lightly, my brain assumes it just converts from 
a Win32 path to a POSIX path, but actually it does:

1) convert from POSIX path to Windows path (assuming it's a no-op if the 
path is already in a Windows form
2) (now having a consistent path delimiter) use the part after the last 
delimiter (if any), as the basename.

So: no problem here, after all. coredump file is already created in the cwd.

