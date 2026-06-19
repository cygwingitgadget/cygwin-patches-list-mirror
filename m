Return-Path: <SRS0=IQe/=EP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 402474BA799F
	for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2026 10:40:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 402474BA799F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 402474BA799F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781865628; cv=none;
	b=QIzRTCmeitZS76KNUhQfPI9jrwq7LwMhXkh1YGKfHaYTMHbeK/TPWH3oOgwtZUmJGyKOlxmyYVZM/0UVyuuLu2cAL2LIWrd/EWxpJtjU9fP3ALSjN5Y42XzJSLd03FtRf4bg5n2CVlh0/fPy5RfdU6G6nYQORGdQNU072m7OJ6I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781865628; c=relaxed/simple;
	bh=jPtfO3DJIgdN90zmUuXYasK2tZ8DD8nuKzQ6xmDXbOU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=f3sihmKZtAceErK+w6Z4ikhtDkWNx+QMi1w2jDLN4eROsrDzxYAviUTNvxzdODaaL6uSlbLn5Hm95LPx6BPrtcpOMOBY9ZJngzaIUbF0JkviUM5AQ3azPMdh11nX8VaD2Y5tY4QGVfQJoWbFMtOtfLmDdWeKmFbV8VxyOGxH7ao=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=R+tjBKjv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 402474BA799F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=R+tjBKjv
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260619104025252.KABN.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2026 19:40:25 +0900
Date: Fri, 19 Jun 2026 19:40:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Status of patches I proposed recently
Message-Id: <20260619194023.d52908fe4288d45961568c20@nifty.ne.jp>
In-Reply-To: <c88a00b4-4bff-4c5d-bb7b-336a7a1d45c8@maxrnd.com>
References: <20260612224229.a1b848b8a14bb84a471fc958@nifty.ne.jp>
	<20260613232444.d4bf8f3d8d33908d8be14e74@nifty.ne.jp>
	<20260619140542.158c4f34e9083169a1882b9c@nifty.ne.jp>
	<c88a00b4-4bff-4c5d-bb7b-336a7a1d45c8@maxrnd.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781865625;
 bh=IbzxUjZ7d0Lwr/ldrTiRqKGtKausZXR1ZNu/bupSFD0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=R+tjBKjvCtcgrwwE9CJmDqJBrZqDqzFowEaLsahNbJML8tF5fFFgzmj8UAWsuA0qTZ12EXaS
 N444Ct6kwEuLfVOJzCeRkPoxyFRJfzEmZoeK76LPtqrLNOS7cb3tDWiAeNV33Zu6S3kWeeRpvx
 eUu16l4o1sM8q0AYVhDSwePgtyVLqHtaYotMR7VnX/5kExhLqKXRZJFbkaRHowp1y8jhwlzKAN
 t0D18PWEVxlegxKCFw7Qr1v/jNoVFTmC6W40gRIIJzU2t1JjHYUlFhEhhJzkQ0VmO1PTv3Jvpe
 oIW1fGBBt93E8uVAwD+1HDFHfZ2YWk4PKCWERtD0OKSUHAzg==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

On Fri, 19 Jun 2026 01:54:27 -0700
Mark Geisert wrote:
> Hi Takashi,
> 
> On 6/18/2026 10:05 PM, Takashi Yano wrote:
> > Hi,
> > 
> > Is anyone willing to review these pty/console patches?
> > 
> > On Sat, 13 Jun 2026 23:24:44 +0900
> > Takashi Yano wrote:
> >> All pty/console patches are not reviewed yet. Three patches are tested by Koichi.
> >>
> >> * pty patches [New feature]:
> >> [PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when discard_input is called.      +     [13 Jun]
> >> [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app exits                     +     [13 Jun]
> >> (These two patches require following pty bug fix patches.)
> >>
> >> * pty/console pathces [Bug fix]:
> >> [PATCH] Cygwin: pty: Do not set input_available_event when applying line_edit()          (T)   [ 8 Jun]
> >> [PATCH v3 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()        (T)+  [ 8 Jun]
> >> [PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report     (T)+  [ 8 Jun]
> >> [PATCH v5] Cygwin: pty: Fix race issue between starting and exiting non-cygwin app       +     [11 Jun]
> >> [PATCH 1/3] Cygwin: console: Ensure the master thread runs only when it is supposed to         [11 Jun]
> >> [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little                                          [11 Jun]
> >> [PATCH 3/3] Cygwin: console: Fix typeahead input for bash                                      [11 Jun]
> >> [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in transfer_input()             [12 Jun]
> >>
> >> * Others [ALl done]
> >> [PATCH v3] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN                (R)+(P)
> >>
> >> + Patch revised after the last report
> >> (T) Tested
> >> (R) Under review
> >> (P) Pushed
> 
> I will start looking at these later today, June 19.  Given this code is 
> new to me and (unlike Johannes) I'm not yet using Claude to assist, it 
> might be slow-going.  But it's all we've got, looks like ;-).

Thanks in advance!

> Anybody else with some free time (yeah, right) feel free to join.  The 
> more eyes on this, the better.  That goes for all patches of course.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
