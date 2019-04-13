Return-Path: <cygwin-patches-return-9335-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 96198 invoked by alias); 13 Apr 2019 07:38:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 96186 invoked by uid 89); 13 Apr 2019 07:38:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-3.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=strange, HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 13 Apr 2019 07:38:28 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id C1CB0F34F25	for <cygwin-patches@cygwin.com>; Sat, 13 Apr 2019 07:38:26 +0000 (UTC)
Received: from Gertrud (unknown [87.185.221.231])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 969E119A8A4	for <cygwin-patches@cygwin.com>; Sat, 13 Apr 2019 07:38:24 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [rebase PATCH] Introduce --no-rebase flag
References: <990610f4-8ba8-92a1-0ece-5b22c275945a@ssi-schaefer.com>
Date: Sat, 13 Apr 2019 07:38:00 -0000
In-Reply-To: <990610f4-8ba8-92a1-0ece-5b22c275945a@ssi-schaefer.com> (Michael	Haubenwallner's message of "Fri, 12 Apr 2019 15:52:19 +0200")
Message-ID: <87bm1axsls.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00042.txt.bz2

Michael Haubenwallner writes:
> The --no-rebase flag is to update the database for new files, without
> performing a rebase.  The file names provided should have been rebased
> using the --oblivious flag just before.

That name is somewhat strange, how about "--enlist"?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
