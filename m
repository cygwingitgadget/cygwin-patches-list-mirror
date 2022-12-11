Return-Path: <SRS0=+GwH=37=m.gmane-mx.org=gocp-cygwin-patches@sourceware.org>
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	by sourceware.org (Postfix) with ESMTPS id 5BD81385841D
	for <cygwin-patches@cygwin.com>; Sat, 20 Sep 2025 17:30:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BD81385841D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=m.gmane-mx.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BD81385841D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=116.202.254.214
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758389404; cv=none;
	b=ShaTWE+EcMPf/fjUY/3AAg2a57VmhziaSRhMZQlsiaI5uB8Unk7MktbMAdsF/7WoA39eDrePx8/5JQ5gXE08cHU+CFB355tM1vJEiAsvrTqQcKXBSqATAP16Hwf3KmZWp4d3sRX8RReONVGx6ABV7qrUdG4HD+dsrh4Tsw4QcW4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758389404; c=relaxed/simple;
	bh=nTVWoHXPY/U8ogQrGva6rb5A62kVz/4067/uRHfnNH4=;
	h=To:From:Subject:Date:Message-ID:Mime-Version; b=IoqJmADME776j8FwvKsFRtvgFLi4JLx2r/nfUJsNZ3D5G85eeGYzfPLmfGAqdhVVYFYP1pD68XCzBZF66bpXvJ6wptqMv8yrV0I90ii/EGp/pNyP+9QKKfHQjSAeRHgWty7VBLX04dBl61MV9L15yZwJDjTrPrrOvsBAxMh+wQ8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BD81385841D
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gocp-cygwin-patches@m.gmane-mx.org>)
	id 1v01PO-00011N-IW
	for cygwin-patches@cygwin.com; Sat, 20 Sep 2025 19:30:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: cygwin-patches@cygwin.com
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: Improve FAQ on early breakpoint for ASLR
Date: Sun, 11 Dec 2022 13:54:02 +0000
Message-ID: <9ae73a17-051e-b577-ccfc-a33c96076390@dronecode.org.uk>
References: <20221103170430.4448-1-jon.turney@dronecode.org.uk>
 <alpine.BSO.2.21.2211031120540.30152@resin.csoft.net>
 <Y2TqvPTB7Hui2jmJ@calimero.vinschen.de>
 <4ccbb5e1-ee4f-8944-ed44-4af7fa79f048@dronecode.org.uk>
 <f2942e0e-ea5e-7ba9-8770-b422628dafad@gmail.com>
 <a2e01953-f6ef-cf08-f6e1-0c7632391ede@dronecode.org.uk>
 <Y3NuGWbczdW5f+rC@calimero.vinschen.de>
 <8a0287ed-6f20-4a05-b584-966bfded6833@dronecode.org.uk>
 <Y4TImGsIsHnJya3W@calimero.vinschen.de>
 <5spqn8n0-q9r4-48r5-qo91-0o4qs27358s1@tzk.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Cc: cygwin-patches@cygwin.com
Content-Language: en-GB
In-Reply-To: <5spqn8n0-q9r4-48r5-qo91-0o4qs27358s1@tzk.qr>
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>
Message-ID: <20221211135402.6veigYXNKzqdgb9TORwor7iFMOg1csivpb09VZYCOkk@z>

On 05/12/2022 15:23, Johannes Schindelin wrote:
> On Mon, 28 Nov 2022, Corinna Vinschen wrote:
>> On Nov 28 13:00, Jon Turney wrote:
>>> On 15/11/2022 10:46, Corinna Vinschen wrote:
>>>>
>>>> It would be great if we could get used to using the same syntax as the
>>>> Linux kernel project to document stuff.  I'm trying to follow their lead
>>>> for a while.  For fixes to former commits, it looks like this in the
>>>> kernel, at the end of the commit message:
>>>>
>>>> Fixes: 123456789012 ("title of commit 123456789012")
>>>>
>>>> Yeah, core.abbrev is 12 digits.  I'm using this setting for quite some
>>>> time locally.
>>>
>>> Sounds good.  Is there some script to automate generating this kind of
>>> comment from a commit-id?
>>
>> I don't think so, at least I don't see anything like that in git docs...
> 
> It's note _quite_ what you asked for, but `git show --pretty=reference -s
> <commit>` (https://git-scm.com/docs/git-show#_pretty_formats) gives you
> _almost_ what you are looking for.
> 
> But you can always call `git show -s --format='%h ("%s")' <commit>`, and
> even configure an alias for this:
> 
> 	git config --global alias.pretty-print-commit \
> 		"-c core.abbrev=12 show -s --format='%h (\"%s\")'"
> 
Thanks!

I added '-c core.pager=', but this is what I was looking for, to save a 
bit of copying and pasting and editing.


