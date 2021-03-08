Return-Path: <Stromeko@nexgo.de>
Received: from smtpout2.vodafonemail.de (smtpout2.vodafonemail.de
 [145.253.239.133])
 by sourceware.org (Postfix) with ESMTPS id 2F9AB3861027
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 20:53:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2F9AB3861027
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Stromeko@nexgo.de
Received: from smtp.vodafone.de (smtpa04.fra-mediabeam.com [10.2.0.34])
 by smtpout2.vodafonemail.de (Postfix) with ESMTP id 14D4F1225FB
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 21:53:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
 s=vfde-smtpout-mb-15sep; t=1615236780;
 bh=daBHqph+GJZQT6KO4+DS1n+aQbP78n4qUZmd00ycyQQ=;
 h=From:To:Subject:References:Date:In-Reply-To;
 b=aKg1jJAerRwQ3HfC5jOqiERDQ3KO9xz5aWJcYtXT69B/5//A6JGnmzcclanII/Qhx
 6vttfE9C6H/e0rABTLB1RHoEeJPAEynulhOaqwjmtAcLQcFtLALU5ujuwEbKY+XNl2
 wEHNbPHBIOQoqSgSMLr1rDtuTANtTMnva1U+GQVg=
Received: from Otto (p54a0ca05.dip0.t-ipconnect.de [84.160.202.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 886BF1404E9
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 20:52:59 +0000 (UTC)
From: ASSI <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
 <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
 <YEX5FO0ISV06h9QY@calimero.vinschen.de>
 <b62c52a0-fee4-4cc4-bb57-e16169239d9a@SystematicSw.ab.ca>
 <87pn098s1j.fsf@Rainer.invalid>
 <70c973ec-f8c7-f5cc-1d38-f0306b8521c2@SystematicSw.ab.ca>
 <87lfax8nu3.fsf@Rainer.invalid>
 <b81497ce-72d0-f11e-a381-568aa407b98a@cornell.edu>
Date: Mon, 08 Mar 2021 21:52:56 +0100
In-Reply-To: <b81497ce-72d0-f11e-a381-568aa407b98a@cornell.edu> (Ken Brown via
 Cygwin-patches's message of "Mon, 8 Mar 2021 15:20:39 -0500")
Message-ID: <87mtvd9xlj.fsf@Otto.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 997
X-purgate-ID: 155817::1615236779-000008A0-01A7606B/0/0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_LOW, SPF_HELO_NONE,
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
X-List-Received-Date: Mon, 08 Mar 2021 20:53:03 -0000

Ken Brown via Cygwin-patches writes:
> If the unfinished business consists of local commits that haven't yet
> been applied upstream, then I typically do the following:
>
> git fetch  # Find out if upstream has changed since my last pull.  If so.=
..
> git format-patch -n  # save n local commits
> git reset --hard origin/master
> git am 00*  # reapply my local commits
>
> This assumes I've been too lazy to work on a separate branch, which is
> often the case for small changes.

git branch local # optional
git rebase origin/master
git branch -D local # once you know you don't need it anymore

=E2=80=A6 does more or less the same thing.

I usually skip the safety branch since I can pull it from the reflog if
needed and it's unlikely I'll trigger a GC just that moment.


Regards,
Achim.
--=20
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

SD adaptation for Waldorf microQ V2.22R2:
http://Synth.Stromeko.net/Downloads.html#WaldorfSDada
