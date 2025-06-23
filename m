Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4A35938890C8; Mon, 23 Jun 2025 08:39:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A35938890C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750667991;
	bh=1hUmMH2tWUxVF1mqQv/u092XAMAn7V4rSRygqtHw/3A=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ix+BRbnEaP+J5TsciS9O/N9BeFTqNNN0Seyp2chkrwF1Iy5Vi4Ktwp4POGMwuW945
	 zACso4eYZx/hv0SkY1GT7iA0TrIwt5hIF28pnv0KUz/Dc/EJnxyeGJsAha3sSHV76d
	 tDUsGdjtxWI28hB3Bo4QCZA61P4XKzxL4HuuiFSM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 2AB98A80D72; Mon, 23 Jun 2025 10:39:49 +0200 (CEST)
Date: Mon, 23 Jun 2025 10:39:49 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/4] Add tests for posix_spawn
Message-ID: <aFkS1da-6fyZmYN8@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a86dac1a-d11d-d993-d0f7-d80fddeff087@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a86dac1a-d11d-d993-d0f7-d80fddeff087@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 20 11:00, Jeremy Drake via Cygwin-patches wrote:
> I got all of the tests that I had written ported to run within the
> winsup/testsuite context.  I did not include a test for NULL envp, since
> that seems to not be specified by the POSIX standard, and behavior differs
> between Cygwin and Linux.
> 
> More tests could be added (notably for
> posix_spawn_file_actions_add(f)chdir), but this is a good start.

Indeed.  If you tested them with current Cygwin, feel free to add
them to the testsuite.


Thanks,
Corinna
