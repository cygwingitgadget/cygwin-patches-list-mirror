Return-Path: <cygwin-patches-return-8722-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108027 invoked by alias); 20 Mar 2017 17:34:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108012 invoked by uid 89); 20 Mar 2017 17:34:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.2 spammy=cygserver, H*r:192.168.75, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: vsmx012.vodafonemail.xion.oxcs.net
Received: from vsmx012.vodafonemail.xion.oxcs.net (HELO vsmx012.vodafonemail.xion.oxcs.net) (153.92.174.90) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Mar 2017 17:34:24 +0000
Received: from vsmx004.vodafonemail.xion.oxcs.net (unknown [192.168.75.198])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTP id A22CE4000BB	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 17:34:22 +0000 (UTC)
Received: from Gertrud (unknown [91.47.53.218])	by mta-8-out.mta.xion.oxcs.net (Postfix) with ESMTPA id D920F380235	for <cygwin-patches@cygwin.com>; Mon, 20 Mar 2017 17:34:20 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Implement getloadavg()
References: <20170317175032.26780-1-jon.turney@dronecode.org.uk>	<20170320103715.GH16777@calimero.vinschen.de>	<0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk>
Date: Mon, 20 Mar 2017 17:34:00 -0000
In-Reply-To: <0a1b00e9-229d-a1b4-9e4a-15cc14601713@dronecode.org.uk> (Jon	Turney's message of "Mon, 20 Mar 2017 15:04:33 +0000")
Message-ID: <87k27jrgx3.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-VADE-STATUS: LEGIT
X-VADE-SCORE: 0
X-VADE-REASON: gggruggvucftvghtrhhoucdtuddrfeelhedrieejgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvegfuffvqffogfftpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheptegthhhimhcuifhrrghtiicuoefuthhrohhmvghkohesnhgvgihgohdruggvqeenucffohhmrghinhepshhtrhhomhgvkhhordhnvghtnecukfhppeeluddrgeejrdehfedrvddukeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepifgvrhhtrhhuugdpihhnvghtpeeluddrgeejrdehfedrvddukedpmhgrihhlfhhrohhmpefuthhrohhmvghkohesnhgvgihgohdruggvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-SW-Source: 2017-q1/txt/msg00063.txt.bz2

Jon Turney writes:
> I don't think that's particularly heavyweight, and I didn't see
> anything to suggest that PDH query handles can be shared between
> processes, but I'll look into it.

So maybe something to chuck to cygserver when it's running?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf Blofeld V1.15B11:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
