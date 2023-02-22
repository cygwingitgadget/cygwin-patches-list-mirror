Return-Path: <SRS0=RIIT=6S=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 4ED733858D33
	for <cygwin-patches@cygwin.com>; Wed, 22 Feb 2023 23:53:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4ED733858D33
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id UtIZpcVmojvm1Uyv0pf1mn; Wed, 22 Feb 2023 23:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1677109982; bh=3rN6zbJOq1a72pFCOSfeFR6W3TxAEOwzoE37JVN9N7o=;
	h=Date:Reply-To:Subject:References:From:To:In-Reply-To;
	b=k9UrVG7AGmbTnTP1log9BaubYsBSngvlEw4qmCOdIyEBCFcvr/5JJLtwv3kP97BBz
	 glLYulkvamrHF6Ye6oaw3KcpkSjSKZGy+LaO6sOigcpPHQISpz4VU2EBMY0Onv6Yj8
	 Ut2RgoYkWclb4s4+2gNMy0MaSFhjC5n/0vHI1i2N8uIOIuO3lknaWKhZJo4TC54Ovk
	 Di3rRG4GRa1VsHEW/Tgjotizev1ktvHL/8duRChdqXfmZG07gL3ljgjTuF1dLLlDAw
	 PbykX3e1nV+JpmhBGKHo3QmjMLEldGkm76fmFcZp9DU5HCOa0QN+SSAd3uRjGj3HAF
	 PkMStk+Gq8aMg==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id Uyv0pr4sWcyvuUyv0pKAGr; Wed, 22 Feb 2023 23:53:02 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=63f6aade
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=mDV3o1hIAAAA:8 a=iWCPi50BE3ZMo2So59YA:9 a=QEXdDO2ut3YA:10
 a=AP3JQZ_qGYIA:10 a=_FVE-zBwftR9WsbkzFJk:22
Message-ID: <2fe87524-51a6-bba6-4ba3-2c8c15cb406a@Shaw.ca>
Date: Wed, 22 Feb 2023 16:53:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v3 0/2] newlib/libc/time/strftime: fix multi-page table
 format issues
Content-Language: en-CA
References: <20230217204902.3735-1-Brian.Inglis@Shaw.ca>
 <20230221041801.51970-1-Brian.Inglis@Shaw.ca>
 <Y/SLtmUi8dilWqCL@calimero.vinschen.de>
 <d5eae973-93af-1480-7292-4cfa8503b419@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
To: Cygwin Patches <cygwin-patches@cygwin.com>
In-Reply-To: <d5eae973-93af-1480-7292-4cfa8503b419@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBSFlovhxKvw3PwQ7X3XH0BYn/V+OYxIUHt1FSF+Fft4fHC/law8OoFvleuxsZgAtMRDzvcV5J/0OHpy7Uvv2ivVcFnJaiOLMfkX4/3aGDRGsdUUyWPO
 w9tMQl/aEsqIawZOVQ/e9xFfMfmKVl0lfGppKCLBgUr4T4jluiM5KQxlslBo2H0rYLTdLyNasut3k41OBWmj8QhYSaLpE5asJ3U=
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-02-22 13:10, Jon Turney wrote:
> On 21/02/2023 09:15, Corinna Vinschen wrote:
>> Jon,
>> I'd like your GTG on the patchset before merging it.

> Sorry, I don't think this patchset is good as is.

>> On Feb 20 21:17, Brian Inglis wrote:
>>> Discussion about why newlib man generation by docbook2man is
>>> incompatible with how man is incompatible with groff/tbl/grohtml:
>>>     https://lists.gnu.org/archive/html/bug-groff/2023-02/msg00118.html
>>> There does not appear to be good way to deal in docbook2man processing
>>> with generation of tables > "page" size, or that may not adversely affect
>>> other [newlib] doc man page tables, as the problem occurs solely on the
>>> strftime.3 man page!

> So, this seems to be saying that "strftime manpage misrenders under some 
> circumstances", but I even after re-reading several times, I have no clear sense 
> what that circumstance is exactly: generating html output? with current version 
> of groff? a future one?
> (Your answer should be a single sentence)

Current groff tbl pre-/processing generates table images for non-tty 
"devices"/file formats where tables > "page" size disappear if it is not handled 
appropriately, but the proper solution for tbl preprocessor output from groff 
can not be used, as there is a conflict between man requiring macro .TH and tbl 
needing command .TH to be passed thru to fix the problem - can't be done!

>>> The imminent groff/tbl release fixes a number of tbl issues, so may
>>> affect man pages with tables differently.
>>> The following groff/grohtml release plans to change grohtml, from
>>> generating tables as PNG graphics, which don't work reliably on some
>>> "devices"/file formats, and are not searchable, to generating tables in
>>> searchable text form on all "devices"/file formats, and fix other
>>> related issues, so may also affect man pages with tables differently.
>>> So for the current release, localize the changes to the man page chew
>>> input embedded in the strftime.c source comments, and the generated
>>> strftime.3 man page table formatting.
>>> Be prepared to tweak formatting if doc generation needs it, and
>>> eventually eliminate custom processing.

> I'm not sure "make it look worse in the typical case (someone looking at it in a 
> terminal with 'man strftime') to make it look better in the atypical case (?)" 
> is a good trade-off.

We could mess up other tables in other man pages if we tried to change 
makedocbook/docbook2man processing to try to split "long" tables as that depends 
on the length of the descriptive text column entries in lines and pages, which 
depends on the "device"/file format!

It seems easier, given the future changes above with unknown impacts, to handle 
the strftime long man page table rendering by splitting the (chew) table about 
the middle +/-%Ox, which fixes the table length > page length issue, then 
correcting the generated man page markup, which fixes the non-tty table 
rendering issue.
We could also do all the work just on the generated man page markup, but that 
seems even "hack"ier to me, than the current proposal.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
