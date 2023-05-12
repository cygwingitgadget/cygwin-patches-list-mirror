Return-Path: <SRS0=7AoM=BB=shaw.ca=brian.inglis@sourceware.org>
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
	by sourceware.org (Postfix) with ESMTPS id 7AF95385558E
	for <cygwin-patches@cygwin.com>; Fri, 12 May 2023 18:09:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7AF95385558E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
	by cmsmtp with ESMTP
	id xVL0pupC06NwhxXD8pFW6Q; Fri, 12 May 2023 18:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1683914986; bh=Q8z/KdG3TYuczYU1gUy0W/F4mjBfdUtLy/ownt8uUE4=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=SzES/uTme3C5sASS1dtrhAVBluatgA+Z+7wEr62PMqP0/4HShB3OEeCYfqjHqcXsf
	 wFCwPR+wU9B/TR0FZjU8ERqwEY7IjJbQZLSixrOEzJbFswXdmWQzrBqtAY1H4Csfxt
	 42I0Deg0FmTOhTlVNCMBQFnxSIx6+m5FJCMB0+vCyQJQ7cRRgsszCvtAmviM+H+Ifk
	 gdkfPHl5NuzB1+ZySF3iKvP8xBmqPuWqpmUmNEQkB8CPjE5QEzHVWfkHmRR2ffCZYx
	 jUjcNJ3IBM41QWUPra9OeqvBJrM8L9zrMmXlyuh3oOrilRCdQFbP9oPulm+feWRl1u
	 UBdUFJFVFFzFQ==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id xXD8pGccmHFsOxXD8pXnJq; Fri, 12 May 2023 18:09:46 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=645e80ea
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=QyXUC8HyAAAA:8 a=eyxwhcs4L-4Zy0_zIioA:9 a=QEXdDO2ut3YA:10
 a=h7JA3rcu9YcA:10 a=Cl4EjR86i8IA:10
Message-ID: <8e45602e-91c6-9621-1e70-4b1b3c400679@Shaw.ca>
Date: Fri, 12 May 2023 12:09:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): Add Linux 6.3
 cpuinfo
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <68bbf3607bdf37fcd32613aa962abe50846d968a.1682994011.git.Brian.Inglis@Shaw.ca>
 <0a50e9ad-59c8-65e9-95f5-f53843fbf918@dronecode.org.uk>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <0a50e9ad-59c8-65e9-95f5-f53843fbf918@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLADX1rty7jybCz4sqVpUftUF25ds+O225u9D02ZYTn7Q6swDonti8yTSf4JNFXc0PSTt9que5ODCsv9lDcje9/0tXrY+rDESKp8JUs0iuUOIoWwtKWS
 Zm884ox9MiecSm5yYZ/AC8mdFB2YyvfNIFq7X/QPLQ7Qe+n7VFfl1yH88CHJ1gYRLcjmsr3QulPyjJ9jaGY57MR1c5nMJ4DHd60=
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-05-12 09:36, Jon Turney wrote:
> On 08/05/2023 04:12, Brian Inglis wrote:
>> cpuid    0x00000007:0 ecx:7 shstk Shadow Stack support & Windows 
>> [20]20H1/[20]2004+
>>             => user_shstk User mode program Shadow Stack support
>> AMD SVM  0x8000000a:0 edx:25 vnmi virtual Non-Maskable Interrrupts
>> Sync AMD 0x80000008:0 ebx flags across two output locations
> 
> Thanks.  I applied this.
> 
> Does this need applying to the 3.4 branch as well?

How many users with the latest models will worry about this before 3.5 release 
about October, and may Cygwin have support by then?

>> ---
>>   winsup/cygwin/fhandler/proc.cc | 29 ++++++++++++++++++++++-------
> 
>> +      /* cpuid 0x00000007 ecx & Windows [20]20H1/[20]2004+ */
>> +      if (maxf >= 0x00000007 && wincap.osname () >= "10.0"
>> +                     && wincap.build_number () >= 19041)
>> +        {
>> +      cpuid (&unused, &unused, &features1, &unused, 0x00000007, 0);
>> +      ftcprint (features1,  7, "user_shstk");    /* "user shadow stack" */
>> +    }
>> +
> 
> This seems a little odd and maybe worthy of a comment, as surely the CPU has the 
> capability irrespective of the OS?

Yes, see the log comment documenting the shtsk feature and the Windows release 
supporting the process feature, and the patch comment echoing that.

Intel 11th gen and AMD Zen3+ processor models both support the same Control-flow 
Enforcement Technology CET and shstk cpuid and arch features, save areas, MSRs, 
etc.

That is the (currently commented out in the patch) shstk feature, which is 
detected by the Linux kernel but not reported by Linux cpuinfo, and not yet 
fully supported in the kernel by the Intel CET Linux patches.

Whereas Linux cpuinfo does report "user_shstk", which depends on kernel, 
process, compiler, library, and image support, which requires Windows from 
[20]20H1/[20]2004+ enabling and setting up the supported variants of CET flagged 
in one of the process image debug headers, and saving/restoring the shadow stack 
pointer SSP register.

https://www.intel.com/content/www/us/en/developer/articles/technical/technical-look-control-flow-enforcement-technology.html

The current GCC supports -mshstk, but I don't know if there is yet any back end 
support for variants of CET to be flagged in ELF or PE32+ process image debug 
headers, or plans for newlib x86 or Cygwin startup support, and exception 
handling?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
