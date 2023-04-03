Return-Path: <SRS0=7Fjc=72=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 3864D3858C50;
	Mon,  3 Apr 2023 06:37:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3864D3858C50
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680503820; i=johannes.schindelin@gmx.de;
	bh=Tb54V7q8UILhUyv8tDKNlX0nennJtgy2lXF3i3yOi+0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=uVkAJStQb1DFoWfEGQOCYpykBQaM8on5tCysKc3uAWOqLma7JQV9bFM+bVHkV8y59
	 bijF6BhDrnCwo7XTPLJQyw97x5o8tdrze3mcEGMybNL234+CEGRs+G7CFl5SKCU773
	 /aO+8KnFJKiL/ZR+UeagG1XEJXk/Sl7FkAM+hMaIN++87HztRimvxj+j01GGMrQxfZ
	 jEMcXkp3cvWI1mxGm7XlgppKMeLq9MyVUkugNFmir33bcbADGH9slAu6nIjKagl8hJ
	 d7/eACh8G3nGgwEliCed8xxCPU4lAVdfu7DafWWFdci/Kmhsi9c60K8/yjHp9yi/AI
	 kbX8vU0Dypg8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1qauap2kfn-00syJU; Mon, 03
 Apr 2023 08:37:00 +0200
Date: Mon, 3 Apr 2023 08:36:59 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 2/3] Respect `db_home` setting even for SYSTEM/Microsoft
 accounts
In-Reply-To: <ZCK+mOdyaAQnLBwF@calimero.vinschen.de>
Message-ID: <f14da2f0-2e7d-73c4-e6d9-e2516b8966f2@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de> <a70c77dc8f0d8417537557ea8e3a38f85bc582dd.1679991274.git.johannes.schindelin@gmx.de> <ZCK+mOdyaAQnLBwF@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n9LSTvGqVG6aO//LL/co1rCDW+BbiBLSIRTs2b6Sxu9rsgjLCgD
 Yj8LkEty7C04WSUE9GoUZjRoJb14xO1D8NmL0XYi940msU5nBfFen+8JHIR2wLbbzjdmabs
 ODf5yt7jiLxPj1YggL5CpCd8CpEi/qiFE9u4fFbHowFEt9c/P0xYKC5MAncYn02PevyEho/
 uyppdjuQziYkH9z8qgWvA==
UI-OutboundReport: notjunk:1;M01:P0:x99rajLxsH4=;Q256N1Ss1Vx1cgIE2927LYfEvK4
 Hr5EiRnG/QP+JvadGt9MDrsTQFLeXC15O30VvL0c8ptAKIkThSLmqsakvXJvrPUK8rc/B1iYg
 nZqMLsnRK+C9hHzw5aol4xnjCyoD/HMhg0c96K0487hN/X0Ojl09VISkyBmgLtNyyOeoA1Vln
 slFoikc69PgUWZKE82VloFOtaAHO1j2vPCyEkPITGITKQMNreex84Lr8tIsObrmzp+CNpwfuV
 BLoY51aIFaZ95CpSmkO1eUsE63wnviyzD/P7wionzTxUGCPbFY+TVPrIC2g80fOk+KlUoDxla
 QXoXcQAJ7apmeyFz3Ve0Zjgqy1V6W669duT+drETPNy9jUFveMQAl2tn3Jid3MRVvgLumJtIv
 m6HsojmRip2WVZXVI7HLRcyAIAvWeOrBOY2gMHn6pNrlpzknLDa3ONbeGOKT8a0Tl2Rr4hk5n
 pCg1gOWKToNiDACeYUsFW6QGfJgtmrQHylHkYkeoapu/diOh188bWYwd3YkfdIlaZ2eo+q5uq
 OjM/9Sc1FfbXoAI1ZqQpir8tov+2XkqVKQv9IISMozORK23IiwFOYRHyb+cd6IV09f32zo+D6
 vc5CgxWAljWIaTZtIQQKQVTRr3S5DU58I4yTWSV8jYO/kU3aUhl/BWcJK/+J5J0rhzHTvU/Le
 2jw9GeE+4fZSG8ndg9QknYlHYZegaxfP7xr+eATZRq9dpOrOc8Ja7a0isoVAkIALgT8KjIMA3
 DIIy+LX1zwBVSjALHUOwYmDwbkHlyAI1gjHoXwsUuOT47X28HPxH2gGxIjSnQjKrG/BC9tNzA
 9k9cW+dyrRMLhJU4HEMnkZGnmCvO6cF9WSLs8ol4xYX51GMnnfmYna3v9NPahDxG13jsS1tZo
 jpigxLpAqZ3O9SlwY7qAaKHX0bYwKZShl7atXNXmFezCkUf1QDbLrb8Xng5gPs90JFWacP2zM
 kdx0u2vJl5a8RmISFCJ03Cv0Wk0=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Tue, 28 Mar 2023, Corinna Vinschen wrote:

> On Mar 28 10:17, Johannes Schindelin wrote:
> > We should not blindly set the home directory of the SYSTEM account (or
> > of Microsoft accounts) to /home/SYSTEM, especially not when that value
>                                   ^^^^^^
> That should probably better be <username>, no?

No, this is the actual name of the home directory when you start
`Cygwin.bat` using the SYSTEM account. To reproduce, I ran `PsExec64.exe
-s -i cmd` and then `C:\Cygwin64\Cygwin.bat` in that command prompt (after
verifying that `whoami` prints `nt authority\system`).

The Bash prompt then says `SYSTEM@<hostname>`, and `echo $HOME` reports
`/home/SYSTEM`.

Ciao,
Johannes
