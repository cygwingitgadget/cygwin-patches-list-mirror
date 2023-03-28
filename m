Return-Path: <SRS0=deyK=7U=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id EC5823858D39
	for <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 08:21:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EC5823858D39
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1679991711; i=johannes.schindelin@gmx.de;
	bh=fE1RAMV5QjEkufB4ZQeNMlj81wG4VVWK/jT7FR/shlE=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=DU98U8qOm+hZ3OMUoE6Frpgs2SYqR0PhTusKdcQD3aHjCwcG1W+V/bJfP62T5kcGV
	 CWZYXA/UxF75xSZHDzzbxXx2b0Wi049X+sEr0Ae5aF5/UdO3kn0I/BTiGInd8KJDW+
	 /nBC/f2KYdv0B53eM46bxMR7Lj0zUnwiY0tA3nueHL2CXrgetOWkR6nq9ljofov1Mf
	 QPKpi71MCGbLsdzYOEu/+kOb2KtrMlgerNaUSjSTFz8t5kGIiWWRGERxsRbbdJlskr
	 Ly1eNDZLMVb7zp3pa90zpOM7txfrUGIfkbfyooKgcPRzEZHOzMQN7MLjWyXWdvQoAk
	 FNfD4vUUK6kOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.93]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmjq-1prZ012uZW-00THgl for
 <cygwin-patches@cygwin.com>; Tue, 28 Mar 2023 10:21:51 +0200
Date: Tue, 28 Mar 2023 10:21:50 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Allow deriving the current user's home directory
 via the HOME variable
In-Reply-To: <Y3tj8Os0p2a43rhx@calimero.vinschen.de>
Message-ID: <b927da65-c500-a331-eea9-eae18199511a@gmx.de>
References: <cover.1450375424.git.johannes.schindelin@gmx.de> <047fe1d78c365afca7edfdf169fff5e1940c3837.1450375424.git.johannes.schindelin@gmx.de> <20151217202023.GA3507@calimero.vinschen.de> <1r1pq0r7-o3s3-so08-o426-296542797q94@tzk.qr>
 <Y07cOhhwu4ExRDzb@calimero.vinschen.de> <0q096627-r8pr-rno5-0863-s6n90psosq07@tzk.qr> <Y1Z48Mdk79/Qtwc9@calimero.vinschen.de> <66o0nq89-4599-np26-625n-2n8oon6p558q@tzk.qr> <Y20XK4VybCriMmn/@calimero.vinschen.de> <qn135110-43r6-o86o-887o-1rn29574s263@tzk.qr>
 <Y3tj8Os0p2a43rhx@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ii9ODGQOlw00qMGB/kF9f4KViNVvDCs281XwaL7wwx/J8QOLDI/
 oWH2Zbzx2w1ff6HJYGsfHHWuQGIXepJYz91aQmA/wfMhxaULPuiG1Q+9/WA6KFYtWGI8Jcg
 IB+oW1aNZHQWlNwUnX73P315mpyEfSr5gUGbYA5KhZoFhZ766kMqRT2c5cJXt+ESVziIyty
 mFZ1kQUupbJA8cErA0/gQ==
UI-OutboundReport: notjunk:1;M01:P0:lBZ2KGl47fU=;h6I+GWNwjus7tvLbdvVj/aPex3A
 lLkDSmEgm+2btrzc5kNQMM7A2DDoc6ZL8FEaoVO1QiM8pc58FepSuSw5/6skYTfLUjHzW8uMo
 4fXwKOeTKtqSGdSmgLN5rGHGGTXtOXbTk6nbTavqi7iW24A0uAPUC7pn010zHkVVO7LQAslGE
 PUjZvTRKi9UXLBnXJ48E+9vFWF00oTuYBO0mnx29pvimR3P5EzHw4LbUq8PTSuamqjHypj2ed
 GE3QHv1MMGR9ScrNwOfqq1sSe0YxCpbM4X3p6HEkIIjOWcbupee6/8Tnk8+9tmAqd2iIXw5Fb
 lwetDPJiuo8y1XjgBBlFL4in5RJZ0pL2bQ/c7rMKdku7oxg29kdGc9QH2sz+Fvc/LOVUmZv5e
 ii30C+950deUsQFh7wr9h5ySrGxNiCY/mWIYW1oDeZvEwkb5X50BABkgK6m9Dll1feqbTKH3v
 mJI80DyV9nAPQgMwFcvqpSt2Te/Cw9qLyS6Nxz28UWbleThnhH0fduhYeGFwPK1oVkzcmQrv6
 6vS2868LCpJqtTP2z4K0vtVOWfkJSJ4YqDG0iWE2gM7kpqt4/zRjNzRJXe7IhyDQp6zNi6lQo
 DvuxjJ4nEdjRYSaGXEI6y332Fk6Wpjb3UnO7rUZenbu3sahRbkjlfd9gE1TFnn51GjLPKN6OX
 eYFG8JW6V5hR4q+EqMXiskFxzSb5+VO/w9+3eijgvP5z/p08bq07C85/g1UBmebChdMyIWtfz
 AUAjHjCYsvokdpFA4U+AoaInZk6FBmdOwKJYZCMV57+ueiAZxBpg+Qn4Uy2eFTorN8Xdgmpie
 GLCvp4HUPITPI6O72UbHsQwSDOOsRf43nbU7k+kLyldo/jlRPwDDDA9DZizKXYYHMR1p9fXM6
 eMkBrGJ3NWmLrQW0rUkboKLL0IGpc3ATp1vTt7blw7hVfv1XQAwFnAGE7wMhXcLsC9WA2kL3p
 9NGfGfrY0CJxdu/f5JvhPDQqBRA=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, 21 Nov 2022, Corinna Vinschen wrote:

> On Nov 18 09:18, Johannes Schindelin wrote:
> > Hi Corinna,
> >
> > On Thu, 10 Nov 2022, Corinna Vinschen wrote:
> > > On Nov 10 16:16, Johannes Schindelin wrote:
> > > > With this context in mind, I would like to ask to integrate the pa=
tch
> > > > as-is, including the HOMEDRIVE/HOMEPATH and USERPROFILE fall-backs=
.
> > >
> > > Can't do that, sorry.  Two replies before I sent a necessary change,
> > > which needs inclusion first.
> >
> > I am a bit confused. Do you need anything from me to move this along, =
i.e.
> > are those two replies you mention some emails I failed to address yet?
>
> I didn't mean two different replies, but my second-last reply before
> that one, i. e.
> https://cygwin.com/pipermail/cygwin-patches/2022q4/012025.html
>
> Sorry if that wasn't clear.  Basically your handling of $HOME was
> wrong and I suggested a fix.

Sorry about being so thick! I thought I had done exactly what you asked
for, but had missed that `getenv("HOME")` already converts the path to a
Unix-y form but the same is untrue when getting `HOMEDRIVE`, `HOMEPATH`
and `USERPROFILE`.

I took the opportunity to unclutter the `fetch_home_env()` function and
document it, to improve the readability by strides.

Ciao,
Johannes
