Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id C272F3858001
 for <cygwin-patches@cygwin.com>; Sun,  8 Nov 2020 23:38:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C272F3858001
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id buG1kCTOq34axbuG2kLlzG; Sun, 08 Nov 2020 16:38:02 -0700
X-Authority-Analysis: v=2.4 cv=LvQsdlRc c=1 sm=1 tr=0 ts=5fa8815a
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=nIZtvpI7ZHv2ugoIt1MA:9 a=QEXdDO2ut3YA:10
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
 <20201105194748.31282-12-jon.turney@dronecode.org.uk>
 <8e13e92f-7aca-65ee-8978-d0b6cd7b062f@cornell.edu>
 <bae783a3-1098-85da-c2b8-00a65db6e00c@dronecode.org.uk>
 <643396a1-21b0-88a6-3f6b-2eb2083821e7@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: [PATCH 11/11] Ensure temporary directory used by tests exists
Message-ID: <cc43a4e7-b009-777a-35f3-ddbc923c4d31@SystematicSw.ab.ca>
Date: Sun, 8 Nov 2020 16:38:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <643396a1-21b0-88a6-3f6b-2eb2083821e7@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfF+4xcqFsc841MhbizYwUjzDZiYBchIlGCU0gZqBbQZzPQBSVdS5CjfPMYjJ+g333r2qO5lywalrzRhNm5nWzdpj8o6Jk6bippUBOJZe9wpzogzTedQ0
 TnmJJEUbTVVO23YGSseqVmoJ51p05SWG3PTA8Lg6yRCh+epkyDiFWJgVmp/Y8ERoGye+2XQ5Jlcak/ng0A4n8DHQDJCeHQQ5UE0=
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sun, 08 Nov 2020 23:38:05 -0000

On 2020-11-08 12:27, Ken Brown via Cygwin-patches wrote:
> On 11/8/2020 1:52 PM, Jon Turney wrote:
>> On 08/11/2020 18:19, Ken Brown via Cygwin-patches wrote:
>>> On 11/5/2020 2:47 PM, Jon Turney wrote:
>>>> +# temporary directory to be used for files created by tests (as an absolute,
>>>> +# /cygdrive path, so it can be understood by the test DLL, which will have
>>>> +# different mount table)
>>>> +tmpdir = $(shell cygpath -ma $(objdir)/testsuite/tmp/ | sed -e
>>>> 's#^\([A-Z]\):#/cygdrive/\L\1#')
>>>
>>> This isn't right if the cygdrive prefix is not 'cygdrive'.  Maybe use
>>> 'proc/cygdrive' instead of 'cygdrive'?

>> That's how I originally had it.  Unfortunately, test ltp/symlink01 relies on
>> the test directory being specified as a canonicalized pathname (i.e. is the
>> same after realpath()).
>>
>> Since there's no /etc/fstab in the the filesystem relative to the test DLL, I
>> think it should always be using the default cygdrive prefix?
> 
> But there's a mkdir command that seems to be run in the context of the user
> running 'make check'.  If the cygdrive prefix is not 'cygdrive', 'make check'
> fails as follows:
> 
> ERROR: tcl error sourcing
> /home/kbrown/src/cygdll/newlib-cygwin/winsup/testsuite/winsup.api/winsup.exp.
> ERROR: can't create directory "/cygdrive": permission denied
>     while executing
> "file mkdir $tmpdir/$base"

Unfortunately, cygpath has limitations dealing with paths with trailing
component symlinks, and readlink has limitations dealing with paths with leading
symlinks, while realpath overcomes those limitations and has other options to
deal with symlink issues:

$ cygpath ~/RPi
/home/bwi/RPi
$ readlink ~/RPi
Documents/Info/RPi
$ realpath ~/RPi
/.../Documents/Info/RPi

Could you not use:
tmpdir = $(shell realpath $(cygpath -aU $(objdir)/testsuite/tmp/))
or:
tmpdir = $(shell cygpath -aU $(objdir)/testsuite/tmp/ | xargs realpath)
otherwise:
	pfx=$(realpath /proc/cygdrive)
to get the drive prefix and use that directly when appropriate?

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
