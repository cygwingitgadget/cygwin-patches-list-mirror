Return-Path: <SRS0=iF8p=I5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.92])
	by sourceware.org (Postfix) with ESMTP id 15CCA4BA2E18
	for <cygwin-patches@cygwin.com>; Sun,  8 Nov 2026 13:12:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 15CCA4BA2E18
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 15CCA4BA2E18
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.92
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794143537; cv=none;
	b=fF56kI7x90aGWqCAkN4XFPKP37o5ldJNJJ3WiGRVPfixtl4G2B1Lq9nANSNr1iqnOMR53aNTd7pcUFY2bvwKjlLcc5M4Eol3B5XEWnym+7JC/mW5m3IDqQF+DolDu+NrdeSSRZAWwG1seH2UGrdZEMru71y3Q5feR74v1dnAGbw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794143537; c=relaxed/simple;
	bh=GVG5cKZyG4cJIoEkRZ/fRHi7sYeve2IWktAJ+55zjLY=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=itw4EAmHxK++VndOOqnXVFm9Nhn0SZ40G4RPf+nxsvNw/u1whPos+OgMGEDz7FogyZmgMhXlOlJvbl4Rm7DRrg8G3dBchpaL3tkt0yWqiHMMOUwzHIU48qCq6RGFp0TRmSL6bwTIMbmv992tAzS/QwysPNbEOkS/3de9/xWq/+4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 15CCA4BA2E18
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A716138147A634E
X-Originating-IP: [80.176.81.8]
X-OWM-Source-IP: 80.176.81.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFq0/a7pyzqIfdXRMkrJTa66JGcIF4CdnG+lOTpn+TCZCf7397pKmC8rosvGknPZEr+w89lp9CW320L5vGbpjvCxBNLtPE0bSKwMG1ofKj7yfsLi1H/0U6oLxqqV48/GZN22gxrrzMpXUv3GKUSLKpu+IKFPCTEfG0ggICZbdjGp1rRc9ZBYPFcDjQszqlFd+E7+Xsr/ChV3r8hMcZ85lUaexLlCIQ6PlfBeW+P8xv8K8SyHNZeXOKE8RLQTO8tRI4AWV7dwOgCKlewndTobC0hj29fm8Sqqvlk1aBWdKgr1d5pxv0wS7U9Qt0O8Y2nGArT1MFfOiCH3ER4yijmkQtHDMqHMkptPctkHcjko7SvuDdCXwqvoqebN9pe4XTnfgk3XA8QEd+vAt65OXQf/PITz1rNuRnNGOiLL0sMRX7KsjDF+5KJ4TXuDzCs9IDjiHteKMF7hgTssILoI6Il87NNbUL5FHdWwCKgjXN6wTgH9QwhY2KN9oh4l3k8wPAq/KoCWNH4DALsqS9SG2rN9zcWbvIJFMFxTk5uMODHPdBtDY4NB5u4l4L/1Wj9DSTKkfDfyVOejTKeeZ4JRxMONppwOuYvbHbIl3x/K4n2n+/R8PTskcQg8NnFxB0uOxftbz9aQmEJ4HDGQhypwEf2uHmjmbM05ClgDQHp065oZbQN6w
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (80.176.81.8) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A716138147A634E; Sun, 8 Nov 2026 13:12:15 +0000
Message-ID: <707bfef1-aa52-491a-9183-b98b8ad4450b@dronecode.org.uk>
Date: Sun, 8 Nov 2026 13:12:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: autoload: drop the unused no_resolve_on_fork
 parameter
References: <PN3P287MB13209A14DE960126F3311558F7A62@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
 <PN3P287MB1320B28B0848F2F91E752442F7662@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
In-Reply-To: <PN3P287MB1320B28B0848F2F91E752442F7662@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 21/10/2026 11:22, Aswin Kalies Ramkumar Mangayarkarasi wrote:
> Hi Jon,
> 
> Gentle ping on this one.
> 
> One note: Outlook mangled the inline copy in the mail body, so it does not
> apply as quoted.  The attached cygwin-autoload-drop-no_resolve_on_fork.patch
> is intact and still applies cleanly to current main.
Applied, thanks.

Sorry about the delay in getting around to this, and thanks very much 
for digging through the history to find out what had gone on here!


