Return-Path: <SRS0=ML54=TM=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.128])
	by sourceware.org (Postfix) with ESMTP id 76F853858C5F
	for <cygwin-patches@cygwin.com>; Thu, 19 Dec 2024 20:01:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 76F853858C5F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 76F853858C5F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.128
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1734638490; cv=none;
	b=ibpZhw8cdwbQ5NS7Ndd5jiDSBuRGiy0A5mZqer3/vszHLcRZChOJ47Jf1UKuONXf/JjwShHDj/RlKm4ufOXHSvqP0b7pthxfU9uZ0jTbBSrjjrJ0L7Td+M2SvHyKBi/N/1oHC1vMOOSRIKNGzEZsFASgiofzLeG+SFYHSAo+xzo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1734638490; c=relaxed/simple;
	bh=0IIxoIkQoEIK4Ti5BDuSKyhlIF4VxZ8SvJj6J6GP+O4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=deo1lh9zsc31kPJCLe44uCSO+hxb9H9Vw0BqcIcvbIq+JuQNRPQ3mkZp/k9eWrVwrS+KJ3Tmh1m5TWQ5VtrpordliQQrkJhcHrVXggD4GFntgb6FriQ4M2951L7Hs1AbCzwMtxltEItnKxb2/wYXdEOtaL28G5SPxXQEnAJaRgc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 674901FF0235C680
X-Originating-IP: [86.140.193.24]
X-OWM-Source-IP: 86.140.193.24
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgudeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhvegjtgfgsehtkeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeffheeljeevgeeigeelgeettdehffekueethffghfevledvheejudevfeffvefgieenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekiedrudegtddrudelfedrvdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdelngdpihhnvghtpeekiedrudegtddrudelfedrvdegpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqddvgedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtgedpnhgspghrtghpthhtohepvddprhgtphhtthho
	pegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepkhgsrhhofihnsegtohhrnhgvlhhlrdgvughu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (86.140.193.24) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 674901FF0235C680; Thu, 19 Dec 2024 20:01:04 +0000
Message-ID: <5ab5b7d9-903f-4bd4-82c0-1826de2520e3@dronecode.org.uk>
Date: Thu, 19 Dec 2024 20:01:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mmap fixes
To: Ken Brown <kbrown@cornell.edu>
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
 <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
 <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
 <3c63a503-af61-4a6d-8bae-b9dbab839fce@cornell.edu>
 <Z2RXbRhvAkGrXS6I@calimero.vinschen.de>
 <d7a916ea-6bab-494f-8b16-c2310eae259b@cornell.edu>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <d7a916ea-6bab-494f-8b16-c2310eae259b@cornell.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_FILL_THIS_FORM_SHORT autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 19/12/2024 19:50, Ken Brown wrote:
> On 12/19/2024 12:27 PM, Corinna Vinschen wrote:
>> On Dec 19 11:19, Ken Brown wrote:
>>> I've pushed the two modified commits to both main and cygwin-3_5-branch.
>>> When I pushed to main, I got back the following message from git:
>>>
>>> remote:  Committer: Ken Brown <kbrown@server2.sourceware.org>
>>> remote: Your name and email address were configured automatically based
>>> remote: on your username and hostname. Please check that they are 
>>> accurate.
>>> remote: You can suppress this message by setting them explicitly.
>>>
>>> I don't recall ever seeing this before, but it's been awhile since I've
>>> pushed to main.  Is this to be expected or did I do something wrong?  
>>> I do
>>> have my name and email address set in ~/.gitconfig:
>>>
[...]
> Maybe this has something to do with the way scallywag is invoked to do a 
> build.  Jon, is the problem that I don't have a .gitconfig on 
> sourceware?  In any case, I'm inclined to ignore this unless someone 
> tells me I should fix it.

Yeah, the clue here is the "remote:".  All this is happening on sourceware.

The process of requesting a build from scallywag is kicked off by the 
post-receive hook on sourceware generating a commit for you in the 
cygwin packaging repository, updating the cygport. (See [1])

As you can see this commit has your automatically configured committer 
identity.

No cause for concern or alarm. Although, I'm not sure why this might 
have just started happening.


[1] 
https://cygwin.com/cgit/cygwin-packages/cygwin/commit/?id=ab13d52d5dbb293f3b7525dd9520de2b55854724

