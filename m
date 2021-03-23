Return-Path: <Stromeko@nexgo.de>
Received: from smtpout2.vodafonemail.de (smtpout2.vodafonemail.de
 [145.253.239.133])
 by sourceware.org (Postfix) with ESMTPS id 8700C385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 15:21:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8700C385701F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Stromeko@nexgo.de
Received: from smtp.vodafone.de (smtpa08.fra-mediabeam.com [10.2.0.39])
 by smtpout2.vodafonemail.de (Postfix) with ESMTP id 3D49C1213AE
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 16:21:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
 s=vfde-smtpout-mb-15sep; t=1616512901;
 bh=a1FYOm3nci/nr0/iZg14uxmqoHPyQSUXSS/DcJxlj+I=;
 h=From:To:Subject:References:Date:In-Reply-To;
 b=BfeOjT4SBYZqJArrkVBdKc7FBkqxDuPYgTYol5Mlkvb0YvIepbs/i4XM18icH5M7N
 dI28SAah+3cndmdM2dKFS6A+ZagCw0NCr4TdfdSnek5uA9jihQ3uLM5hyaaSny8Ez0
 4BVaFhfuIMs7AmQbDhEG8Lg8cinitNmF0JCpboSM=
Received: from Otto (p57b9d8ab.dip0.t-ipconnect.de [87.185.216.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 09850141427
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 15:21:39 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
 <YFncTItWHhMlNH5Y@calimero.vinschen.de>
 <20210323213212.d2c5a9e7db7a508260693998@nifty.ne.jp>
 <YFnit7OtFJeflMQT@calimero.vinschen.de>
 <ee1366d1-d7bb-0bb3-b9e1-7715eb476985@dronecode.org.uk>
Date: Tue, 23 Mar 2021 16:21:34 +0100
In-Reply-To: <ee1366d1-d7bb-0bb3-b9e1-7715eb476985@dronecode.org.uk> (Jon
 Turney's message of "Tue, 23 Mar 2021 13:09:44 +0000")
Message-ID: <87a6qtx5dt.fsf@Otto.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 750
X-purgate-ID: 155817::1616512899-00005C41-D1DF08EA/0/0
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 23 Mar 2021 15:21:48 -0000

Jon Turney writes:
> 'run' is used by the start menu item which starts the X server.
>
> If that doesn't use it, a visible console window is created for the
> bash process it starts (which is the parent of the X server process
> and lives for it's lifetime).
>
> (As a separate issue, I'm not sure all the complex gymnastics run does
> to creste the window invisibly are doing anything useful, since we
> seem to briefly show the window and then hide it)

It may be time to finally retire run and finish the work on run2=E2=80=A6


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptations for KORG EX-800 and Poly-800MkII V0.9:
http://Synth.Stromeko.net/Downloads.html#KorgSDada
