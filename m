Return-Path: <Stromeko@nexgo.de>
Received: from vsmx012.vodafonemail.xion.oxcs.net
 (vsmx012.vodafonemail.xion.oxcs.net [153.92.174.90])
 by sourceware.org (Postfix) with ESMTPS id 11D373858004
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 19:31:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 11D373858004
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Stromeko@nexgo.de
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])
 by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id CC1FCF34F19
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 19:31:26 +0000 (UTC)
Received: from Gertrud (unknown [84.160.202.5])
 by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id A4DC519A968
 for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2020 19:31:24 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Speed up mkimport
In-Reply-To: <87a6v1fmhj.fsf@Rainer.invalid> (Achim Gratz's message of "Sat,
 28 Nov 2020 17:57:12 +0100")
References: <20201126095620.38808-1-mark@maxrnd.com>
 <87wny76eur.fsf@Rainer.invalid>
 <ee4d7296-e9b3-13c8-cc15-f2e393b42e6f@maxrnd.com>
 <87360ubq7s.fsf@Rainer.invalid> <87a6v1fmhj.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date: Sat, 28 Nov 2020 20:31:24 +0100
Message-ID: <874kl9ffcj.fsf@Rainer.invalid>
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
X-List-Received-Date: Sat, 28 Nov 2020 19:31:30 -0000

Achim Gratz writes:
> That actually works, but the speedup is quite modest on my system
> (4C/8T) even though I've allowed it to use unlimited resources.  So it
> basically forks slower than the runtime for each of the invocations is.
> Some more speedup can be had if the assembler is run on actual files in
> the same way, but the best I've come up with goes from 93s to 47s and
> runs at 150% CPU (up from 85%).  Most of that time is spent in system,
> so forking and I/O.

Not that I really know what I'm doing, but creating a single .s file and
running as just once gets mkimport down to 21s / 110%.  Now the
resulting library doesn't actually link, because somehow the information
ends up in the wrong place=E2=80=A6


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Terratec KOMPLEXER:
http://Synth.Stromeko.net/Downloads.html#KomplexerWaves
