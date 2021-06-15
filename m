Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 4B862389683A
 for <cygwin-patches@cygwin.com>; Tue, 15 Jun 2021 08:48:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4B862389683A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 15F8mlxT038909
 for <cygwin-patches@cygwin.com>; Tue, 15 Jun 2021 01:48:47 -0700 (PDT)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpduxUAr8; Tue Jun 15 01:48:44 2021
Subject: Re: [PATCH] Cygwin: New tool: cygmon
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20210612064639.2107-1-mark@maxrnd.com>
 <6c87c0bd-bc3c-f2b0-f318-26afadfebf1f@dronecode.org.uk>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <4d037730-8aac-d1d3-8a74-995913ab2345@maxrnd.com>
Date: Tue, 15 Jun 2021 01:48:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <6c87c0bd-bc3c-f2b0-f318-26afadfebf1f@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00, BODY_8BITS,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 SPF_HELO_NONE, SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 15 Jun 2021 08:48:50 -0000

Hi Jon,

Jon Turney wrote:
> On 12/06/2021 07:46, Mark Geisert wrote:
>> This tool is a sampling profiler of Cygwin programs with their DLLs.
>> Presently its development is managed at https://github.com/mgeisert/cygmon.
>> Documentation of cygmon has been added to the usual doc/utils.xml file.
> 
> Nice!
> 
> How attached are you to the name?
> 
> There's nothing cygwin specific about this (you could profile any Windows 
> executable), so does it really need 'cyg' in the name?
> 
> It's a profiler, so what is 'mon' short for?

I (thought I) was sort of riding on the ancient separation in Unix between 
generating the data and displaying it.  Back to Unix v6 the generating was done by 
something with "mon" in the name.. monitor() in the C library syscalling profil() 
to generate the data and write it to the file mon.out.  The separate program 
'prof' read a mon.out file and the corresponding executable to display the data.

Over time mon.out -> gmon.out, and prof -> gprof.  I presume those happened with 
GNU involvement.

So for Cygwin, I riffed on "gmon" by making the data generator, a program in this 
case, 'cygmon'.  gprof still applies as the way to display the data.

> A more detailed review to follow.

I'm going over that review now.  Thanks!

>> There are a couple of one-line fixes to unrelated files for minor issues
>> noticed while implementing cygmon.  The files involved are gmon.c and
>> doc/utils.xml (one line not part of the cygmon updates to that file).
> 
> Please submit the gmon fix as a separate patch, ideally with some commentary about 
> what it fixes.

Sure, will do.

>> diff --git a/winsup/doc/utils.xml b/winsup/doc/utils.xml
>> index 22bd86904..2f256d602 100644
>> --- a/winsup/doc/utils.xml
>> +++ b/winsup/doc/utils.xml
> [...]
>> +
>> +    <refsect1 id="cygmon-desc">
>> +      <title>Description</title>
>> +    <para>The <command>cygmon</command> utility executes a given program, and
>> +      optionally the children of that program, collecting the location of the
>> +      CPU instruction pointer (IP) many times per second. This gives a profile
>> +      of the program's execution, showing where the most time is being spent.
>> +      This profiling technique is called "IP sampling".</para>
> 
> Contrasting this with how 'ssp' profiles (and vice versa there) would be nice.

Good idea.  Will do.

>> +
>> +    <para>A novel feature of <command>cygmon</command> is that time spent in
>> +      DLLs loaded with or by your program is profiled too. You use
>> +      <command>gprof</command> to process and display the resulting profile
>> +      information. In this fashion you can determine whether your own code,
>> +      the Cygwin DLL, or another DLL has "hot spots" that might benefit from
>> +      tuning.</para>
>> +
>> +    <para> Note that <command>cygmon</command> is a native Windows program
>> +      and so does not rely on the Cygwin DLL itself (you can verify this with
>> +      <command>cygcheck</command>). As a result it does not understand
>> +      symlinks in its command line.</para>
>> +    </refsect1>

Thanks,

..mark

