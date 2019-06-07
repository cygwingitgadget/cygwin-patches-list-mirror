Return-Path: <cygwin-patches-return-9446-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26069 invoked by alias); 7 Jun 2019 20:51:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26060 invoked by uid 89); 7 Jun 2019 20:51:34 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_20,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Languages-Length:733, H*f:sk:826b6cd, H*f:sk:dac7473, H*f:sk:874l51p
X-HELO: mx009.vodafonemail.xion.oxcs.net
Received: from mx009.vodafonemail.xion.oxcs.net (HELO mx009.vodafonemail.xion.oxcs.net) (153.92.174.39) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 07 Jun 2019 20:51:32 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 45D8ED9AF5E	for <cygwin-patches@cygwin.com>; Fri,  7 Jun 2019 20:51:30 +0000 (UTC)
Received: from Gertrud (unknown [87.185.221.231])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 1F034199C2C	for <cygwin-patches@cygwin.com>; Fri,  7 Jun 2019 20:51:28 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH draft 0/6] Remove the fhandler_base_overlapped class
References: <20190526151019.2187-1-kbrown@cornell.edu>	<826b6cd3-2fbc-0d8c-b665-2c9a797a18f3@cornell.edu>	<20190603163519.GJ3437@calimero.vinschen.de>	<dac74739-7b66-56cb-ca8a-acbca7877eba@cornell.edu>	<874l51p7rt.fsf@Rainer.invalid>
Date: Fri, 07 Jun 2019 20:51:00 -0000
In-Reply-To: <874l51p7rt.fsf@Rainer.invalid> (Achim Gratz's message of "Fri,	07 Jun 2019 20:31:02 +0200")
Message-ID: <87sgslnmpf.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00153.txt.bz2

Achim Gratz writes:
> Anything triggering a race or deadlock will depend on so many other
> things that it really is no surprise to see seemingly unrelated changes
> making the bug appear or disappear.  There are certainly races left in
> Cygwin, I see them from time to time in various Perl modules, just never
> reproducible enough to give anyone an idea of where to look.

Ob-T-Shirt:
https://vangogh.teespring.com/v3/image/xkM52lFd03VvHZMhNE9BwUpryXE/480/560.jpg

:-)


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
