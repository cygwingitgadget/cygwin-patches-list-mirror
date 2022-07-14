Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id 2FB8D3858C52
 for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022 14:28:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2FB8D3858C52
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M4aA4-1oDeWc3RRe-001j24 for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022
 16:28:40 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A5454A807E3; Thu, 14 Jul 2022 16:28:39 +0200 (CEST)
Date: Thu, 14 Jul 2022 16:28:39 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH rebase] Add support for Compact OS compression for Cygwin
Message-ID: <YtAoF7HvCTw177IB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <e281c355-1ea1-eefa-12d8-17f7538edb60@t-online.de>
 <Ys/u2QmY8E1s0hZd@calimero.vinschen.de>
 <ae3b7f6f-cb27-3ffa-3b47-300db32ffc25@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae3b7f6f-cb27-3ffa-3b47-300db32ffc25@t-online.de>
X-Provags-ID: V03:K1:FuRABaCewinaBgZ2z4FkaGzsBgy/bTCAF8ZqFldBpXfqJwVoswY
 XfuMkEI9mV0MfoXUFzIsV7MeMzhgIleXhrLbuflvDW1oP/YuXMjZFtd/BlwWGIio3ekPrd3
 PQVWurDUmysX8isA0+3NWh0EkV6iZbz2VYDapZSqbmNBONc02gXWksfSYmmNSxKyAnt5RfT
 idy6aflD7Bm+F8jxDbd0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ktPms9VVuD4=:7Ue8og6AEcup+tefA92P+D
 TYeYHB+kVWxGNc88ICEz0gL4g/j9QBYZSpReymK9n97YZuKuE/p6OU4FyCZB1IRygVwLZSlqx
 ykr1NE20lfzZtu+ptrm2S9fa3FdRJ9W9LJcJRjLPtoe7d8ovRa9hJzb+CnZ9iCQIPvvgysWvk
 NMRY+ZnLD0+PVEgb+Z9Ot/rUWihSbt01Gzzt0uRXBI+2yrkXKUwfQNMjkFSMXMhskcomhqSp7
 xeZFn9qiKEmf8YdVUq11GhsfLjL74BOWMdG0CAqm7/2zTAixc3GFhe6URtUfPmOdjMH9ZbfqD
 whYIx4hZKPjkjDmE7ja0a/GUZISFbunZa3LfGcGtbP7qI3fpLEpz6WDg3mC8PY4bm7/Ww7obi
 p9WDHegcdFfl3tx8c2ww331d1n3vmabTNiXq7C0DH7PwoQ1V1CnvgFtgzpnjJxwuSoYxWQoyd
 pXZRTkVIoLlRU8jmiSvE4X+7kCElaw1CLT4ulpQRdPedoewCU3xPbgrq9u0V1lbku+SV64Xad
 AIkJz8bKG33AG1g6rvVTiWNRnjxJ5KznPs+APM85h76cL6ZK8XAL9TcfqrdeJ/nqmaM3FP7AO
 fgvFpiZVwXZn5glXWGNeZ5OeLIDp12mciY9ry3AlQF+RPSzA33MktAzHaxwayEoQ+fEe/5mnl
 peZGz9Krt4/114KWvN2b5lzl4AWSC42Sdh7EoT+kBNvNvI7NS60XXnSWNiMbSLaZ6JUCvXTwK
 DWh8LXLYIhgnwIS9FA1Kcyw8RIzoRYiyC2DIaMPcAgEmyu1sB4ZzSmyKscY=
X-Spam-Status: No, score=-95.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 14 Jul 2022 14:28:44 -0000

On Jul 14 14:12, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Jul 14 12:02, Christian Franke wrote:
> > > [Sorry if this is the wrong list]
> > Yes, in theorie, but no worries.  However...
> 
> What is the correct list in theory ?-)

https://sourceware.org/cygwin-apps/ as the home of the "Cygwin-Apps"
is a good hint in itself ;)

> > Given compactos stuff is a OS thingy and not actually a Cygwin feature,
> > why do we need an ifdef CYGWIN?
> 
> Mainly because I didn't test on MSYS and other (which ever these are)
> environments. This also requires a recent release of MinGW-w64 headers
> (>=10.0.0) which includes (my) Compact OS patch.

I don't think there's any "other".

> > > +#endif
> > This ifdef still makes sense, of course ...
> 
> Could possibly also be enhanced to __MSYS__ and msys1.dll.

Not sure this makes sense.  Does their installer support CompactOS?
> 
> 
> > ... and on first glance, the
> > remainder of the patch LGTM.
> 
> Thanks. Attached is an alternative patch with most ifdefs removed.

LGTM.  I'm not going to push it, yet, because... do you still want to
add the aforementioned MSYS support?  If not, I'll just go ahead.


Thanks,
Corinna
