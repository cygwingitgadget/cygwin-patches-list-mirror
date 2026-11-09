Return-Path: <SRS0=GRJh=I6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.48])
	by sourceware.org (Postfix) with ESMTP id 151F44BA9009
	for <cygwin-patches@cygwin.com>; Mon,  9 Nov 2026 17:26:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 151F44BA9009
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 151F44BA9009
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.48
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794245194; cv=none;
	b=i20LLbABU1XemGNq1W/oQGa9MaL4xgohH4H5IqtpMb290iOcmXF9HXu+5eqzSbY5jyF+P+CL700F3b1f0I+qS15wPLSE22ANIcP+p+BtYUGFSbUBKccatSKrCdyoaRQRABzWXa4m3GbRywiXb0U2I57I4gN+Ma/bjsIh3zNdbN8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794245194; c=relaxed/simple;
	bh=xlBR9Fnm9y+/8iP5y9BbA+Iz2xR/XyQnUvNw70UN2Us=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=ItbfaNgCmoLfmzF9C8EDM1Pf/QyP+S94CTGCvHTuPoXQJFx2hMjRffV2Ylbduqu8PKJE5wDx631sEWHMNDLT1fyO9In3ShqXGDlyjSRuuIwR8r1tVLCp+wAvof8A6MfxxIaVUguoqjkxCYFiRL73Wc8cBfsRUw2tI8sfaNZ2fnE=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 151F44BA9009
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7159F414BA03A7
X-Originating-IP: [80.176.81.8]
X-OWM-Source-IP: 80.176.81.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEhQjsI8AOgc2DTbPbfe0S+pTUg5NV+i3/iGYLfvzbbg0q8r6tjQ6Gv1bhS4Tgp9GRkGL+wDRPdSG7ULQtU7V96WkbRHNSSdJ2ABCJh6tbU6XK3IpVUECH5TmD8LpM8Hy/moJhyOt8YuaBJjIGIuv4kf3JIczsUmOyCGNBAmoBTuuq+V8Xum/i05Dh2O7uYNhyR71OA2kM+VFzzhVQ1Xv9RWujNjo8RjQ2QQjmtpgw54am8LQEgl9tgNe2v9nqQEPXwViJRsFYHVU/aUjuWhZ63ft+gssliuba/m8UroHUkATeOGV83PpzUb2z8pS1VY8C/BLhshE3RAiUL36bBflqyYlQdZ1MVPtyRov1to5kBN0K/6BN+Dfc74hmfAScHx6Gj7dyfVLcudnhkNAcAbnE3SKteH62TqOjPUHcXahbfJcd7wCo3P34F63YjXi+U8edlNutKaE3apqOTy9GLD1ymoqaXdf7enUH4ivp5sePtnlbNWRQ9cAPVd7fbS0pamOAGdyaaA63qcRme7whiLoxyDxKUZd5fOKEgtRzG+Wbdefv3Yg+Ll93qQFE/WL10fxYwROioWZUo8T1lTuM/e9nSkHTYD/NyGt8cL1e0NQerNnGKq5IOKlKcMH8vD+2fQYBib55cd5GRkqGJ97Ex2qinMACkH1p4PN/53E02ctusYQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (80.176.81.8) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7159F414BA03A7; Mon, 9 Nov 2026 17:26:28 +0000
Message-ID: <21c0e902-875f-4073-b124-3e39a69e3c7a@dronecode.org.uk>
Date: Mon, 9 Nov 2026 17:26:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/2] Cygwin: avoid loading Winsock and iphlpapi at
 process startup
References: <PH0PR00MB338699008F36947D666826C5809E2@PH0PR00MB3386.namprd00.prod.outlook.com>
 <7a6afbac-5973-4606-a3e2-4e0cc7d9ac0f@maxrnd.com>
 <DS0PR00MB33978E175601650E15466932809C2@DS0PR00MB3397.namprd00.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Alexandre Zollinger Chohfi <alzollin@microsoft.com>
In-Reply-To: <DS0PR00MB33978E175601650E15466932809C2@DS0PR00MB3397.namprd00.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 15/10/2026 19:14, Alexandre Zollinger Chohfi via Cygwin-patches wrote:
> Hi Mark,
> 
> Thanks for looking at it.
> 
> On the first question, I found a case where they differ.  The
> GetComputerNameEx documentation says that on a cluster node
> ComputerNameDnsHostname returns the DNS host name of the cluster virtual
> server, while ComputerNamePhysicalDnsHostname returns the node's own
> name.  I can't test a cluster here, but that is reason enough not to
> rely on ComputerNameDnsHostname.  sethostname in the same file already
> uses ComputerNamePhysicalDnsHostname, so v2 of patch 2/2 asks for that
> one instead.  Patch 1/2 is unchanged.
> 
> I rebuilt msys-2.0.dll with v2.  $HOSTNAME, `uname -n` and `hostname`
> are the same as on the unpatched build, and `bash -c true` with
> anonymous pipes as stdio still does not load iphlpapi or ws2_32.  Both
> patches apply cleanly to the current main (80df0a2b5).
> 
> v2 is attached.
FTR, these two patches were applied to the main branch, and so appears 
in our 3.7.0 test releases.

