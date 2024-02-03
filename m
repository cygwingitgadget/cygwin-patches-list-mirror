Return-Path: <SRS0=wrpf=JM=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id 0ACB83858403
	for <cygwin-patches@cygwin.com>; Sat,  3 Feb 2024 14:24:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0ACB83858403
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0ACB83858403
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706970286; cv=none;
	b=pwmz9S3cQN5NWWDZmcFtv0TOgU3wUs1LlI0ymqmlJl9q6Ro4OtVxjK6smZD98BP4e4FpOFwy6N8ZVSx2qqSlOwSdQnRwN1bdQVc2YiQRci72Rrh07RD7Gm031wZKGLDUweyft8uTsHHVpn2si0wCOk1TgvJlGRxMkkM7fmwMT6E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706970286; c=relaxed/simple;
	bh=Yvp6zcpublytPgai4yCFptkj0jIUDYoaI/Nemt96yC4=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mMo8mlzCPunXIcqZ8jsauQXe9Tq5X4Il0DtvLYRLiBKmeLoOTMY5MQKqQpAZuI28edasjrcBAPVcKF3Ib37Pxp5EQFQFpnvVsqE+JLcFGO1WQEaaO1iYemwTRnYz32Rllbzcep2VuTR6b4SaUzfCHmoWWareWRoghoRULa0mL6Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706970278; x=1707575078; i=johannes.schindelin@gmx.de;
	bh=Yvp6zcpublytPgai4yCFptkj0jIUDYoaI/Nemt96yC4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=HmjWbA8pH1nBV5EyLX9AjCsdijIihPe3mBgwisGhp4LBGQ9GeZkbvnjHRNvztZ7w
	 7WTeHByADteREBe6v0oeWmlKn7ul0Lyb+I0JdylpL7PfOYsjvSQC5sQZ9BdhGiTUZ
	 J9WDV1LW3KYqqw581GE/ynVju5HJMNH3JfNaljbXaIj11kY1iBydP03XZT6F6Ml+V
	 m+zfkhjE5MQcxQw1b2IceXt/+4KxqadLkasp4W3SCNiZNREaLBgnl7ZaEmyeOH5hD
	 y2kTyq1C3hCqz5I2XC4ALo9gabw0JhhfQx0Op0lr8fYgYNRtc1s8euCXhUFV0MHkt
	 uLzTXL1RiteC06gvvA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.32]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfpSb-1qqtem46q9-00gKd5; Sat, 03
 Feb 2024 15:24:38 +0100
Date: Sat, 3 Feb 2024 15:24:36 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix exit code for non-cygwin process.
In-Reply-To: <20240202052923.881-1-takashi.yano@nifty.ne.jp>
Message-ID: <23727ea4-229b-cf13-057d-e9f0e2790b61@gmx.de>
References: <20240202052923.881-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y0ckQUfy2I1kAI6XGYZTHj9VAbzI3VoCaKtFku7NZzJCbA0n4yt
 hIGchWy5VMYki1R7gk5SNXKLYVxU6GxwlpXuy9t1ZWTdqX1myRarCAbJ08l0OeAFxMqbRuw
 m40KPsSkOcjeUeH3NnGF43gwR7ck6rMuIRKBiu2LgEcDdfI0Xa2JuXpSXYG/EjjuFvlSu+5
 ebTbS3IUpktGy4eS+vnYQ==
UI-OutboundReport: notjunk:1;M01:P0:VsS9r02bdpg=;WkXnH4FungiZVLPUR3mQnUqRlv/
 V0rTg6XzrM9I7pi9oaita5tfNAwFDYL9oXoF/TlNgTu5wJsDjgINdgvwevzc+UXSKQVpza2O6
 0mKx3/7ijVYN5ZOybihygFMs0BU5dFDbkXgencQ/miA0vOCcAUHL7pvb1Y/fRcdcWgcX8O1EW
 ZGXGfJGkdlWnOGDuCq/diVpo8gROnU9ZFRs+du0p6csJ2wIpFObOahB2I3QhNJ4qzVjmVUbaM
 AQbhtxYwOn876mCXOeo82/W25P9BdU1GwVy/imiDkUXYm3Q+uSBEKhxkUj4QkphTYHLwSvD/K
 vTM9SEHyauwYVv/Bb6pd06xAKbYPdOxpfAvW7FUDLaCKzP9UvUTBR9o5F1i+jb40r1nHBk4Ni
 sq9okfQgNud+vVFM+WVg/CMF6VNGEzufONbvZOUy9dWjKUE2pU5E75WD287gbXx0WkgmmHYBQ
 c146rJnZw3HGO/AjPC+byNkfg63ue13HBtQEkUPkpztYXZgIrDg9zWK+ZQvyZihZgxe4suTZH
 pDKfsEQuO7zDTKhAVqBcUnA2qmW29oIBulBi8sbEwcf/aFLB3fQwZF0EEHcOlkr3TMsx6ovSU
 Ozk8LIyWc7y0+4s/KjbOSywtkSq0vr2khILn5A4GnXWgm63ZwS2NGxuX+6fi8vkUTcTdx9Qkv
 KZfsLBYrafTcZj/blYiMw1XfNYPt7hRMLDDIViK4YuIvSZZlSZmX2B0OBGHauLwRX6qnnL/bt
 oVCfwpcJYc68Z3CLBoAsyiRknA0fO92VNPnqPjZrIL9eZhIq+7pblRGTq9BdhVoz4OIL92jrl
 N0FVxrIugNZdQtmEA/gFSWpaj54FI2c2VbHrlAxA8CMcQ=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 2 Feb 2024, Takashi Yano wrote:

> If non-cygwin process is executed in console, the exit code is not
> set correctly. This is because the stub process for non-cygwin app
> crashes in fhandler_console::set_disable_master_thread() due to NULL
> pointer dereference. This bug was introduced by the commit:
> 3721a756b0d8 ("Cygwin: console: Make the console accessible from
> other terminals."), that the pointer cons is accessed before fixing
> when it is NULL. This patch fixes the issue.
>
> Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from =
other terminals.")
> Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>

Thank you for fixing this so swiftly. I still wish the logic was
drastically simpler to understand so that even mere humans like myself
would stand a chance to fix such bugs, but I am happy that it is fixed
now.

Ciao,
Johannes
