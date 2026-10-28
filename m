Return-Path: <SRS0=B3ed=IS=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id 7D8214BA2E3F
	for <cygwin-patches@cygwin.com>; Wed, 28 Oct 2026 13:03:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7D8214BA2E3F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7D8214BA2E3F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793192639; cv=none;
	b=laRFffPxEIlj5JU1Y/v5mgwMHSG28iCgfTZ0GH4V3grGjKJSYjBvyepGujf+h2QLjq5kJcNPvf7mJvw/Litj/EBoZtKGMmnUQbe4G6aS8nlkZLpkeJt6qVcqTtSb+3JwV3n5FKWkn5APVTxjqjC47N6mP65xbGtbDMVh5OTZ5RM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793192639; c=relaxed/simple;
	bh=TPr21bn41/ppRa/4YQ+pTTclb4UzELy56VA+3wxzJKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=DCSOv77jgSSTbYYptYQNcxnp/P+XPaFzP+m/wfVI5vZY6Ix8HkfdfdMZJSdLyt2oINVh6PBBerNVj3xbAFf82AjK5QY8cquz/9pAshcS9BwIMDFBjcuPLePZRSxv/0zrGbxwaAzTuItlLr9aIO7QvWbfu3mpneyniDfW187Qus8=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7D8214BA2E3F
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715F5F114F2B07
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTFnPMkQCIA2dR156oc6N+MDpHwniBzaZI9dFMwSpS1rGapGFIjUatMI+2LX5bi5GLhzJax/48aF3GZXBC1Mt/3YlmBqBrQaW3559zxV0YxNajrX/qda1zXo3qG5MIudyHSzeQ6mgXTf1FWglsEutGQLYxPmcCOrU3elf/aI2LSI+64dobOJ1axZl8V6l8YID6vz6KM9e2Rwdhqb0RTPp5tSG/VUZUOyVMqsPxeHf59AUoGwYaFSkHnT5Hgos7kj7VEGTC6h/eYQoP4wkut60rN0Q8f4qKvVjFbmWHQ1QXeEXQcbo9qvH3rxr1/07kr1Ie6r+jrHApEaNrFud/i+58XvrXxvMet7Z171e2f+x0BEJBazUe7ch/p1pp4GaVds+quLJPJaG40Aydv86wGw+zkhUTCAl/XHD11YCxYHBL6g+4sYoH85VddUCNWh5V2OeF9uI8oiqL91hoti/SwjT8QmS8jeytgKo6tIP8L6yRW/dvOKQUTQC+/OJM6iiNMfj8lPriwA7T0ssnvP4urXDHuw5QuEvQPi+lcOc+CiWdVh9rMQbpC3CcKWMsuPH2uju5z43U46RZaq144Tyfcb6Ct8AlMqU7MgVCv5WxLtsrfzdAjOyU60QlwhPyMSae+ZGQ5cjXHBTQH40ZPRZ6pKqCipBxTztRiR1RpMYN+zGmuvEg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715F5F114F2B07; Wed, 28 Oct 2026 13:03:49 +0000
Message-ID: <2bcc1fcd-3e47-454e-88ba-bb323e691558@dronecode.org.uk>
Date: Wed, 28 Oct 2026 13:03:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
To: Radek Barton <radek.barton@microsoft.com>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>,
 Evgeny Karpov <evgeny@kmaps.co>
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
 <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
 <aH5CvWENvjsmKbjJ@calimero.vinschen.de>
 <aH5EsVT1Hhe_7yHV@calimero.vinschen.de>
 <GV4PR83MB09410EFD509ABD23BDA49B18925DA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <f2b1fddd-b867-4eb9-bc41-add80cce54f4@dronecode.org.uk>
 <PA2PR83MB0684F9E66CCC064AF949112892602@PA2PR83MB0684.EURPRD83.prod.outlook.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
In-Reply-To: <PA2PR83MB0684F9E66CCC064AF949112892602@PA2PR83MB0684.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 27/10/2026 08:45, Radek Barton wrote:
> Hello.
> 
> The code was produced as Microsoft's contribution to Linaro initiatives and, AFAIK, it was public-domained by sending them to the mailing list(s).

I'm not sure how Linaro are involved?

I don't think the mere act of sending them to the mailing list waives 
your IP rights, but if you're stating that was the intent, then thank you.

> Please let me know if you need any other form of confirmation that this code is free to be used or re-used.

I hope this is good enough. Thanks again!

> Radek
> ________________________________
> From: Jon Turney <jon.turney@dronecode.org.uk>
> Sent: Saturday, October 17, 2026 3:35 PM
> Cc: cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>; Radek Barton <radek.barton@microsoft.com>; Evgeny Karpov <evgeny@kmaps.co>
> Subject: [EXTERNAL] Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
> 
> On 21/07/2025 16:53, Radek Barton via Cygwin-patches wrote:
>> Hello.
> 
> Sorry to re-open this long-dormant discussion, but since we've actually
> reached the point where we might soon be able to start distributing
> binaries derived from this code, I think clarification is necessary.
> 
>> JFYI, my original thought was that the Signed-off-by header is serving for some sort of automation that will let maintainers create commit with that person as a committer. Other than that, I am not aware of the cases where it could be handy to have different person being a committer and different person being the one who is granting the authorship rights.
> 
> OK, that's fine.  It's on us to explain what we expect it to mean, and
> we haven't done that.
> 
> What we do need from both you, and Evgeny Karpov, is clear statement that:
> 
> 1. To the extent that it is protectable, this (and all your other) patch
> submissions for Cygwin are licenced under the 2-clause BSD license.
> 
> 2. If this material was produced under a "work-for-hire" contract, your
> employer has authorized that licencing.
> 
> 
> Once again, I apologize for my extremely delayed response. I hope it is
> straightforward for you to provide those assurances.
> 
