Return-Path: <SRS0=7Fjc=72=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id A267E385840A;
	Mon,  3 Apr 2023 13:12:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A267E385840A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680527529; i=johannes.schindelin@gmx.de;
	bh=h8P2N8Sa/RzswIX7yk0tTl2XekUjcMDw4GJY06dfDt8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
	b=eyu3h1YwDiPjDlTic3RHFHcJn/G7KYUdpOGugTDbMPVKSQUhrKjcJQpqwootK8YS/
	 33+YZ2n4Iu/dofpJKQIgwUDyPFy0cerv6LU8R+wK5PjFdtG26/wwj6AXB3pr3dAf3Y
	 J7ZV4dqlqbX/hExRsgHf0vOuJ1Acpu6Zn40p00TZRefLgN+XkgskzWyU2ZlPk4Cuk6
	 brZHOPhykveCN9UHsju8ps5sE9AyyeShJ50unfIJ2PGonsBZwP9ZwVgTXFpYd6eZPN
	 BnkFOKdNFmf1fXwhQk5FBeCs9bchAPyXbQy8E323kWWAKqg4tcTqj2H8pZrtw4/Jt/
	 0b1tCX+TFNWJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1q0Itn1bJS-00IDvl; Mon, 03
 Apr 2023 15:12:09 +0200
Date: Mon, 3 Apr 2023 15:12:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Corinna Vinschen <corinna-cygwin@cygwin.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 3/3] Respect `db_home: env` even when no uid can be
 determined
In-Reply-To: <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de>
Message-ID: <8b84ada5-ae6c-febf-e412-365fe2f919fe@gmx.de>
References: <cover.1663761086.git.johannes.schindelin@gmx.de> <cover.1679991274.git.johannes.schindelin@gmx.de> <4cd6ae73074f327064b54a08392906dbc140714a.1679991274.git.johannes.schindelin@gmx.de> <ZCK+v7yBxRBft3UK@calimero.vinschen.de>
 <97e5226e-60c6-9d03-0c71-72e3192abe59@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fEkS/uP4Qw/Ugllat8w2r6NaMJQkMG24X2tsSzGEnewggsHw0J2
 0Wa4PfiuY7O0DIVjnrfEWdSH05eUlexJcGyHE1VcYzc242iBqU5Kz31jOHCUHXEKK3Fw/UD
 FAVSTZ3kFMADfwxSMbZoHcKNuy3eq9ns691lL5gAuEZiNsuLipHwN6QyCEsLd+j/6skGxDh
 x7eueYvQxshTMtVuhvdAQ==
UI-OutboundReport: notjunk:1;M01:P0:QDJg6B6TEGc=;5V6DXhuGNM1mk/dBwDxj31m4iLg
 Q2Gnw9lk8XdHLVQIBe8plPQm9ZlX+YKAGQb8wm6Ylf+kSIls8lv6jUzasB2xmyDLbRggboFp1
 qRSxu4lvIRB4ihESRSJDMQWEvGtkp/6nf9UuVmwqBwq2JFhtdjmHOvJOHZzpO5tfvIXuutKny
 GmuPVUzZMaRdWK+3DzPkNSg+9K1DvEYVgfE/H/amvZh9AIwmmj/suZ5HLE2JxymrzgA6XMG+2
 lxKiPFycw/P0MlA/Rlh6IMpjPkLIkSpSCZqZ4rdfm4jTWdbQf57DS6hC260ldcYtumAyHp3Fu
 ZVaI+YRhBPwAGtrzMTe6xW48Ua1owS/ceBLWmXKQmz3eXgYGIwoTeEUPlI+N9jxt0oDl7V+8s
 tUCQD6d6hfy0YJjeAcG+7nPfXFmejLCuWJmDpKJm2QpKsJ7yK12Up6Vg0WyMeY8sY+0KzKdAD
 rH6xuxBNeGx3u8j/dXZEWmrCA0EKtorascJVAKB7HgQ66XS8T3XJCvxOow1/yAnyUzbRcxyHE
 E08xpJLxmuCzC4GlLYZ9QXKPQxIIDiwDDxONvMpF0T/lsWLOxC/JvMy9w3rY8nDOV2n9OlF9n
 ovbgJyX+SJpaudhSMnmN7cwskabQOoR0f3nvkM10OiEuSFWIJzBzXLGXfCix/Y/BRtWl1vJzV
 wCuRtJ2p4IzMOu/i8436lMpXvWTTooPWXJvVXBrekiqP+zw/2+GgpGkbGRwxqECmHDbNf0W1c
 SebAEsrTaK2+jT9TDocX8ZgFHpk8TurYiNxrhJPDz+HWppcMPf/cKRbjKKmUzt39t9GdluJ/b
 nshyr1u5iHUIpmgaosxa7tFGQceCh04FYgfdf/GRuCt5DWKWJ8W5iKd/6v1pQqu+pwT2BwU9p
 yyB4WL53mPIuvlQW/bDI+wcLud2Aeaa9bFI3hFB1mi+i7vAL72Fo21R+to1gNZwbBRT+sn4FX
 9eVutA==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 3 Apr 2023, Johannes Schindelin wrote:

> On Tue, 28 Mar 2023, Corinna Vinschen wrote:
>
> > On Mar 28 10:17, Johannes Schindelin wrote:
> > > In particular when we cannot figure out a uid for the current user, =
we
> > > should still respect the `db_home: env` setting. Such a situation oc=
curs
> > > for example when the domain returned by `LookupAccountSid()` is not =
our
> > > machine name and at the same time our machine is no domain member: I=
n
> > > that case, we have nobody to ask for the POSIX offset necessary to c=
ome
> > > up with the uid.
> > >
> > > It is important that even in such cases, the `HOME` environment vari=
able
> > > can be used to override the home directory, e.g. when Git for Window=
s is
> > > used by an account that was generated on the fly, e.g. for transient=
 use
> > > in a cloud scenario.
> >
> > How does this kind of account look like?  I'd like to see the contants
> > of name, domain, and the SID.  Isn't that just an account closely
> > resembling Micorosft Accounts or AzureAD accounts?  Can't we somehow
> > handle them alike?
>
> [...]
>
> What I _can_ do is try to recreate the problem (the report said that thi=
s
> happens in a Kudu console of an Azure Web App, see
> https://github.com/projectkudu/kudu/wiki/Kudu-console) by creating a new
> Azure Web App and opening that console and run Cygwin within it, which i=
s
> what I am going to do now.

So here is what is going on:

- The domain is 'IIS APPPOOL'

- The name is the name of the Azure Web App

- The sid is 'S-1-5-82-3932326390-3052311582-2886778547-4123178866-1852425=
102'

The program I am trying to make work as expected (i.e. to respect the
`db_home: env` line in `/etc/nsswitch.conf` in conjunction with the `HOME`
variable being set to `C:\home`) is `ssh-keygen.exe`: We want it to
default to creating the file `/cygdrive/c/home/.ssh/id_rsa`. But what it
_does_, without this patch, is to default to creating the file
`//.ssh/id_rsa` (which does not make sense because that would refer to a
file share called `id_rsa` on a server whose name is `.ssh`).

Condensed to the bare minimum reproducer, the code boils down to this:

=2D- snip --
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <pwd.h>

int main(int argc, char **argv)
{
	uid_t uid =3D getuid();
	struct passwd *pw =3D getpwuid(uid);

	printf("uid=3D%u, pw_dir=3D'%s'\n", (unsigned)uid, pw->pw_dir);

	return 0;
}
=2D- snap --

In the Kudu console scenario, this program prints the UID 4294967295
(which is 0xffffffff) and _without_ this patch, it prints the `pw_dir` as
being `/`, even if the `HOME` environment variable should override that
for the current user.

_With_ patch 3/3, it prints out the same `uid`, but it does print the
`pw_dir` as `/cygdrive/c/home`.

I will distill the above into a new-and-improved commit message.

Ciao,
Johannes
