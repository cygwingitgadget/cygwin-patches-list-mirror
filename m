Return-Path: <cygwin-patches-return-9405-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 38600 invoked by alias); 6 May 2019 16:31:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 38585 invoked by uid 89); 6 May 2019 16:31:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=2.6 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPAM_URI,SPF_PASS autolearn=no version=3.3.1 spammy=diy, Theres, DIY, There's
X-HELO: vsmx011.vodafonemail.xion.oxcs.net
Received: from vsmx011.vodafonemail.xion.oxcs.net (HELO vsmx011.vodafonemail.xion.oxcs.net) (153.92.174.89) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 May 2019 16:31:17 +0000
Received: from vsmx003.vodafonemail.xion.oxcs.net (unknown [192.168.75.197])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id 250C13E122C	for <cygwin-patches@cygwin.com>; Mon,  6 May 2019 16:31:15 +0000 (UTC)
Received: from Gertrud (unknown [87.185.221.231])	by mta-7-out.mta.xion.oxcs.net (Postfix) with ESMTPA id E8CCB300968	for <cygwin-patches@cygwin.com>; Mon,  6 May 2019 16:31:12 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [rebase PATCH] Introduce --merge-files (-M) flag
References: <20190412180302.GF4248@calimero.vinschen.de>	<319c9949-6e00-2c18-f1d0-a88a7f02fdab@ssi-schaefer.com>	<ae7bce9f-b1d6-440b-f6d6-fdca1040d56f@SystematicSw.ab.ca>	<6d8331f7-d3f5-53e6-5e55-863f8eb01693@ssi-schaefer.com>
Date: Mon, 06 May 2019 16:31:00 -0000
In-Reply-To: <6d8331f7-d3f5-53e6-5e55-863f8eb01693@ssi-schaefer.com> (Michael	Haubenwallner's message of "Mon, 6 May 2019 10:31:32 +0200")
Message-ID: <87pnovwnn6.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q2/txt/msg00112.txt.bz2

Michael Haubenwallner writes:
>> Your earlier suggestion of --record, the verb used in the comment quoted above
>> --update, or CV's suggestion --merge-files would make sense and be more
>> descriptive.

My reason for using a stronger word (even though enlist apparently calls
up the wron connotaions) is that once you've registered (enlisted,
enrolled) a library into the database, it'll stay there for all database
operations as long the file still exists.  There's an implicit contract
that the "registration" stays valid for the combined lifetime of the
file and the database.  Since you cannot (yet) choose a different
database, that requires a bit of coordination.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

DIY Stuff:
http://Synth.Stromeko.net/DIY.html
