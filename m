Return-Path: <cygwin-patches-return-9837-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 84944 invoked by alias); 12 Nov 2019 19:48:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 84900 invoked by uid 89); 12 Nov 2019 19:48:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=2.2 required=5.0 tests=AWL,BAYES_50,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=WAVE, Matrix12, matrix-12, sk:SynthS
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 12 Nov 2019 19:48:14 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id 7D925F35074	for <cygwin-patches@cygwin.com>; Tue, 12 Nov 2019 19:48:08 +0000 (UTC)
Received: from Gertrud (unknown [91.47.60.226])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id 3B44C19A326	for <cygwin-patches@cygwin.com>; Tue, 12 Nov 2019 19:48:05 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: cygrunsrv patch
References: <MN2PR09MB398333C47F420E68A5E95E93A5770@MN2PR09MB3983.namprd09.prod.outlook.com>
Date: Tue, 12 Nov 2019 19:48:00 -0000
In-Reply-To: <MN2PR09MB398333C47F420E68A5E95E93A5770@MN2PR09MB3983.namprd09.prod.outlook.com>	(Anton C. via cygwin-patches Lavrentiev's message of "Tue, 12 Nov 2019	19:41:27 +0000")
Message-ID: <8736esoozx.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q4/txt/msg00108.txt.bz2

Lavrentiev, Anton (NIH/NLM/NCBI) [C] via cygwin-patches writes:
> $ git clone 'https://cygwin.com/git/?p=cygwin-apps/cygrunsrv.git' ./cygrunsrv
> Cloning into './cygrunsrv'...
> fatal: repository 'https://cygwin.com/git/?p=cygwin-apps/cygrunsrv.git/' not found

Try

git://sourceware.org/git/cygwin-apps/cygrunsrv.git

instead?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf microQ V2.22R2:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
