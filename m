Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
	by sourceware.org (Postfix) with ESMTPS id B140D3858C50
	for <cygwin-patches@cygwin.com>; Wed, 29 Mar 2023 08:36:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B140D3858C50
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8XHV-1qTIvh0iY5-014W2P; Wed, 29 Mar 2023 10:36:24 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 94219A80C13; Wed, 29 Mar 2023 10:36:23 +0200 (CEST)
Date: Wed, 29 Mar 2023 10:36:23 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 1/3] Allow deriving the current user's home directory
 via the HOME variable
Message-ID: <ZCP4h7fDkj+60DEh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Jon Turney <jon.turney@dronecode.org.uk>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	cygwin-patches@cygwin.com
References: <cover.1663761086.git.johannes.schindelin@gmx.de>
 <cover.1679991274.git.johannes.schindelin@gmx.de>
 <7a074997ea64d9f9d6dab766d1c49627e762cbed.1679991274.git.johannes.schindelin@gmx.de>
 <ZCLC1kvfb5Gdk+Cd@calimero.vinschen.de>
 <2ef9176e-9282-d0d1-b047-d8555d4434da@dronecode.org.uk>
 <ZCLsFCguNjGi5Ga9@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZCLsFCguNjGi5Ga9@calimero.vinschen.de>
X-Provags-ID: V03:K1:vWCg0MgfTxvy6P4X/u8OeE1GvuGaJ/7zg4Y/PTnVqEw14IBQu3o
 0AEPSFogoSe8a3t1ob+8YoAyausVkrosvz28FrMU8G3SLGdYXG8lZzOJCO9w5G1l8s8c16a
 dSWkULsRO6W7x8zDiecSxcRx107t+b0zlcxIN4bax7ILJib3ICUCWaXkvPVgX7g2gtzORIq
 AF9F6zRd83wD5PO4NU8VA==
UI-OutboundReport: notjunk:1;M01:P0:HVoHdV8NC14=;keqrMZXhSe6/opRsd52tB3oSbRg
 cuxPdJqpGJamfdQ4s6qP/XNyu6bHrZ4YciBq7IotjM4xap2P++pkIYhKIyx86NvBTQtz/kfZr
 N8N450NIdteaK0bLq/uJZF7uN0RAHTt8jKZrKnhfp0E1Fd4HymsLG5u/6+zQeRZGbrsKDET6n
 rXApB91Jco6q56QKP6w6hC8MaNO1WptwSnOZy/+QoENUtdjY0x8nOio7+9RYyvCyIIF+TuQCl
 LkX2cC7n4wv1gsixIhWXtmkggvVSFA5eViDVCQd5ETJ83frq9hm1YTwBz/OAAKvLos7bfQ2s4
 dg3cN5X9SK/9qQ/F2WKayVeF3KoKZIge97ezWfjVVQWL9cQGSQUU3z3hHbDFKSLqlGEpV8oNo
 jDDfbjnMcfVC09f9iK43RSbq5JDDjwHeGnOapoAso0ZgaOt2AuA3YhKuYe+XrWBO6vuPC8cS7
 RfrAiN0eBZrvA94RTgD5FIN7MLeFcnOlkL950H84DetWitlhvzOmK5yjP7Vx0bAEf+lLSdYBP
 G2k/TwxiSubS6sGIYQJe+UY1Fejf7YZ4dG086gl1ccKzG4VIxkCB7V8ZySdH3QY5GE5pvH5ru
 KFnSkjmE77UuK31IKjKQQ/zPLcnudzK0qQSMPRrc8U/TX4s/p3bQJBkJK1SZox3W1F/hAkRSm
 Q28OSe2lPtyfFMPRAkQ3o0q4jP77N40wQvHqj6g5pQ==
X-Spam-Status: No, score=-97.7 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_NONE,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mar 28 15:31, Corinna Vinschen wrote:
> On Mar 28 13:34, Jon Turney wrote:
> > On 28/03/2023 11:35, Corinna Vinschen wrote:
> > > Apart from the doc change, the patch is ok now.
> > 
> > The preceding text says "Four schema are predefined, two schemata are
> > variable", then we add "env" to both lists? That doesn't make much sense to
> > me.  Surely it's just a "predefined schema"?  In any case that text should
> > be updated.
> 
> Ouch, yeah, I missed that.  Thanks for catching!

I accidentally already pushed this patch, so I took it on me to fix up
the documentation.


Corinna
