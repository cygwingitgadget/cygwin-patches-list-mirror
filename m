Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id 565374BA2E0F
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 01:35:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 565374BA2E0F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 565374BA2E0F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782178507; cv=none;
	b=iQZe8w6wESI+RQaJfocgFWiGK7LVsrshHr9Zj6TvmRnOVMVRD5/DQv+97FVG5nnY9Vt+yjnuMNptNeyA1MX+NHbBCJ5kz0dtuZr0oPMTxmyYnU5Us5Ey7KEknPwbRltiH1iCSnFwya/AFe0G1wbY11EuGBwc8ll+GFW7InPKYSI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782178507; c=relaxed/simple;
	bh=E2K6KoxGKWkJbSI7zcocQYj//kGdeNPxMyffUXza9VM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Nrh9rnKUePbB4xnwLcoo+GyRlNxv1LImoySHhwBPwEeMWRKEbCe+e945OxliUBHOxn/03EeguVc7sJd6Q8EqmnobXlDCOwM3lNi35Y95YEsgMok20k+2oTUHQ/dfUSUDz4KqAxLJEtQDtOrNS11jkvfqI5DbmdDcArhU+YQVcbA=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cA9FkjAK
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 565374BA2E0F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cA9FkjAK
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260623013505478.ZNRM.3198.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 10:35:05 +0900
Date: Tue, 23 Jun 2026 10:35:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Status of patches I proposed recently
Message-Id: <20260623103504.64c32ed071e6908b1684432b@nifty.ne.jp>
In-Reply-To: <20260619140542.158c4f34e9083169a1882b9c@nifty.ne.jp>
References: <20260612224229.a1b848b8a14bb84a471fc958@nifty.ne.jp>
	<20260613232444.d4bf8f3d8d33908d8be14e74@nifty.ne.jp>
	<20260619140542.158c4f34e9083169a1882b9c@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782178505;
 bh=Ra9k9iC6omKeUs93kKQWxuCaMthqBD3e1oZO7hx2zgg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=cA9FkjAKYOR6+hNzzz1iuMqzguEfLnOpmbVk9EW4VHrZN2PtMzEbjBpEvp+i0/iWPX5u1zy7
 zDP1cZD8/8S0LjjDWybmRLEwyCV/Uj4lE8Bpge+K45iTwCKXEDXu5E/H4EzrPDNp/wWrxxQjnj
 NG/CGBo9w9CFJjWx27d7dzBq31QqxxyUZ09NA1U0V3JLgNKkAbILDOb+6m8fCghrnQszWhCD70
 88QfeeQE43wOhkQ3IY5pUpSXc6rQjDaYeGp1GVniTp2mf3RL8wxnw19LLa/gYp6t2tA7nJCSdC
 R9uuipLeMZr8HZl8D8hLxq/ehD7i7P1k0jJwuLjBpEni4EpA==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Status updated.

* pty patches [New feature]:
[PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when discard_input is called.            [13 Jun]
[PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app exits                           [13 Jun]
(These two patches require following pty bug fix patches.)

* pty/console pathces [Bug fix]:
[PATCH v5] Cygwin: pty: Fix race issue between starting and exiting non-cygwin app             [11 Jun]
[PATCH 1/3] Cygwin: console: Ensure the master thread runs only when it is supposed to         [11 Jun]
[PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little                                          [11 Jun]
[PATCH 3/3] Cygwin: console: Fix typeahead input for bash                                      [11 Jun]
[PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in transfer_input()             [12 Jun]


[Done]
* pty/console pathces [Bug fix]:
[PATCH] Cygwin: pty: Do not set input_available_event when applying line_edit()          (T)(R)(P)  [ 8 Jun]
[PATCH v3 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()        (T)(R)(P)  [ 8 Jun]
[PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report     (T)(R)(P)  [ 8 Jun]

* Others
[PATCH v3] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN                (R)+(P)

+ Patch revised after the last report
(T) Tested
(R) Under review
(P) Pushed

