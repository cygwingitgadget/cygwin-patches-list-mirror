Return-Path: <cygwin-patches-return-8716-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75703 invoked by alias); 17 Mar 2017 19:27:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75685 invoked by uid 89); 17 Mar 2017 19:27:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_JMF_BL,SPF_PASS autolearn=no version=3.3.2 spammy=midi, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, Hx-spam-relays-external:ESMTPA
X-HELO: vsmx010.vodafonemail.xion.oxcs.net
Received: from vsmx010.vodafonemail.xion.oxcs.net (HELO vsmx010.vodafonemail.xion.oxcs.net) (153.92.174.88) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Mar 2017 19:27:49 +0000
Received: from vsmx002.vodafonemail.xion.oxcs.net (unknown [192.168.75.192])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTP id 4A018803C4	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2017 19:27:48 +0000 (UTC)
Received: from Gertrud (unknown [91.47.53.218])	by mta-6-out.mta.xion.oxcs.net (Postfix) with ESMTPA id C5ACB3C0268	for <cygwin-patches@cygwin.com>; Fri, 17 Mar 2017 19:27:46 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] [base-files] Don't clobber prompt set in /etc/profile.d
References: <20170317174409.8271-1-daniel.santos@pobox.com>
Date: Fri, 17 Mar 2017 19:27:00 -0000
In-Reply-To: <20170317174409.8271-1-daniel.santos@pobox.com> (Daniel Santos's	message of "Fri, 17 Mar 2017 12:44:09 -0500")
Message-ID: <87zigjvh3h.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-VADE-STATUS: LEGIT
X-VADE-SCORE: 0
X-VADE-REASON: gggruggvucftvghtrhhoucdtuddrfeelhedriedvgdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvegfuffvqffogfftpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheptegthhhimhcuifhrrghtiicuoefuthhrohhmvghkohesnhgvgihgohdruggvqeenucffohhmrghinhepshhtrhhomhgvkhhordhnvghtnecukfhppeeluddrgeejrdehfedrvddukeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepifgvrhhtrhhuugdpihhnvghtpeeluddrgeejrdehfedrvddukedpmhgrihhlfhhrohhmpefuthhrohhmvghkohesnhgvgihgohdruggvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-SW-Source: 2017-q1/txt/msg00057.txt.bz2

Daniel Santos writes:
> When I build my own machine, I prefer to set my own default prompt in
> /etc/profile.d.  This makes it easier on me, but still allows other
> users to set whatever prompt they please.  This line in bash.bashrc
> incorrectly clobbers whatever prompt is set in /etc/profile.d.

Wrong list.  Also, you shouldn't set any prompt in profile.d.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Waldorf MIDI Implementation & additional documentation:
http://Synth.Stromeko.net/Downloads.html#WaldorfDocs
