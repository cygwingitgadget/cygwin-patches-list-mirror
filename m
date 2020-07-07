Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-so.shaw.ca (smtp-out-so.shaw.ca [64.59.136.138])
 by sourceware.org (Postfix) with ESMTPS id F3D9D3857C54
 for <cygwin-patches@cygwin.com>; Tue,  7 Jul 2020 18:55:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F3D9D3857C54
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id sskHj51PcYYpxsskIj3LA3; Tue, 07 Jul 2020 12:55:11 -0600
X-Authority-Analysis: v=2.3 cv=OubUNx3t c=1 sm=1 tr=0
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=7vT8eNxyAAAA:8 a=w_pzkKWiAAAA:8 a=CCpqsmhAAAAA:8
 a=RZ24vCjvlsqmbDxLIRQA:9 a=QEXdDO2ut3YA:10 a=YocQtCf9LIkA:10
 a=Mzmg39azMnTNyelF985k:22 a=sRI3_1zDfAgwuvI8zelB:22 a=ul9cdbp4aOFLsgKbc677:22
Reply-To: Brian.Inglis@SystematicSw.ab.ca
Subject: Re: [PATCH] format_proc_cpuinfo: add microcode registry lookup values
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20200707173339.4554-1-Brian.Inglis@SystematicSW.ab.ca>
 <DM6PR09MB4043212C210FD275CD44F296A5660@DM6PR09MB4043.namprd09.prod.outlook.com>
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
Message-ID: <1edd124a-d198-520a-5ad0-091da989c1b3@SystematicSw.ab.ca>
Date: Tue, 7 Jul 2020 12:55:09 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM6PR09MB4043212C210FD275CD44F296A5660@DM6PR09MB4043.namprd09.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfHlIRCxlY6+U8rdVI39VP/xQu9de325HMqrKsFlRw6fsp12fuxUsV6KbYFRxWCVDkeUUQZQoGyQthAy7sReobmCZypvNvn/APYYM6axrvYOrAZUi/fzn
 gA2rjihnnrPGVcWvU0seRT6ox7O/bw22e0w9BWPQLlxghQ4PNPawlWLwpvt0SjNXwosJy7leSL1TtqyLhHUg8VSnptYO/2uKfsGl/kaUzSjxunVMTXmreUNv
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 07 Jul 2020 18:55:13 -0000

Thanks,

I had problems getting anything to run under my test DLLs, so when I finally got
things running, I ran some tests, and everything seemed to work okay, so I
shipped the patch.
As usual, after sending, brain kicked in and I realized why it did not appear to
be picking up some reg keys due to my over-thinko, and nervousness messing
around with the microcode rev reg keys during testing.
Resending retested, refixed patch, and microcode reg keys restored and looking
normal!

On 2020-07-07 12:36, Lavrentiev, Anton (NIH/NLM/NCBI) [C] wrote:
> Hi,
> 
> This is shifting up, IMO:
> 
> +		  microcode <<= 32;		/* shift them down */
> 
> Thanks,
> Anton
> 
>> -----Original Message-----
>> From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
>> Sent: Tuesday, July 07, 2020 1:34 PM
>> To: cygwin-patches@cygwin.com
>> Subject: [PATCH] format_proc_cpuinfo: add microcode registry lookup values
>>
>> Re: CPU microcode reported wrong in /proc/cpuinfo
>>     https://sourceware.org/pipermail/cygwin/2020-May/245063.html
>> earlier Windows releases used different registry values to store microcode
>> revisions depending on the MSR name being used to get microcode revisions:
>> add these alternative registry values to the cpuinfo registry value lookup;
>> iterate thru the registry data until a valid microcode revision is found;
>> some revision values are in the high bits, so if the low bits are all clear,
>> shift the revision value down into the low bits
>> ---
>>  winsup/cygwin/fhandler_proc.cc | 44 +++++++++++++++++++++++++++-------
>>  1 file changed, 35 insertions(+), 9 deletions(-)
>>
>> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
>> index f1bc1c7405..f637dfd8e4 100644
>> --- a/winsup/cygwin/fhandler_proc.cc
>> +++ b/winsup/cygwin/fhandler_proc.cc
>> @@ -692,26 +692,52 @@ format_proc_cpuinfo (void *, char *&destbuf)
>>        union
>>          {
>>  	  LONG uc_len;		/* -max size of buffer before call */
>> -	  char uc_microcode[16];
>> -        } uc;
>> +	  char uc_microcode[16];	/* at least 8 bytes */
>> +        } uc[4];		/* microcode values changed historically */
>>
>> -      RTL_QUERY_REGISTRY_TABLE tab[3] =
>> +      RTL_QUERY_REGISTRY_TABLE tab[6] =
>>          {
>>  	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
>> -	    L"~Mhz", &cpu_mhz, REG_NONE, NULL, 0 },
>> +	    L"~Mhz",		       &cpu_mhz, REG_NONE, NULL, 0 },
>>  	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
>> -	    L"Update Revision", &uc, REG_NONE, NULL, 0 },
>> +	    L"Update Revision",		 &uc[0], REG_NONE, NULL, 0 },
>> +							/* latest MSR */
>> +	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
>> +	    L"Update Signature",	 &uc[1], REG_NONE, NULL, 0 },
>> +							/* previous MSR */
>> +	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
>> +	    L"CurrentPatchLevel",	 &uc[2], REG_NONE, NULL, 0 },
>> +							/* earlier MSR */
>> +	  { NULL, RTL_QUERY_REGISTRY_DIRECT | RTL_QUERY_REGISTRY_NOSTRING,
>> +	    L"Platform Specific Field1", &uc[3], REG_NONE, NULL, 0 },
>> +							/* alternative */
>>  	  { NULL, 0, NULL, NULL, 0, NULL, 0 }
>>          };
>>
>> -      memset (&uc, 0, sizeof (uc.uc_microcode));
>> -      uc.uc_len = -16;	/* -max size of microcode buffer */
>> +      for (size_t uci = 0; uci < sizeof (uc)/sizeof (*uc); ++uci)
>> +	{
>> +	  memset (&uc[uci], 0, sizeof (uc[uci]));
>> +	  uc[uci].uc_len = -(LONG)sizeof (uc[0].uc_microcode);
>> +							/* neg buffer size */
>> +	}
>> +
>>        RtlQueryRegistryValues (RTL_REGISTRY_ABSOLUTE, cpu_key, tab,
>>  			      NULL, NULL);
>>        cpu_mhz = ((cpu_mhz - 1) / 10 + 1) * 10;	/* round up to multiple of 10 */
>>        DWORD bogomips = cpu_mhz * 2; /* bogomips is double cpu MHz since MMX */
>> -      long long microcode = 0;	/* at least 8 bytes for AMD */
>> -      memcpy (&microcode, &uc, sizeof (microcode));
>> +
>> +      unsigned long long microcode = 0;	/* needs 8 bytes */
>> +      for (size_t uci = 0; uci < sizeof (uc)/sizeof (*uc) && !microcode; ++uci)
>> +	{
>> +	  /* still neg buffer size => no data */
>> +	  if (-(LONG)sizeof (uc[uci].uc_microcode) != uc[uci].uc_len)
>> +	    {
>> +	      memcpy (&microcode, uc[uci].uc_microcode, sizeof (microcode));
>> +
>> +	      if (!(microcode & 0xFFFFFFFFLL))	/* some values in high bits */
>> +		  microcode <<= 32;		/* shift them down */
>> +	    }
>> +	}
>>
>>        bufptr += __small_sprintf (bufptr, "processor\t: %d\n", cpu_number);
>>        uint32_t maxf, vendor_id[4], unused;
>> --
>> 2.27.0
> 


-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in IEC units and prefixes, physical quantities in SI.]
