Return-Path: <Stromeko@nexgo.de>
Received: from vsmx009.vodafonemail.xion.oxcs.net
 (vsmx009.vodafonemail.xion.oxcs.net [153.92.174.87])
 by sourceware.org (Postfix) with ESMTPS id 4F57D3858021
 for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2020 18:38:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4F57D3858021
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Stromeko@nexgo.de
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])
 by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 426B5159DB45
 for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2020 18:38:08 +0000 (UTC)
Received: from Gertrud (unknown [84.160.202.5])
 by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 17CB6159D630
 for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2020 18:38:05 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Speed up mkimport
References: <20201126095620.38808-1-mark@maxrnd.com>
 <87wny76eur.fsf@Rainer.invalid>
 <ee4d7296-e9b3-13c8-cc15-f2e393b42e6f@maxrnd.com>
Date: Fri, 27 Nov 2020 19:37:59 +0100
In-Reply-To: <ee4d7296-e9b3-13c8-cc15-f2e393b42e6f@maxrnd.com> (Mark Geisert's
 message of "Fri, 27 Nov 2020 01:56:02 -0800")
Message-ID: <87360ubq7s.fsf@Rainer.invalid>
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
X-List-Received-Date: Fri, 27 Nov 2020 18:38:11 -0000

Mark Geisert writes:
> Still faster than two system commands :-).  But thanks for the
> comment;

It still seems you are barking up the wrong tree.

> I thought I was merely grouping args, to get around Perl's
> greedy arg list building for the system command.

Wot?  It just takes a list which you can build any which way you desire.
The other option is to give it the full command line in a string, which
does work for this script (but not on Windows).  If it finds shell
metacharacters in the arguments it'll run a shell, otherwise the forked
perl just does an execve.

If it's really the forking that is causing the slowdown, why not do
either of those things:

a) Generate a complete shell script and fork once to run that.

b) Open up two pipes to an "xargs -P $ncpu/2 L 1 =E2=80=A6" and feed in the=
 file
names.

Getting the error codes back to the script and handling the error is
left as an exercise for the reader.


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Q+, Q and microQ:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
