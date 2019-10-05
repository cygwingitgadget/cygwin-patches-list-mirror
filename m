Return-Path: <cygwin-patches-return-9734-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24227 invoked by alias); 5 Oct 2019 06:31:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7869 invoked by uid 89); 5 Oct 2019 06:30:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-2.5 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches, HX-Languages-Length:626, H*f:sk:5b5874a, H*i:sk:5b5874a
X-HELO: vsmx009.vodafonemail.xion.oxcs.net
Received: from vsmx009.vodafonemail.xion.oxcs.net (HELO vsmx009.vodafonemail.xion.oxcs.net) (153.92.174.87) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 05 Oct 2019 06:30:41 +0000
Received: from vsmx001.vodafonemail.xion.oxcs.net (unknown [192.168.75.191])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTP id E2F7D15A358A	for <cygwin-patches@cygwin.com>; Sat,  5 Oct 2019 06:30:38 +0000 (UTC)
Received: from Otto (unknown [84.160.192.162])	by mta-5-out.mta.xion.oxcs.net (Postfix) with ESMTPA id BB1D715A3589	for <cygwin-patches@cygwin.com>; Sat,  5 Oct 2019 06:30:36 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): fix issues, add fields, flags
References: <20191004104457.33757-1-Brian.Inglis@SystematicSW.ab.ca>	<5b5874ac-4d98-1415-90fe-66e5fb79b398@SystematicSw.ab.ca>
Date: Sat, 05 Oct 2019 06:31:00 -0000
In-Reply-To: <5b5874ac-4d98-1415-90fe-66e5fb79b398@SystematicSw.ab.ca> (Brian	Inglis's message of "Fri, 4 Oct 2019 14:39:54 -0600")
Message-ID: <875zl3ln5l.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SW-Source: 2019-q4/txt/msg00005.txt.bz2

Brian Inglis writes:
> For informal comparison, attached are Cygwin, WSL, and test release cpuinfo
> output, with diffs against the test release output, and the Windows registry
> CentralProcessor dump (be careful not to double click on Windows
> systems!)

The easiest way to prevent that problem would have been to give that
file a .txt extension, no?


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf rackAttack V1.04R1:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
