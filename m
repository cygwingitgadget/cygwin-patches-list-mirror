Return-Path: <SRS0=rrHt=VZ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id E419C3858D28
	for <cygwin-patches@cygwin.com>; Thu,  6 Mar 2025 14:36:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E419C3858D28
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E419C3858D28
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1741271771; cv=none;
	b=bZPx8rAnsUsqk1xtVPn+C9tfRMi5/ln5H9YHi1W0Lf6TQUmoq/U7pxJ5TVJV/1w+mMQH0M+JGPPClu2uAPPmdfiA9I8+bQ2tBLrKgQAMhhxqFxD/UsChl4bBqRe/8g9FgmnbxUJIVrwWzD7yMOgYPBcafcowHvXgH9+JuGmRHIU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1741271771; c=relaxed/simple;
	bh=W7MgpklD4s1GxW6VgFJ4ojYOMR5+psQCV5CxMiAOg0w=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=kLFB6oA6yObW+qsiuxx6CqsdBJ2OtxF0DFhzcaLUmVXintK4EVK8LnCZHQGEVFvkxtCOrr9gWspwd7S+Q9SVJhLcJL3qn1hwgykS9lCcAz1bXxYAaoOa8irIEoPabSvYbQg2N5+QFJvgWVYQupwoejbCxZRYZFykKTmdht7OEXo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E419C3858D28
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901ED0B3BA898
X-Originating-IP: [86.133.181.121]
X-OWM-Source-IP: 86.133.181.121
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfufhfhvegjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvtdfgudduueehveffvdejgfeileeugfeivedvgfehueelffffgeejudduhfegtdenucfkphepkeeirddufeefrddukedurdduvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudeffedrudekuddruddvuddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudeffedqudekuddquddvuddrrhgrnhhgvgekiedqudeffedrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddutddpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgv
	shestgihghifihhnrdgtohhm
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (86.133.181.121) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901ED0B3BA898 for cygwin-patches@cygwin.com; Thu, 6 Mar 2025 14:36:09 +0000
Message-ID: <6ac50523-b7f7-40cb-8440-6e21af8a9deb@dronecode.org.uk>
Date: Thu, 6 Mar 2025 14:36:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: signal: Add one more guard to stop signal
 handling on exit().
References: <20250306110243.1233681-1-takashi.yano@nifty.ne.jp>
 <Z8mDKd2vqPJX2BX5@calimero.vinschen.de>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <Z8mDKd2vqPJX2BX5@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 06/03/2025 11:12, Corinna Vinschen wrote:
> On Mar  6 20:02, Takashi Yano wrote:
>> The commit 3c1308ed890e adds a guard to stop signal handling on exit()
>> in call_signal_handler(). However, the signal that is already queued
>> but does not use signal handler may be going to process even with that
>> patch.
>> This patch add one more guard at the begining of sigpacket::process()
>> to avoid that situation.
>>
>> Fixes: 3c1308ed890e ("Cygwin: signal: Fix a problem that process hangs on exit")
>> Reviewed-by:
>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>> ---
>>   winsup/cygwin/exceptions.cc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
>> index 759f89dca..a67529b19 100644
>> --- a/winsup/cygwin/exceptions.cc
>> +++ b/winsup/cygwin/exceptions.cc
>> @@ -1457,7 +1457,7 @@ sigpacket::process ()
>>   
>>     /* Don't try to send signals if we're just starting up since signal masks
>>        may not be available.  */

Looks like this comment should be updated? Maybe just "starting up or 
shutting down"? Or the reason why sending signal while shutting down is 
unsafe?

>> -  if (!cygwin_finished_initializing)
>> +  if (!cygwin_finished_initializing || ext_state > ES_EXIT_STARTING)
>>       {
>>         rc = -1;
>>         goto done;
>> -- 
>> 2.45.1
> 
> Makes sense, please push.
