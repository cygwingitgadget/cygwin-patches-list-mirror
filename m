Return-Path: <cygwin-patches-return-9262-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120909 invoked by alias); 28 Mar 2019 17:50:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120893 invoked by uid 89); 28 Mar 2019 17:50:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=HX-Spam-Relays-External:ESMTPA
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Mar 2019 17:50:44 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 861E6C03D7	for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 17:50:42 +0000 (UTC)
Received: from Rainer.invalid (unknown [87.185.211.111])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 580B8300667	for <cygwin-patches@cygwin.com>; Thu, 28 Mar 2019 17:50:40 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com>	<20190326182538.GA4096@calimero.vinschen.de>	<20190326182824.GB4096@calimero.vinschen.de>	<c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com>	<20190327091640.GE4096@calimero.vinschen.de>	<b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com>	<20190328091507.GM4096@calimero.vinschen.de>	<89dc8dca-c97b-ef79-6b90-bebb1b73c388@ssi-schaefer.com>
Date: Thu, 28 Mar 2019 17:50:00 -0000
In-Reply-To: <89dc8dca-c97b-ef79-6b90-bebb1b73c388@ssi-schaefer.com> (Michael	Haubenwallner's message of "Thu, 28 Mar 2019 16:02:53 +0100")
Message-ID: <87o95u3n2p.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q1/txt/msg00072.txt.bz2

Michael Haubenwallner writes:
> It will not help for conflicts between dlls within a single package while this
> package is built.  I'm thinking of python modules built within the python package
> itself, where the just built modules are used within the very build process.  Not
> sure if packages using local modules during build also do use fork then, though.

It does help, that's the whole point.  But you will have to rebase all
the in-processing DLL together, as the database will only have
information on the installed DLL.  So if you build in stages, you'll
need to do something like incremental autorebase does and collect all
DLL into some file that you can then feed to

rebase -sOT dlls_to_rebase

That is slightly less convenient than using the database in persistent
mode, but it is much less of a headache when you want to throw things
away and start over since you don't need to worry about cruft in the
database file.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Wavetables for the Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#BlofeldUserWavetables
