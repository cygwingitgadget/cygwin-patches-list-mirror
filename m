Return-Path: <cygwin-patches-return-9737-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56994 invoked by alias); 5 Oct 2019 21:42:07 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56700 invoked by uid 89); 5 Oct 2019 21:42:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=thru, H*i:sk:95be25e, H*f:sk:95be25e
X-HELO: smtp-out-no.shaw.ca
Received: from smtp-out-no.shaw.ca (HELO smtp-out-no.shaw.ca) (64.59.134.9) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 05 Oct 2019 21:42:05 +0000
Received: from [192.168.1.114] ([24.64.172.44])	by shaw.ca with ESMTP	id GroQi6GC0sAGkGroRit5uh; Sat, 05 Oct 2019 15:42:03 -0600
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, flags
To: cygwin-patches@cygwin.com
References: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca> <95be25ec-eeea-060e-fb40-ed5c7fc787c1@cornell.edu>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Openpgp: preference=signencrypt
Message-ID: <82d83d79-b194-107c-3ff4-6b02e36ea198@SystematicSw.ab.ca>
Date: Sat, 05 Oct 2019 21:42:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <95be25ec-eeea-060e-fb40-ed5c7fc787c1@cornell.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00008.txt.bz2

On 2019-10-05 15:06, Ken Brown wrote:
> On 10/4/2019 6:44 AM, Brian Inglis wrote:
>> fix cache size return code handling and make AMD/Intel code common;
>> fix cpuid level count as number of non-zero leafs excluding sub-leafs;
>> fix AMD physical cores count to be documented nc + 1;
>> round cpu MHz to correct Windows and match Linux cpuinfo;
>> add microcode from Windows registry Update Revision REG_BINARY;
>> add bogomips which has been cpu MHz*2 since Pentium MMX;
>> handle as common former Intel only feature flags also supported on AMD;
>> add 88 feature flags inc. AVX512 extensions, AES, SHA with 20 cpuid calls;
>> commented out flags are mostly used but not currently reported in cpuinfo
>> but some may not currently be used by Linux
> 
> Thanks!  This must have been a lot of work.

Already had the info in some of my own code, that pointed out the discrepancies
between Cygwin and Linux, and prompted the desired to level up.

> It would be easier to review if you would split it up into smaller patches, each 
> doing one thing, to the extent that this makes sense.  For example, the 
> simplification achieved by using the ftcprint macro could be done in a single 
> patch that's separate from the substantive changes.

Unfortunately, that was added later to make the got it/add it/skip it flag cross
checks in Linux order more certain vs my own sequential tabular source.

> A few nits:
> 
>> -      DWORD cpu_mhz = 0;
>> -      RTL_QUERY_REGISTRY_TABLE tab[2] = {
>> +      DWORD cpu_mhz;
>> +      DWORD bogomips;
>> +      long long microcode = 0xffffffff;	/* at least 8 bytes for AMD */
>> +      union {
>> +	  LONG len;
>> +	  char uc_microcode[16];
>> +      } uc;
>> +
>> +      cpu_mhz = 0;
>> +      bogomips = 0;
>> +      microcode = 0;
> 
> Why change the existing intialization style?  How about
> 
>        DWORD cpu_mhz = 0;
>        DWORD bogomips = 0;
>        long long microcode = 0;	/* at least 8 bytes for AMD */

Need to ensure they are initialized each time thru the CPU loop, not just once
on entry, mainly because of what I found out about what I needed to do to get
the variable length REG_BINARY key.

>> +      memset(&uc, 0, sizeof(uc.uc_microcode));
>                ^              ^
> (Space before parenthesis, here and in several other places.)
> 
>> +      cpu_mhz = ((cpu_mhz - 1)/10 + 1)*10;	/* round up a digit */
> 
> Please surround '/' and '*' by spaces (and similarly in what follows).  Also, 
> the comment is confusing.  Maybe "round up to a multiple of 10"?
> 
>> +      for (uint32_t l = maxf; 1 < l; --l) {
>                                              ^
> (Brace on next line, and also in one other place.)

Sorry missed the expected style in those places.
Will tweak and submit v2.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
