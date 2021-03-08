Return-Path: <Stromeko@nexgo.de>
Received: from smtpout2.vodafonemail.de (smtpout2.vodafonemail.de
 [145.253.239.133])
 by sourceware.org (Postfix) with ESMTPS id EE41A3861024
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 19:09:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EE41A3861024
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=nexgo.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Stromeko@nexgo.de
Received: from smtp.vodafone.de (smtpa07.fra-mediabeam.com [10.2.0.37])
 by smtpout2.vodafonemail.de (Postfix) with ESMTP id 8425C12165E
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 20:09:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nexgo.de;
 s=vfde-smtpout-mb-15sep; t=1615230550;
 bh=E804d9q+ybw7nXihq7FEgrQbqdLa+61axpNRO/SRAVA=;
 h=From:To:Subject:References:Date:In-Reply-To;
 b=Vl7VQGVT8N+J1GTi6c9Bz9lpRthEzUx7dn3dVMj6OkrNN83d88IJcY37zE52dPVrX
 jx56nTvBOCNskrTA/eAx0mgqNcsuKih8aM1jYfvhD/pByXDMN4C2NCelarEoTP0g7J
 IFrflSY44IVPis2OzbKXD7a2FuYTrw0dwSqiLtr4=
Received: from Gertrud (p54a0ca05.dip0.t-ipconnect.de [84.160.202.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp.vodafone.de (Postfix) with ESMTPSA id 14276140181
 for <cygwin-patches@cygwin.com>; Mon,  8 Mar 2021 19:09:10 +0000 (UTC)
From: Achim Gratz <Stromeko@nexgo.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/dll.xml: update MinGW/.org to MinGW-w64/.org
References: <20210307163155.63871-1-Brian.Inglis@SystematicSW.ab.ca>
 <aada0b19-26ea-9db0-85f4-8f959441e05a@dronecode.org.uk>
 <38792da7-75f7-231d-0de2-d483b927820a@SystematicSw.ab.ca>
 <YEX5FO0ISV06h9QY@calimero.vinschen.de>
 <b62c52a0-fee4-4cc4-bb57-e16169239d9a@SystematicSw.ab.ca>
 <87pn098s1j.fsf@Rainer.invalid>
 <70c973ec-f8c7-f5cc-1d38-f0306b8521c2@SystematicSw.ab.ca>
Date: Mon, 08 Mar 2021 20:09:08 +0100
In-Reply-To: <70c973ec-f8c7-f5cc-1d38-f0306b8521c2@SystematicSw.ab.ca> (Brian
 Inglis's message of "Mon, 8 Mar 2021 11:19:30 -0700")
Message-ID: <87lfax8nu3.fsf@Rainer.invalid>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 742
X-purgate-ID: 155817::1615230550-00000655-58DA132B/0/0
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
X-List-Received-Date: Mon, 08 Mar 2021 19:09:14 -0000

Brian Inglis writes:
> It's normally a merge conflict which will not be satisfied by regular
> commands to restore the working files to upstream.

So you're pulling on an unclean work tree?  That's a no-no, either keep
your changes on a separate branch (that you can rebase or merge later)
or stash them away for the pull.

As Corinna said, if you're prepared to lose any local changes then

git reset --hard

will do that.  But you should be sure you really didn't want any of your
unfinished business around any more.


Regards,
Achim.
-- 
+<[Q+ Matrix-12 WAVE#46+305 Neuron microQkb Andromeda XTk Blofeld]>+

Factory and User Sound Singles for Waldorf Blofeld:
http://Synth.Stromeko.net/Downloads.html#WaldorfSounds
