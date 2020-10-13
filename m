Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id B283638618EB
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 15:31:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B283638618EB
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M5xDJ-1kZFDv0xHH-007Rp3 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 17:31:36 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id C7524A80637; Tue, 13 Oct 2020 17:31:35 +0200 (CEST)
Date: Tue, 13 Oct 2020 17:31:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 5/6] Cygwin: AF_UNIX: listen_pipe: check for
 STATUS_SUCCESS
Message-ID: <20201013153135.GT26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201004164948.48649-1-kbrown@cornell.edu>
 <20201004164948.48649-6-kbrown@cornell.edu>
 <20201013112829.GH26704@calimero.vinschen.de>
 <2a83e5b7-8dfb-5138-f8ef-99c62e7403ca@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a83e5b7-8dfb-5138-f8ef-99c62e7403ca@cornell.edu>
X-Provags-ID: V03:K1:ukP7MWgWS/t3+zocZGt6Hz714EX4NYyygE1pflQgg39SwkFXvaK
 sEVGIsB6pKRib6uR6VW+H2M59jhyMbb/QAKT3jJhG+P9+RGzQHAZ4Bcg8UNUOEtGUH96z+2
 M3sdE8fIfSFIM+MCDx0q4FWowEMXZ2AcyzJ77MuvwXnbFyw8aHk1Z3NpwUI9Af9K6bNuYh9
 FFTEGJqHYPyOKH7/0tZ2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QNwW5V6dYjw=:60Sl0dsJm8zr7FiIPLsAU7
 8H+DAjNwkpZ4j0xac/q0g71XZ8nDl2NfDW4DE8RSvWwQdNKjc9JMLyMbcr1dm31x80n4ITUbB
 6nBTLMxNFdmVxinrbthSjP8wC4GnjIyVrZQzJblYFHG3OMqfryRVnVmGkwNa02eYHLv6MGyYP
 0fvu8mYsv04p3bMTu/1+7xO3/UhO5zXzfesEsBp+K4BpE12TLFeJ0EvRFcePuvSsqJXedqGAt
 J6c9cdyg4nvqGHHlrSen7BhA2FYZYzZODy8BZJfgzS7Iq9B7DRmm86/Qt9s5ytR+f9xI2MyxI
 KGDTkl8KOPMkZXMHms7lQX+f0eJIZvJpdmdE373SCYAfoiMkvnYxwkclqxabeFoUhwQyuyT1X
 uU6Q0wYerMRdh/FhsZz6Dyooe5P5QQfGkfHU3JJynkCwe2oHe7/p5bgQaQSEAREFQHoSxU0fo
 RnIUYNVESXrISt6NGtGj5MQzWhuPSY7BdIsABVBp0365u7mUwo17lNzzzArk2GFiFfSMaxZdZ
 La2/HLj3B+dKFuyElyWWkVX/j/ihB1SvcEmBivMO1smRUGMcWb3MStO4yZzHu0oGgNAT0qsHn
 oy5SCUnqEHXDS6PqXwa5DVSKR6n1Nyo7zgCvF/NrFEE3smUaECnHXCmUyFA7MB725TP5E8uNR
 cHZ6trzjrNK7R7TSvgIRSsdIUxgy9IWMGOy/6V0Z27umJ1Ezazj8/H74j5Hkm+WZ8oYmtLB1R
 s+FLDT7Pxs8Qr4OizW+OeKSaVoqHkfJEBNyIjfW+/ENVB/9jIbzvFeRdH9qfY5IZHj996Kv4Q
 T25byNIjP1bDWFVQqpLHI6yfHHVHwZFqAq7qjwWHWiHqMqUdasUDYANBpb7ee3AaLWxOFbIbI
 jBkPgo3p859vYESUJkWk5L2ciktmkGZJjCOtsgW1ulY4nRgQuVeExLXTXxNLvN
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 13 Oct 2020 15:31:39 -0000

On Oct 13 13:18, Ken Brown via Cygwin-patches wrote:
> On 10/13/2020 7:28 AM, Corinna Vinschen wrote:
> > On Oct  4 12:49, Ken Brown via Cygwin-patches wrote:
> >> A successful connection can be indicated by STATUS_SUCCESS or
> >> STATUS_PIPE_CONNECTED.
> > 
> > THanks for catching but... huh?  How does Windows generate two different
> > status codes for the same result from the same function?
> 
> I think (but I'd have to recheck) that if the pipe is already connected when 
> NtFsControlFile is called, then the latter returns STATUS_PIPE_CONNECTED.  But 
> if you first get STATUS_PENDING and then set status = io.Status after 
> completion, then the result is STATUS_SUCCESS.

Ah, ok.  I guess I just missed this scenario for some reason.


Thanks,
Corinna
