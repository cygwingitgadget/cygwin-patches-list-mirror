Return-Path: <SRS0=xgHh=BD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:28])
	by sourceware.org (Postfix) with ESMTPS id 396114BAE7C8
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 11:08:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 396114BAE7C8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 396114BAE7C8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:28
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772536086; cv=none;
	b=nO1awpPGwWivbV1pks4qNDAwXxCg8m7vM+asBKabPQrWhi5n7aMZxb6A4/PaIv92FlqRc9EOlYINwqh2EpVCSuV4oGEq4AYfb45FRDZWPpmoC/lXojY6DqUXk4FDG2rCPmY3VHFcEooz2YpMxF05pBK5h8/oB58cke5YIDSqE5E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772536086; c=relaxed/simple;
	bh=K93DA6aAjdn7wJJtmPlirEXVO9fwEn2SS4aJpD9JdyQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=xHFoYQGvsKaKTD5lP2DKNv7zts0PPN3NMQSf3lfi9DldWnYEy+UhmKyJSl3St9P0Ca8pep3aeBCMyeUTX5Dk5uaqDV1PxtL7Cun1JJW1MtY7U55VdIJ/I8AE9In5O0WMp4sjJ0gShB8JsLqM4gcDnfok6iUXAvKJ99VdmVVntRs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 396114BAE7C8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QiE5yR6O
Received: from HP-Z230 by mta-snd-w08.mail.nifty.com with ESMTP
          id <20260303110804221.KHKI.78984.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 3 Mar 2026 20:08:04 +0900
Date: Tue, 3 Mar 2026 20:08:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Omit win32-input-mode sequence from
 pseudo console
Message-Id: <20260303200802.85f1743454cc30334c9c8bcd@nifty.ne.jp>
In-Reply-To: <a37215c4-63cb-3b17-dbe7-9ae29677d39a@gmx.de>
References: <20260228090138.2540-1-takashi.yano@nifty.ne.jp>
	<a37215c4-63cb-3b17-dbe7-9ae29677d39a@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772536084;
 bh=Tex2iYmJfHODhXSplE+yt4U7gjZAkG0ykqiryyd2DVk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=QiE5yR6O9UZIvh/9XCJs/HihY3XfuTXKOT52m6Fv8jy3/ME+nKFYxo6P8sR9IaKSGpF9qvp0
 /+oj+TaP8YhkOlrMDYJtQ7JZ3ESag1IDEBOtQ105G94xF6ZOK+/r6vKWLYDr1z7hEAjnYQlVr5
 QaNKy8XwVWCQ0Mprigy8XxzYVazHS1tw+vq5lYM2gZa+/ZwmJRt0GO7FkcVQgtNFZXLCt87UIj
 a3PG0Y23eDBIUzAXg6iH6ANt4WfBBelNcYsEu297G5ia+bgAhpNFCQJ9MS3wDmn7vhnZShf0S4
 LfdaU82DvtxCydVdlrq/uPkXmFOtJmIR6DrB/0uXFKfrT0LA==
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 2 Mar 2026 13:46:20 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sat, 28 Feb 2026, Takashi Yano wrote:
> 
> > In Windows 11, pseudo console uses CSI?9001h which lets the terminal
> > enter win32-input-mode in console. As a result, two problems happen.
> > 
> > 1) If non-cygwin app is running in script command on the console,
> >    Ctrl-C terminates not only the non-cygwin app, but also script
> >    command without cleanup for the pseudo console.
> > 
> > 2) Some remnants sequences from win32-input-mode occasionally
> >    appears on the shell in script command on the console.
> > 
> > This patch fixes them by omit CSI?9001h to prevent the terminal
> > from entering win32-input-mode.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> Nice! This patch looks good to me!

Thanks! Pushed.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
