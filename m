Return-Path: <SRS0=TY3p=II=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.227])
	by sourceware.org (Postfix) with ESMTP id A1BDB4BA540B;
	Sun, 18 Oct 2026 10:56:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A1BDB4BA540B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A1BDB4BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.227
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792320970; cv=none;
	b=nLMxdbSItugByWwdIom4xjoW7U+6PdbQKKOZG+AcxjnI53M2BrcObGap+eB0zX4BdAzBdKv5vWIU3is4kcXyCMr2anN9mkZwl7W9mxY67yjd3DtM77trJPRC5thM0MsRHRYq2RbB+Ugp7rkrNGQqyWRzkZfhgnTFREDdgr1pANM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792320970; c=relaxed/simple;
	bh=hJAVpL1Ik8IoGC/SCQg6PEr118852A3zwJnaAT+ptyk=;
	h=Message-ID:Date:MIME-Version:From:To:Subject; b=VJ6NxGBbn7iE2xUZel3evyVBESxWLbMKplTonVfvPbdgFSSa63v85LWlxIXXq5PF4MFijfhOk5dJy9AP5wBCgsziv1gI39a6wPodYKHIvP5EyV7LVsTvwJKrR1wwsYn3/+KcEueRmzNv7qIYaeegHfDcD/QrgaqpqQtroHij1W8=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A1BDB4BA540B
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161CE0EB942B6
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEwVp9RroULgMEe52AHBzFUBBt8x9KQgNuVQygthhkx35N/uVzopIg0pvNOmK9tlllD2BEcUSzLnBQOEsGXPM5QLsvw9Q86CyMlsDYgcEs1J9cwmqpvggCtEb5EPNqZf0Eor80jdO39rMQBUyYry715cMLrau68HE7AAAcMgOUbgE0+R0Ac6JNFimUHmDMG5dSRpONkeZTfXnQWZO7cFzvLtg2MjFxLw1mHrk9rNsC7VIx3qoe7Vxi/TewMOLfi8PnoYcWP4N3B8nqr5rsT4VJDCBTEqHPPoscrL14Elgqr/sA7r9ok3FBDdlOPGwVKbw92CQVvJY53A9Z/vd64wDzYY2YRV11ZdwMoiEEFzAbEba+SUAbyTPUz6oTcOjMIn+hahpIlPd6BBVCx86u9iJcbbdZtel85MEaZYXlRy0+3/6PweSnLCq6Qg6AfpwOFTCaMasb6abUvRyZVHXnCaPnb5lY6j0WtCrt0YPUUKYOYV1KdlZDU9EUqN7rR9akiWmLkoSYJOrz5Z0IcHr7yETa/WIXWjoi7URfZqiODznUNmChm0v4CTgPio2NQg5zaiyjKnIPgeF7GBHo3Uvy4zj/KNFoRBjP+OMJnuKuxup2c1bqtBHR6mFcxSH6EzuEn0DEkLUAoaKSfNG97HiY+TetPDbmDZP2Z4pWHZJFV+fFYww
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161CE0EB942B6; Sun, 18 Oct 2026 11:56:06 +0100
Message-ID: <636bc5ac-7500-4d18-966d-ffb73d87da3c@dronecode.org.uk>
Date: Sun, 18 Oct 2026 11:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
To: cygwin-developers@cygwin.com, Cygwin Patches <cygwin-patches@cygwin.com>
Subject: The meaning of "Signed-off-by:" in patches
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>


I've made a (long overdue) revision to the "Contributing the the Cygwin 
DLL" page [1], to state what we think "Signed-off-by:" in a patch means 
(going forward), by reference to the DCO [2].

Hopefully, this is uncontroversial and unproblematic, but please let me 
know if you think otherwise...

[1] https://cygwin.com/contrib/dll.html#before_starting_legal
[2] https://developercertificate.org/

