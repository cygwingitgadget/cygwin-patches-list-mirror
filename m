Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id 2CE25393C870
 for <cygwin-patches@cygwin.com>; Fri, 28 Aug 2020 13:57:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2CE25393C870
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id Besek3oZIng7KBesfk8xvH; Fri, 28 Aug 2020 07:57:25 -0600
X-Authority-Analysis: v=2.3 cv=ecemg4MH c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=LZesOzRlAAAA:20 a=2z1OXlWFAAAA:8 a=mDV3o1hIAAAA:8
 a=20KFwNOVAAAA:8 a=zxemJ--iAAAA:8 a=jChkm-x5hCMFubTIiR0A:9 a=QEXdDO2ut3YA:10
 a=SNRPda0NjyR9MlWdJ_lJ:22 a=_FVE-zBwftR9WsbkzFJk:22 a=W7RGQCILMHV2VnGx2DLc:22
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] CI update
To: cygwin-patches@cygwin.com
References: <20200826210409.2497-1-jon.turney@dronecode.org.uk>
 <20200827084918.GV3272@calimero.vinschen.de>
 <1b88af66-9b92-99a3-a4e8-4ed1a506b19a@SystematicSw.ab.ca>
 <20200828084305.GH3272@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Autocrypt: addr=Brian.Inglis@SystematicSw.ab.ca; prefer-encrypt=mutual;
 keydata=
 mDMEXopx8xYJKwYBBAHaRw8BAQdAnCK0qv/xwUCCZQoA9BHRYpstERrspfT0NkUWQVuoePa0
 LkJyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFN5c3RlbWF0aWNTdy5hYi5jYT6IlgQTFggA
 PhYhBMM5/lbU970GBS2bZB62lxu92I8YBQJeinHzAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAAAoJEB62lxu92I8Y0ioBAI8xrggNxziAVmr+Xm6nnyjoujMqWcq3oEhlYGAO
 WacZAQDFtdDx2koSVSoOmfaOyRTbIWSf9/Cjai29060fsmdsDLg4BF6KcfMSCisGAQQBl1UB
 BQEBB0Awv8kHI2PaEgViDqzbnoe8B9KMHoBZLS92HdC7ZPh8HQMBCAeIfgQYFggAJhYhBMM5
 /lbU970GBS2bZB62lxu92I8YBQJeinHzAhsMBQkJZgGAAAoJEB62lxu92I8YZwUBAJw/74rF
 IyaSsGI7ewCdCy88Lce/kdwX7zGwid+f8NZ3AQC/ezTFFi5obXnyMxZJN464nPXiggtT9gN5
 RSyTY8X+AQ==
Organization: Systematic Software
Message-ID: <2abf7aa2-c926-8f7b-3f70-b508b33fe101@SystematicSw.ab.ca>
Date: Fri, 28 Aug 2020 07:57:24 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200828084305.GH3272@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHqR3Tz0Uof3ws7R+vBOQy54temaKX1XzuyvvXRmQrSZyHeU9StDlay+YBp+naPStZEZa+pP0pIp2yw2FsowL5UAIfKakTt/UzFT9Rj+QezbmnB/QoLM
 Ef4Kt+gPy1spr+zbhI88LWlPrFhfh6c7Fbjjhp8ytaJZXl3PEDcpWipeQVg+ey2b0Qpui3DRC50u8Q==
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 28 Aug 2020 13:57:28 -0000

On 2020-08-28 02:43, Corinna Vinschen wrote:
> On Aug 27 13:29, Brian Inglis wrote:
>> On 2020-08-27 02:49, Corinna Vinschen wrote:
>>> On Aug 26 22:04, Jon Turney wrote:
>>>> Since we recently had the unpleasant surprise of discovering that Cygwin
>>>> doesn't build on F32 when trying to make a release, this adds some CI to
>>>> test that.
>>>>
>>>> Open issues: Since there don't seem to be RedHat packages for cocom, this
>>>> grabs a cocom package from some random 3rd party I found on the internet.
>>
>> New official site V0.98 Unicode 8:
>>
>> 	https://github.com/dino-lang/dino/blob/master/cocom.spec
> 
> Weird version numbering scheme.  Our cocom package is version 0.996.
> Is it safe to assume this stuff is newer then ours?

Same guy Vladimir Makarov and link from previous SF to current GH sources; not
seeing the earlier emphasis on Russian armaments, rather focus is on Dino
language; affiliation RedHat Toronto; GH INSTALL files all date from 20 years
ago; our CHANGES says Win32 support was removed in 2007 at the top, and that
agrees with GH ChangeLog, which continues up to 2019; closed Issue mentions he
changed to autotools for Cygwin and MacOSX between 2015 and 2016; switches email
from users.sf.net to gcc.gnu.org in 2016, and redhat.com briefly 2016 Mar, about
when he switched to GH.

There are few mentions of versions; preference on GH seems to be dates, latest
mainly 2016, regenerated configure, Makefile.in, aclocal.m4 across directories 9
months ago: although our file dates are 2015, that version 0.996 applies to
Ammunition from 2002; version mentions include above Ammunition v0.996,
Onigurama 6.0.0, Dino updates to .5 and .55, http://dino-lang.github.io/download
offers V0.97 with Dino 0.5, GH says V0.98 with Dino 0.55.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
