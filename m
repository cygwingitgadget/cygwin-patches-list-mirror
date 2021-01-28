Return-Path: <brian.inglis@systematicsw.ab.ca>
Received: from smtp-out-no.shaw.ca (smtp-out-no.shaw.ca [64.59.134.13])
 by sourceware.org (Postfix) with ESMTPS id D94FC3861812
 for <cygwin-patches@cygwin.com>; Thu, 28 Jan 2021 18:45:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D94FC3861812
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=brian.inglis@systematicsw.ab.ca
Received: from [192.168.1.104] ([24.64.172.44]) by shaw.ca with ESMTP
 id 5CIclJdyieHr95CIdlF1AM; Thu, 28 Jan 2021 11:45:48 -0700
X-Authority-Analysis: v=2.4 cv=Yq/K+6UX c=1 sm=1 tr=0 ts=6013065c
 a=kiZT5GMN3KAWqtYcXc+/4Q==:117 a=kiZT5GMN3KAWqtYcXc+/4Q==:17
 a=IkcTkHD0fZMA:10 a=CCpqsmhAAAAA:8 a=RPk8hShqe2G5D_XDKDcA:9 a=QEXdDO2ut3YA:10
 a=ul9cdbp4aOFLsgKbc677:22
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
 <20210128100802.GW4393@calimero.vinschen.de>
 <20210128101429.GX4393@calimero.vinschen.de>
 <6c0a481b-b6fb-0a7e-66ef-36e1941397bb@SystematicSw.ab.ca>
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Organization: Systematic Software
Subject: Re: fhandler_serial.cc: MARK and SPACE parity for serial port
Message-ID: <a4cffe34-479b-d787-cc28-4bc03121304e@SystematicSw.ab.ca>
Date: Thu, 28 Jan 2021 11:45:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <6c0a481b-b6fb-0a7e-66ef-36e1941397bb@SystematicSw.ab.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJksMkepMy/mb4uunDD2Iu/6BkWGhZhx29FZA9CNOzLKdUR/hdoNLFZ7NnVwzLcMInzk2U15g03BFPetBHQEXRGVpepZNvYsh5KG3qJvmb9XzQSvWPrn
 J+oBdaT7TS0zw5p2IXWXO4c9/KeaD3ZTijf2fK11chFWMNYdQ3y5pZoC5LrMBC6yA0gEWAYhKqqCyjE+jpcUkEBwHD4thDgKoMU=
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00, BODY_8BITS,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_LOW,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Thu, 28 Jan 2021 18:45:50 -0000

On 2021-01-28 10:17, Brian Inglis wrote:
> On 2021-01-28 03:14, Corinna Vinschen via Cygwin-patches wrote:
>> On Jan 28 11:08, Corinna Vinschen via Cygwin-patches wrote:
>>> Hi Marek,
>>> thanks for the patch.  [...]
>>>> index 17e8d83a3..933851c21 100644
>>>> --- a/winsup/cygwin/include/sys/termios.h
>>>> +++ b/winsup/cygwin/include/sys/termios.h
>>>> @@ -185,6 +185,7 @@ POSIX commands */
>>>>   #define PARODD 0x00200
>>>>   #define HUPCL 0x00400
>>>>   #define CLOCAL 0x00800
>>>> +#define CMSPAR  0x40000000 /* Mark or space (stick) parity.  */
>>
>> Why did you choose such a big value here?  Wouldn't it be nicer just to
>> follow up with
>>
>>    #define CMSPAR 0x10000
>>
>> or am I missing something here?
> 
> GLIBC/Linux compatibility:
> https://sourceware.org/git/?p=glibc.git&a=search&h=HEAD&st=grep&s=define+CMSPAR
> 
> sysdeps/unix/sysv/linux/alpha/bits/termios-baud.h
>    23 #ifdef __USE_MISC
>    24 # define CBAUD  0000037
>    25 # define CBAUDEX 0000000
>    26 # define CMSPAR   010000000000          /* mark or space (stick) parity */
>    27 # define CRTSCTS  020000000000          /* flow control */
>    28 #endif
> sysdeps/unix/sysv/linux/bits/termios-baud.h
>    23 #ifdef __USE_MISC
>    24 # define CBAUD   000000010017 /* Baud speed mask (not in POSIX).  */
>    25 # define CBAUDEX 000000010000 /* Extra baud speed mask, included in CBAUD.
>    26                                  (not in POSIX).  */
>    27 # define CIBAUD  002003600000 /* Input baud rate (not used).  */
>    28 # define CMSPAR  010000000000 /* Mark or space (stick) parity.  */
>    29 # define CRTSCTS 020000000000 /* Flow control.  */
>    30 #endif
> sysdeps/unix/sysv/linux/powerpc/bits/termios-baud.h
>    23 #ifdef __USE_MISC
>    24 # define CBAUD  0000377
>    25 # define CBAUDEX 0000020
>    26 # define CMSPAR   010000000000          /* mark or space (stick) parity */
>    27 # define CRTSCTS  020000000000          /* flow control */
>    28 #endif
> sysdeps/unix/sysv/linux/sparc/bits/termios-baud.h
>    23 #ifdef __USE_MISC
>    24 # define CBAUD   0x0000100f
>    25 # define CBAUDEX 0x00001000
>    26 # define CIBAUD  0x100f0000     /* input baud rate (not used) */
>    27 # define CMSPAR  0x40000000     /* mark or space (stick) parity */
>    28 # define CRTSCTS 0x80000000     /* flow control */
>    29 #endif
> 
>> Also, on second thought I think CMSPAR should follow CRTSCTS, a few
>> lines below, because of its numerical value higher than CRTSCTS.
> 
> GLIBC/Linux normally has it lower:
> $ grep -C2 'define\s\+CMSPAR' /usr/include/**/*.h
> /usr/include/asm-generic/termbits.h:
> #define  B4000000 0010017
> #define CIBAUD      002003600000    /* input baud rate */
> #define CMSPAR      010000000000    /* mark or space (stick) parity */
> #define CRTSCTS      020000000000    /* flow control */
> 
> -- 
> /usr/include/i386-linux-gnu/bits/termios.h:
> #ifdef __USE_MISC
> # define CIBAUD      002003600000        /* input baud rate (not used) */
> # define CMSPAR   010000000000        /* mark or space (stick) parity */
> # define CRTSCTS  020000000000        /* flow control */
> #endif

Linux may have inherited this from early Unix, UART, or serial I/O mux docs as 
they use octal, support split input/output speeds, are 16 bit aligned, and some 
of the fields are direct from UART register docs:

  3:0  output baud rate enum
  6:4  output data and stop bit lengths in UART line control register low bits
11:7  output parity and other control and/or status
12    output baud rate high speed extension
15:13 unused
19:16 input baud rate enum
22:20 input data and stop bit lengths in UART line control register low bits
27:23 input parity and other control and/or status
28    input baud rate high speed extension
29    unused
30    mark or space (stick) parity
31    flow control

Cygwin currently supports only up to B3000000 0x100f and cannot easily support:

#define  B3500000 0010016
#define  B4000000 0010017

as bit 3 is already and differently used.

-- 
Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada

This email may be disturbing to some readers as it contains
too much technical detail. Reader discretion is advised.
[Data in binary units and prefixes, physical quantities in SI.]
