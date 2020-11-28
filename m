Return-Path: <Stromeko@nexgo.de>
Received: from vsmx012.vodafonemail.xion.oxcs.net
 (vsmx012.vodafonemail.xion.oxcs.net [153.92.174.90])
 by sourceware.org (Postfix) with ESMTPS id 6CFBA385040B
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 16:57:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 6CFBA385040B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Stromeko@nexgo.de
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
 by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 0CA22F34D61
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 16:57:18 +0000 (UTC)
Received: from Gertrud (unknown [84.160.202.5])
 by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id DAA2C19A417
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 16:57:15 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Speed up mkimport
References: <20201126095620.38808-1-mark@maxrnd.com>
 <87wny76eur.fsf@Rainer.invalid>
 <ee4d7296-e9b3-13c8-cc15-f2e393b42e6f@maxrnd.com>
 <87360ubq7s.fsf@Rainer.invalid>
Date: Sat, 28 Nov 2020 17:57:12 +0100
In-Reply-To: <87360ubq7s.fsf@Rainer.invalid> (Achim Gratz's message of "Fri,
 27 Nov 2020 19:37:59 +0100")
Message-ID: <87a6v1fmhj.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-VADE-STATUS: LEGIT
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Sat, 28 Nov 2020 16:57:21 -0000

Achim Gratz writes:
> b) Open up two pipes to an "xargs -P $ncpu/2 L 1 =E2=80=A6" and feed in t=
he file
> names.

That actually works, but the speedup is quite modest on my system
(4C/8T) even though I've allowed it to use unlimited resources.  So it
basically forks slower than the runtime for each of the invocations is.
Some more speedup can be had if the assembler is run on actual files in
the same way, but the best I've come up with goes from 93s to 47s and
runs at 150% CPU (up from 85%).  Most of that time is spent in system,
so forking and I/O.


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
