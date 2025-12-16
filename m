Return-Path: <SRS0=Sbr8=6W=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by sourceware.org (Postfix) with ESMTPS id C60844BA2E2B
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 18:24:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C60844BA2E2B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C60844BA2E2B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765909463; cv=none;
	b=lumaTx52/MSGe4xcZPaf29AePFipVD6fjcFrYzJa8uH0FBqG5mVS+98Eg7pOdK1LtbkFG6DxFxL8q575XwUOAO4fq/EAh1xYusl0I86Hfjg9djUiQyaD+Z7D5vBH9IyluMZyzm7+e2SDYuLDh+uTqH5tMLr0d71xCrzezb5iC04=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765909463; c=relaxed/simple;
	bh=Tl1xA0pxovNLpVi4qygGOK22/73W58Fkoa+V2qr4bAw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=RdxRJJM8TFUNvFXDFoms5z9qUPPOH14Ogzqsv1ZeMtIPDopWR8HGdx1Sv2GccX6tzCO6KLCqkHjSUSlzPpO2+l+M0631G7n43t5FmMm6UFUgzZsE12i0aWLVv47oqhR1otMz0ZfvRwBxG5cUWC1trUverD9c4UA0fu8B0YXilRo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C60844BA2E2B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=WfTb8L8U
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 67EF51A0510
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 18:24:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf06.hostedemail.com (Postfix) with ESMTPA id F04ED20015
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 18:24:21 +0000 (UTC)
Message-ID: <c397ed8b-083c-4bdc-834e-f27079d01416@SystematicSW.ab.ca>
Date: Tue, 16 Dec 2025 11:24:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: pty: Fix ESC sequence parsing in
 pty_master_fwd_thread
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
 <20251210015233.1368-2-takashi.yano@nifty.ne.jp>
 <aUFM7SdTYNVAAeN6@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <aUFM7SdTYNVAAeN6@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: F04ED20015
X-Stat-Signature: xg58x6nmsgc9i5eiya7ickosxz9dwe7m
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_SHORT,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18xhC2cUEVcVrpfFsitUnRSl/Ejdj5Emq4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=b6QucZl1GLdZ63XvS0Y9QSmKrxYDwtlChYNS0Zs2nhk=; b=WfTb8L8U7OM4e1bDvJu09/ctbMiZEugYNF4DlP4w1gYB2Lh91afSQD2kOquwEhR23aURtU0Ju03d8bZrX/H0pqIyaRCBI9648lDBKAknEVeCZsGm09870sLpEwXqipWTfR8crtkTc5XQnotsx3YlmSKYiAMi9EshRmh37pAr/R0Hmvrte1FFzsOW82xdIc9HRNSLnR1Jv7vCKB3IKUhK5iyO6Y1EmbI7HaKietmfUAVQGN2FqkEM2sjck3OMnWYNbAb94YZWbs6spUndTuDA5J9XIh0X2rGrBjO6gKnbqIRIrhEON7UYL8XOmW4DJTXMOdfmxb/A2oSTFFfQjLZ4aQ==
X-HE-Tag: 1765909461-697006
X-HE-Meta: U2FsdGVkX1+iFr5Su3Snobp5w/qBK6ZxKsqkeBSt4gj5IeMJOTqCC6pTMHtBO7Z+JVQlfluH50mF2S2jgx+mx/aaoItEPUJIlDGXqPUdSO8fqyWSZdIQ3pS9Z0Q+1P1XKbpSi8p5EKhAeHKghOnSPDcM9Y2WDCaDQa10PTqKEi44vCzFFvdCRREWaNOe3jMY0Ofqf1vL0fLkkUwGinOmDz2yIjGBrzAwybK2EwkeLB2Aasbz5d7N/Mg2HK+D3/FcAuH4q6F5hlrxUCHDvhlzJzuHCf+c0FlDtwK8ATozFtt8yD2XC+fy56jE9TnRQHbDfL9hES9BZTDzXFRrfXfIhejBIKqoHTRg4+6HDGPtVbC11n80LGohryp8HH45Yzpsq+ogiugzfYmaxB1NuroONkD2/QRScL4y9qzWcGlwSzKhD/HwrUswPO+BXoJcoyCWtm73x7F06Y7GgVcu7tiPvSg/njpYdbEVzpFBG84elPgYiqL/2GckG383tLMztDt4SqjZz12R3hGz16mnZJlS0sv6f69a/TL/utYflG/03IetqLlXJqY5lgyX0f/nfKw/6ZAZLAmAFj+JCWJlzxmbgTNFfeOcs+s3/oRyKekxlQm1bypy8eiMLaj/aQX4E4546buaGHHW+z12K2Mf8AV92Q1kiAM4twpYzfPt0fby0yE=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-12-16 05:13, Corinna Vinschen wrote:
> On Dec 10 10:52, Takashi Yano wrote:
>> This patch fixes the bug in ESC sequence parser used when pseudo
>> console is enabled in pty_master_fwd_thread(). Previously, if
>> multiple ESC sequences exist in a fowarding chunk, the later one
>> might not be processed appropriately. In addition, the termination
>> ST was not supported, that is, only BEL was supported.
> 
> What's ST?  I only know STX, 0x02 in the C0 codeblock.  There's an ST in
> the C1 codeblock, 0x9c, "String Terminator", but I don't see this in the
> code, nor are the other C1 controls even recognized here.
Some symbolic character function names would help a lot!

ST \E\\ is an alternative to \a <BEL> another ANSI X3.64/FIPS-86/ECMA-48/DEC STD 
070/ISO 6429 control sequence with 7/8 bit alternatives like APC, DCS, CSI, OSC, PM:

https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Operating-System-Commands

"Operating System Commands

OSC Ps ; Pt BEL
OSC Ps ; Pt ST"

https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-Control-Bytes_-Characters_-and-Sequences

"o Some controls (such as OSC) introduce a string mode, which is ended on a ST 
(string terminator)."

https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h3-C1-lparen-8-Bit-rparen-Control-Characters
"...
	ESC P	Device Control String		(DCS  is 0x90).
...
	ESC [	Control Sequence Introducer	(CSI  is 0x9b).
	ESC \	String Terminator		(ST   is 0x9c).
	ESC ]	Operating System Command	(OSC  is 0x9d).
	ESC ^	Privacy Message			(PM   is 0x9e).
	ESC _	Application Program Command	(APC  is 0x9f).
..."

ANSI X3.64-1979 FIPS-86 Additional Controls for Use with ANS Code for 
Information Interchange 1979-07-18

	https://nvlpubs.nist.gov/nistpubs/Legacy/FIPS/fipspub86.pdf

ECMA-48 Control Functions for Coded Character Sets 5th.ed 1991-06

https://ecma-international.org/wp-content/uploads/ECMA-48_5th_edition_june_1991.pdf

EL-SM070-00 DEC STD 070 Video Systems Reference Manual 1991-12-03

http://www.bitsavers.org/pdf/dec/standards/EL-SM070-00_DEC_STD_070_Video_Systems_Reference_Manual_Dec91.pdf

ISO/IEC 6429:1992 Control functions for coded character sets Ed.3 1992-12

	https://www.iso.org/standard/12782.html

>> Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
>> Reviewed-by:
>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>> ---
>>   winsup/cygwin/fhandler/pty.cc | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
>> index 679068ea2..3b0b4f073 100644
>> --- a/winsup/cygwin/fhandler/pty.cc
>> +++ b/winsup/cygwin/fhandler/pty.cc
>> @@ -2680,7 +2680,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>>   	  int state = 0;
>>   	  int start_at = 0;
>>   	  for (DWORD i=0; i<rlen; i++)
>> -	    if (outbuf[i] == '\033')
>> +	    if (state == 0 && outbuf[i] == '\033')
					^ ESC	'\x1b'
As a long former RAD50 and 08 fan can we please move on to hex \x1b now? ;^>
>>   	      {
>>   		start_at = i;
>>   		state = 1;
>> @@ -2688,12 +2688,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>>   	      }
>>   	    else if ((state == 1 && outbuf[i] == ']') ||
						^ OSC
>>   		     (state == 2 && outbuf[i] == '0') ||
						^ OSC_ICN_NM_WIN_TTL
>> -		     (state == 3 && outbuf[i] == ';'))
>> +		     (state == 3 && outbuf[i] == ';') ||
						^ PARAM_SEP
>> +		     (state == 4 && outbuf[i] == '\033'))
						^ ESC	'\x1b'
>>   	      {
>>   		state ++;
>>   		continue;
>>   	      }
>> -	    else if (state == 4 && outbuf[i] == '\a')
>> +	    else if ((state == 4 && outbuf[i] == '\a')
						^ BEL
>> +		     || (state == 5 && outbuf[i] == '\\'))
						^ ST
>>   	      {
>>   		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
>>   		if (memmem (&outbuf[start_at], i + 1 - start_at,
>> @@ -2701,11 +2703,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
>>   		  {
>>   		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
>>   		    rlen = wlen = start_at + rlen - i - 1;
>> +		    i = start_at - 1;
>>   		  }
>>   		state = 0;
>>   		continue;
>>   	      }
>> -	    else if (outbuf[i] == '\a')
>> +	    else if (state == 4)
>> +	      continue;
>> +	    else
>>   	      {
>>   		state = 0;
>>   		continue;
>> -- 
>> 2.51.0

[IMHO literals should never appear in code - except *maybe sometimes* 0!
Define all your constants with meaningful names in context before all code,
or in a meaningfully named header with those definitions, if you can't steal 
them from somewhere with a history, say mintty or xterm sources, or ancient 
assembler macros, convert them from a document table, say man pages `man -m 
linux console_codes`, Wikipedia, or xterm (above), or from references therein.]

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
