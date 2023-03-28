Return-Path: <SRS0=deyK=7U=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id DC8C23858C53;
	Tue, 28 Mar 2023 08:34:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DC8C23858C53
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1679992450; i=johannes.schindelin@gmx.de;
	bh=dUEYelXrHoeAoF/P7wT7f8RM1YJpVax/tL34U6tsHqQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=lM0IJVmXWaOhfuFXVK5UqLR+rQ1zNTWz5yFKZdw0mju6AI+gWL19mWaJkHbB96YIa
	 O5fbjeC4B6gTRKnqS4zrazPmOpmSUPUssAZXkEE06SwQ1cVwLyLjjF+d+MYk5Yv4M3
	 8BBj/n3yyNsycXLjpO2iDftqynaIVXCpAC6df1SQq3N5goM45QYm5xuStOfgl94+6w
	 LgAf/I4YnsDPZ3LD1Zb6fvPIVZ9Y77EUpy7DkMZCj5uJR9fyon0aRPENOMw1M0szeh
	 zQqfsUwbpVlTxAF/9vCjASBFHdEUnpzuBK/UK8WuttBwoO/XTU+NfByhfGDTZUbuen
	 /JFCiSVYGi1JA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1qJADt2Wbf-00dXLI; Tue, 28
 Mar 2023 10:34:10 +0200
Date: Tue, 28 Mar 2023 10:34:09 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Provide virtual /dev/fd and /dev/{stdin, stdout,
 stderr} symlinks
In-Reply-To: <YhyccZ1dGKVeRNdp@calimero.vinschen.de>
Message-ID: <4d1cc2a4-040b-d037-50bf-bd162cbd387b@gmx.de>
References: <cover.1645450518.git.johannes.schindelin@gmx.de> <YhTYazKXC+2X2TbU@calimero.vinschen.de> <nycvar.QRO.7.76.6.2202251645090.11118@tvgsbejvaqbjf.bet> <YhyUwucjllyFpkRy@calimero.vinschen.de> <YhyccZ1dGKVeRNdp@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:agUFD+8QiB8Mvz4ddpE8WPymm3NfbQLBQiS0RbWgNYjDySm5URd
 AxklUDeS+M/5xCVpZQTRE3IBc0NKhzwtHwDTWqTv3QH5vLJ6+kHJrS3vIqmMKkRFJHR5amz
 h47UShn6jifId1KaMP2n7rHLNzjZKJynNyIb/FDQP0Tu3ESP6cZ2WxqHSIo4Im5pS2JRLtE
 rfDgxaKNbOJWRmtLu7NhA==
UI-OutboundReport: notjunk:1;M01:P0:DtGOqwsztP4=;Gk64K8YP0g6/pl6kXjXQ5mfdOxF
 QKP8KYSYxN1PXdCTsKEYRH2dADq829qqYsku7AlyaoH6am1cu4DJdjD0wRHU3diG8dRnISUfK
 83lJzG/2h/KmbLEAzviek2gezMVk7+99qdoK3I+4vBd6EX8/KDg7laU0yQxQj8dejJaBjjkM/
 52X4gsZgxBAoPCZUM1FWcGrUgSG9W65et33mcdiZaGGmnW375+yuVyUhu+glntE4ZzDUpclXR
 j089fkVrxC08VqGDU1XK0Ykj92HDQBupOx4opbjoXlTYKGMntEq8eVdm44Tw4F3HFARr8zOzq
 tziOw2P9/aDQe/+rH/d0y3b9hS+K88+zt+ayTMfaWT24fS2WEcw/sRzdAsg29YRQ55vboHB8j
 fJ9wGIb8Y7FMfesTndTw106Ogk9hm8yLwmAI2DRATGq5W5/lptkOHqCCiYfKleSaZs5Yqq9Rw
 1OEUGlp9T37lnOCSyqFwYDlPeu8c6qfzGPrzKwnZ5k9iF3KxgdbCWADFXbJtFJltmouDYU+1G
 vqW+TnMXALLxVGB8+2YSdbte9slhgebuVp2O74ww/rn2iz/CcuOGngRl8H1i9enYAAsI90LmE
 qxJ227r/RIEy34HBIu0OXUxjG/9c2KtCmwmOp8qWM3X8FVTPaPDQfHqo5ksphVU9QBaUzffYt
 asbylzxokDNBeO72aKdggm9H7udlJje4TNEZAUKjs4afWgzhpKXqMVzhjqFzUMlb4DnH4oNEO
 wnRS2o6mT87oAUAli4/7oeFZtPYjbDnd1dpnmsEb4JH474xD4M0NtAt5vNLzdV/SyHUhPbB0Z
 TYYmcGZjki3NgdMktp+uSQJwq4JGpkI4Y+TYYRbIXdBVWlxRJRp31uY9Uvig/im2PnnVjZtCw
 vZeDC1rYu3EFHRAD8Y9IcARYHTEmwQ0CQMGt6IyHeCIpZlzeoZbwqeXLhdg4hE4zfUxr5FPKv
 55FsDmyvVhJuWnIhQnvZV+0BhOE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 28 Feb 2022, Corinna Vinschen wrote:

> On Feb 28 10:24, Corinna Vinschen wrote:
> > On Feb 25 16:46, Johannes Schindelin wrote:
> > > On Tue, 22 Feb 2022, Corinna Vinschen wrote:
> > > > On Feb 21 14:36, Johannes Schindelin wrote:
> > > > > If there is appetite for it, I wonder whether we should do somet=
hing similar
> > > > > for `/dev/shm` and `/dev/mqueue`? Are these even still used in C=
ygwin?
> > > >
> > > > "still used"?  These are the dirs to store POSIX semaphors, messag=
e
> > > > queues and shared mem objects.
> > >
> > > Okay. I guess we do not really use them in Git for Windows ;-)
> >
> > Probably not.  I'm not aware that git uses POSIX IPC objects.
> >
> > > > These have to be real on-disk dirs.
> > >
> > > Could I ask you to help me understand why? Do they have to be writab=
le? Or
> > > do the things that are written into them have to be persisted betwee=
n
> > > Cygwin sessions?
> >
> > Cygwin uses ordinary on-disk files to emulate the objects, and
> > they have to persist over process exits.  Unfortunately I don't
> > see any other way to create persistent objects from user space.
>
> Btw., you don't have to create those dirs.  Only if you actually use
> POSIX IPC calls, the directories are required.
>
> In fact, the IPC objects are just mmaps (message queues, shared mem
> objects), or the file is just used to store the values after closing
> the object (semaphores).

Okay, I _think_ I understand the issue better now. Thank you for indulging
me!

> With "persistent" I mean, "DLL lifetime persistent".  It's not required
> that the objects are persistent until system shutdown, as it is now with
> file-based objects.
>
> It would be sufficient if the objects persist until the last Cygwin
> process of a Cygwin process tree exits.  I'm open to ideas, but they
> shouldn't further slow down the startup of a Cygwin process tree.

=46rom my limited understanding, that _sounds_ as if a shared object might
be enough (similar to the shared parent directory that
`winsup/cygwin/shared.cc` is all about).

If this sounds like a viable approach, I'll put it into my ever-growing
backlog ;-)

Ciao,
Johannes
