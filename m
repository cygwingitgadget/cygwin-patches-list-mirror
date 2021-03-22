Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by sourceware.org (Postfix) with ESMTPS id 5C4ED385482F
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 15:22:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5C4ED385482F
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.144.62] ([213.196.212.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQv8n-1l4Kh21A99-00O31a; Mon, 22
 Mar 2021 16:22:35 +0100
Date: Mon, 22 Mar 2021 16:22:37 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: =?UTF-8?Q?Hans-Bernhard_Br=C3=B6ker?= <HBBroeker@t-online.de>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
In-Reply-To: <69dc492e-cce9-1a1a-7d4b-92a58dbfe981@t-online.de>
Message-ID: <nycvar.QRO.7.76.6.2103221603030.50@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
 <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
 <69dc492e-cce9-1a1a-7d4b-92a58dbfe981@t-online.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
X-Provags-ID: V03:K1:/w9EeQDBik40+3zCyvFd/zDgzUVuxd4W2+Yu+8vmR7HSzXQeInT
 EkjGBwuFTIvz8ogih0UG85Gi8FHkFeUpBNnB34j/7MgAUlnBmR50Og4FMi1Zm6xWMdJoQQ4
 hUR0nx7nvAJaQNAjl/NDDOF4rtanwAi4M1WpheXrLSN4O6rKVsPtsys3AMiPAUYSymsEKzN
 zgwn9V39sdS9JqEtbpcUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZpAbMq/CClg=:1wG885XsETge0nR/q6T4vM
 ZKil5fvZL7EL/PpDHo+7lMTJ4qayEPXkX4541AYCQkBRpna4t07KxLNVJFcqetdrc1RvZDEpo
 Y0rt/pTzGBcG5L5MJjrd0MXU0gEV68wyXCNhkLdtsnrxTRmXrktoJ24Dliolq0N7ok+a8uZs6
 66Nf3mWdqZEJ5INJ7l+cRbkLH6uyI6Mbp9Z5v+5xNU1g8iI/AmVzHn4a5zvO1TrfO+VJPkhkZ
 fzqFAAkiKFn43G57hybTha9KorgnFULHgjnE9syzmbdg8DcCmT473TK4jAg9eLrh6ezG/M9O0
 fB/3lAwKqim8/2JBxm7NQQeB5aG5YlpefIjSFlBXqKdTajT/sHPCG/D4ToyVJu+z5I4MUKR0y
 NrEnzbbRMnPO32SS16OaA46k/tOMv7GnbHw5ILxZkx/EfR74rNjso4VgLbDApGpp5bonEAFlz
 2WNuSERxeIaj/BRP+StpRglNo/b68pgWGRjgeJnhyEd/U6YPDYLycCKpJZZgAVbxMzQ0SiQc+
 31nYnRBEzD79aBmpCvLzzGFwABGg0crH3aA48yfdPyUQFSopbpwqVnfYKtlo5hDbeR7Lvagzk
 Xj9H82OZ8G3vEsuwZ0FJoyHNIREPRImP/rjzCgevsyidnMopcOY3ndAq4Q3PZVT8s68yHV6MQ
 IjjwjrQHnBcgzHoln0qPbah+zA28qy68gHbFy5XIHHmCIqhR9pRQMFJKGTH4U4OJn6FeggGln
 hgEOZU5iQHhdEhZLIm+PfDaIiUcoZPEcmWmltI8Hdpe2UC9UHNze9KbZ8pj3l00mZ+wciegNq
 65SHiA77SoRc3BUHu5tBU1xMCEe9k44Kg6klFx9x+Vs29mx9iXlucx/i12wo3MqvR/zqSCQKE
 6dz1ENmNj4Nae9H4joIDb8pg9NKsSPCEeoHEoht9gfjWF2mHzhf2D7YfZ3S3Kydt+0Ow41liA
 DnUcO7Zle+4/dEmgU1XC0PKup3j9O5SAGecZFFEFAtBJmZV9FUWH+uioDeaTQQuU3jVgrB9+r
 rwQgcDsTtLLtGJho4wd2PUyvocInypPjUwdWnG0YaLZTfSHg8PrDmnWe84gTOAt+5vPtur1lu
 bOgn4aeA2PiBT9v/7nZR5F5zI83oAzMeEIhE6nip19hhSU5/fuS029lFP9VjnETNCZdd/mAnL
 Stnz41t0t+DTKBR9OGjUrKgndja4bFT3SbzNtcOI00t/XyEPHthOdVBDQCIrEmpzOtaCMVhCV
 QpRwBGxv2GmA6YBsY
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, MALFORMED_FREEMAIL, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 22 Mar 2021 15:22:39 -0000

Hi Hans-Bernhard,

On Mon, 15 Mar 2021, Hans-Bernhard Br=C3=B6ker wrote:

> Am 15.03.2021 um 04:19 schrieb Johannes Schindelin via Cygwin-patches:
>
> > On Sat, 13 Mar 2021, Joe Lowe wrote:
> >
> > > I agree on the usefulness to the user of showing appexec target
> > > executable as symlink target. But I am uncertain about the effect on
> > > code.
> >
> > Maybe. But I am concerned about the effect of not being able to do
> > anything useful with app execution aliases in the first place.
>
> That argument might hold more sway if Windows itself didn't quite so
> completely hide that information from users, too.

"So completely"? It at least executes them, and it does offer you to turn
them aliases on and off (see
https://www.tenforums.com/tutorials/102096-manage-app-execution-aliases-wi=
ndows-10-a.html)

Granted, the user interface has a lot of room for improvement, but if you
are dead set on finding out what, say, that `idle.exe` app execution alias
refers to, you can go to `Settings>Apps>Apps & features>App execution
aliases` and find out that it is owned by the Python 3.7 package. That
does not give you the path, but it does give you way more information than
you claimed Windows would offer to you.

> I found only one Windows native tool that will even show _any_ kind of
> information about these reparse points: fsutil.  That is a) only availab=
le as
> part of the highly optional WSL feature and b) only gives you a hexdump =
of the
> actual data, without any meaningful interpretation.

The `fsutil` program, contrary to your claim, is available without WSL:
https://docs.microsoft.com/en-us/windows-server/administration/windows-com=
mands/fsutil

And yes, for under-documented reparse points, the tool gives you only a
hexdump.

One of those under-documented reparse point types is the WSL symbolic
link, which you will notice are supported in Cygwin, removing quite some
sway from your argument...

> For something that Windows itself gives the "no user servicable parts in=
side"
> treatment to the extent it does for these reparse points, I rather doubt=
 that
> Cygwin users really _need_ to see it.

Well, that's funny: you are talking to one Cygwin user who needs to see
it. So I feel a bit ignored by you there.

Ciao,
Johannes
