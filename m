Return-Path: <SRS0=4R0j=QA=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id D68D73858D26
	for <cygwin-patches@cygwin.com>; Mon,  2 Sep 2024 12:48:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D68D73858D26
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D68D73858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1725281328; cv=none;
	b=TkkFhu9n77Ucwpgz/As7Z6UV2G5uLW8l3dtSgaZ/jacvUv4VSgMHH+tKS45JAPDs2G5TYJoz3ESXVDI8rWQGeqdL4o/rZGY6KY9EAgNWkvwDrqy1W12YXeILdR+yV6DNTmAZJ1kQccNBpcHK4JjgkJF6jWw30VUP0SaYsDEtUjI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1725281328; c=relaxed/simple;
	bh=pkwq4zyrg3phVAR0Wwyq1ehxh1IlSclphEMtnqDeNCk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=vnNJRvHAT2cRMHRdh5gvdZIeF+yZDrE6zkyxkHgEF1nFfRrkWVgIbPH1LlkcYJG6TprhxGQkEPkhlJ6A9QMGvzmw7e6IlZWshr7029vgs9cpKYyo0/t3a6aqeGpL118SlINYbbexdso9Is0TqHuih5vHBHjkGZGVspUV5Ls5YJY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725281315; x=1725886115;
	i=johannes.schindelin@gmx.de;
	bh=O4lSJBEhtp0d2lV6XWcLF2YAciP++7amd4QOezw7s50=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Y0m6of/nVoMZzpVTZC/qyqMdDDTO82yRMReCJavhSmP7yOLPF61s878BZmx+i36D
	 oVMCi0c0UhJS/W7LP7tPP8pMSR/v2GUJKclfmMBSUO8XplPmVn7EbhV5CMrzobSWU
	 06zEft6Lz5+Jbj4YbWHw+fcItP2Neda168hm6zT0XJwddVyGwzKr8XQZziTJiCMh1
	 vhZ0xmTFeRQc3Tl+KRWbQt+o4ZmxQWpJM7XsaxHeH6ul7d2zL++tRctzhmp5fI7bL
	 cz+ebPwBzrwoEEhHPAIcxCHlwh3V01HN2KKKjcvSFZv5m8xS7jgjyGMGLD4gd9L8O
	 kliyBr/uX/gXVoQ0pg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.88]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MSKy8-1seXz11ulk-00JBoY for
 <cygwin-patches@cygwin.com>; Mon, 02 Sep 2024 14:48:35 +0200
Date: Mon, 2 Sep 2024 14:48:35 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Restore blocking mode of read pipe on
 close()
In-Reply-To: <ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
Message-ID: <a2800cf1-6a69-75ee-5494-a14b1a10a1f1@gmx.de>
References: <20240830141553.12128-1-takashi.yano@nifty.ne.jp> <ZtWdJ7FtgZcAaA74@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:skRbQEXCMrv3LPk3Pe4jmoX3QNXP6OdqyV2OrdaK29t+/Q7Wi7L
 fu8VLvW19xdG+JYRpkB5VXWZMYjb6PVxb4PhlTLByj2/b/teMdqoNyrYQsYhOsPlM02uqTh
 mJU0dIKcwJUhdOjQtBMjG/6Nrk71W+rB260AKSblHlm68ZT9ZVtLE5yxkvTm8uFroVW67fL
 4kiZRA3O0YQ7vxqZCGhtQ==
UI-OutboundReport: notjunk:1;M01:P0:WEda/lXxHqQ=;SA0Sg0eieBF0MEuDc+6q6X6qfaS
 KJWE0N6itCGxPF3aRKrlPAyumCWixriOwrVsjox54s1K2HNxmSb/Lrtf8NsOkIgJNqUiXPKa6
 RK/bpO+dTcTuQJm+kiElRkabr4XKvxnqzuRc80SvHxlv/c3yj2RmtqfK7SyKdErvC0Nvh7dqT
 CoNwxhf8tSVRSb2VFIR5E5G9UMF482C5UTMTh644BUK2elf6PGysV/DdDbF2esnTpUgpGbyjc
 9pEAusZRhr2VVosdV/Ij+MXoI8ZViVvexsz88QuyIAZxM4Mc6HASx6lLAGgODzaAvyHdWV0+o
 twbyrVXIJyIGIdRGi5d/ByO4TL1L4qt0ekW4/kupjv4UiRFWyii1gxj9fkxhUX/joMfxolUQ0
 BJqwRxBdEqZWExnOFOmSYyeDaY4JUN2liwnOfBrGuHhJxa4wT3tq4rqOACuVohI+GpHTcrIgb
 gwS5JYAsXsIq2k+BSHx/vVjxdM1qnCK27J/gdO5GarZmMFZjdxcYq6FwpkCRKNS4NEiC+TRwq
 Dpa8PI31i0LY2c5skoTOY5Sw5oxlr0NSPlnZfrDdOkiBGF70MZWAczpW6ufqDJIetO9L1B3zh
 STnuy6iwqixcmlb9dAw4XyQbB1RA6GFtf+VtiK2jTLipXhlen5xQ1xx34besuIXRpjJcnxMTg
 hEI7GalqCIjcpm7W+rKQW0FpmoFoI4Syo0C6uOItnYviTJMkooZZ9H/otrWOzZpukVhgRfd0z
 uSWd1WKk4VHsHqIhoCWoOxQ+OIn05fbNnPZjLSBaMKtnVV/8EKjqDU5Wr2/5jsNQ4/z0+sLXz
 q7hZbtoeDP+7E0SbbhgRip4w==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna and Takashi,

On Mon, 2 Sep 2024, Corinna Vinschen wrote:

> On Aug 30 23:15, Takashi Yano wrote:
> > If a cygwin app is executed from a non-cygwin app and the cygwin
> > app exits, read pipe remains on non-blocking mode because of the
> > commit fc691d0246b9. Due to this behaviour, the non-cygwin app
> > cannot read the pipe correctly after that. With this patch, the
> > blocking mode of the read pipe is stored into was_blocking_read_pipe
> > on set_pipe_non_blocking() when the cygwin app starts and restored
> > on close().
>
> Looks ok to me, but it would be helpful if Johannes could test this as
> well.

I have tested it and the symptom is addressed.

I do have to wonder whether it is intentional that calling
`set_pipe_non_blocking(false)` followed by `set_pipe_non_blocking(true)`
on an originally-non-blocking pipe will "restore" it to blocking mode,
though.

In other words, where I would have expected undesired logic to be removed,
or at least to be adjusted, the patch instead adds code on top, adding
even more logic.

> I just wonder if the whole code could be simplified, if we set
> the pipe to non-blocking only temporarily while reading or writing,
> while the pipe is blocking all the time otherwise:
>
> - Create pipe blocking
>
> - set_pipe_non_blocking(true);
>   NtReadFile() or NtWriteFile();
>   set_pipe_non_blocking(false)
>
> How costly is it to call NtSetInformationFile(FilePipeInformation)
> for each read/write?

That would potentially be a remedy, but I would worry that this design
takes a decidedly single-thread world-view. While that may be appropriate
in the context of the scenario described in the bug report, it may very
well be inappropriate for Cygwin in general.

Speaking of the context of the bug report: On a practical level, there are
two non-Cygwin processes talking via that pipe, even if one of the two
processes is spawned by a Cygwin (or MSYS2) process in the middle. It
might be better if in such scenarios the pipe would be left alone entirely
by Cygwin instead of toggling the blocking/non-blocking mode to begin
with. Such use cases are probably not part of the overall design how pipes
are handled, but maybe they should be.

Ciao,
Johannes
