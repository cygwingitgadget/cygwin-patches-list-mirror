Return-Path: <SRS0=VT+1=W5=systematicsw.ab.ca=brian.inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id D66F73857356
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 16:20:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D66F73857356
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=systematicsw.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=systematicsw.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D66F73857356
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744388403; cv=none;
	b=I7XdSJbF5nNZocjio7OqJ0wObgt/BEaD77MpLwKCxW/sRfSNslqluwSjXWOTdyegWplgpPRjnGgjbpterUfw0V/k1VdJupS0BKdm+Q5ucCvdxOPke6/oAlXMW5FBBjYv/mhBzDeN32/pYJVs0d5t2/c4OkPT+TprNHmNBS7JTy0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744388403; c=relaxed/simple;
	bh=mJGZ54OKt05DhHoqHQOXYCYj7OxQuNxJSYU5YytZU4o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=HGAHulcWO45LsfDNBSK5MXke3tTkhYHgEbmV3pdW5Ls17lCaPZUd3FYzmUK9h0ZUue8U5S/xE8dSJrOGITWIEEutUpKfW6JLNpPVQQpjaAetgzKSgpFtpNQzNK8liWmoU3DhDOS59E8thWEz1n5WllfRXeKOn8FiImfzL5HZGPE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D66F73857356
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=systematicsw.ab.ca header.i=@systematicsw.ab.ca header.a=rsa-sha256 header.s=he header.b=ebs+Ilom
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D624B1A055E
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 16:20:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf02.hostedemail.com (Postfix) with ESMTPA id 6CF3A8000E
	for <cygwin-patches@cygwin.com>; Fri, 11 Apr 2025 16:20:01 +0000 (UTC)
Message-ID: <e61081a6-b50f-488e-8ec0-f66a1e734c5b@systematicsw.ab.ca>
Date: Fri, 11 Apr 2025 10:20:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: brian.inglis@systematicsw.ab.ca
Reply-To: Brian.Inglis@SystematicSW.ab.ca
Subject: Re: compiles fail with sys/unistd.h ...inline... setproctitle_init
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <f34666fe-f8da-4364-a5e7-b2328b2f1c80@SystematicSW.ab.ca>
 <75e51a8e-8c25-414d-905a-60b380d939d4@SystematicSW.ab.ca>
 <20250411201319.c64e33349cad4a6798102cee@nifty.ne.jp>
Organization: Systematic Software
In-Reply-To: <20250411201319.c64e33349cad4a6798102cee@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6CF3A8000E
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: x7h8dga9j9w9t7i8jswhqg5sn7ey5bye
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18GlVz5nXMxVwDfx/bxY5IkSqrInoh7YY8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systematicsw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=cQ/y5A2RjaiQ+uAWPgxiYF28EPUCjqdQSD7/rO2XUb4=; b=ebs+IlomSR3UYGhAGb1xqepMGKkC7EnKI6NWTzrlG1ir/TYKIAhWG3vMwxNNjpqhBmTJgqGWl+m+d//Pb/8+aQpcLaE9BGW8acYB9HGzeiwxfnOaaN1RpPnvCP3ZPBPdvSfea8mBapfIV6WDg2zjVuFPq4TuSkHrOHrF8kwICq7hGVBH2og9fDFIE/D7X5YafCT5KsPDNz0dbB229+3X38P9DHfMGCoQZHBnReoDZ+Zwjh6LFWrUFfF7wn6lxCvuMtDdwHCYBVTlzjkOcaXebWLbiV7Icd3KS5Tfajpw1KfVGS3D+DEmxTHfavp+94vqMmO6pDxYNrEEsm4y5wzP+g==
X-HE-Tag: 1744388401-64940
X-HE-Meta: U2FsdGVkX18c6zWyI1xh3Ob0Lpv7DtJc6JuwYKNhT1BlSgkSCD/C0g3DeFd+8fxH6SIhutPmnwVaNM6LfYx0/lgifpu8Ytx7rS6lv65m/pU6FHpOCDKSF/VcO340EdNOWokVJa2X8445w2CVoDiDZxnHymtwECfNKNRD9sdy6Xl6AaVhCc+uidpYbfKRTg/7JbtfcvljtlNO+VKOAbpAM0wFeQHfRjlFUL9xiaY6w2VGurRJqFldXCefMPTCpOEaxtLpyZfmaqCiPwgR9WB74TyR+cPYOgMEYCy0d9WfK9SBq9YMemJjtK4qupovPoB9IaqjHCWAcU5X4cbDT9GryZOMnOiU9wxb
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-04-11 05:13, Takashi Yano wrote:
> On Thu, 10 Apr 2025 15:38:59 -0600
> Brian Inglis wrote:
>> Hi folks,
>>
>> Latest c-ares build failing with gcc 12.4 and Cygwin 3.6.0 header:
>>
>> $ uname -srvmo
>> CYGWIN_NT-10.0-19045 3.6.0-1.x86_64 2025-03-18 17:01 UTC x86_64 Cygwin
>> $ gcc --version
>> gcc (GCC) 12.4.0
>> Copyright (C) 2022 Free Software Foundation, Inc.
>> ...
>>
>> /usr/include/sys/unistd.h:218:14: error: expected ';' before 'void'
>>      218 | static inline void setproctitle_init (int _c, char *_a[], char *_e[]) {}
>>          |              ^~~~~
>>          |              ;
>>
>> Doing some more `make`-ing in that directory with permutations of specifiers,
>> complaint comes after `inline`; seems like it does not like `inline` anywhere in
>> that line, although `__inline__` works just fine!
>>
>> Perhaps a patch is warranted, possibly conditional on GCC <= 12?
> 
> Thanks for the report. Fixed.

Thanks for the quick offical fix - that works well!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
