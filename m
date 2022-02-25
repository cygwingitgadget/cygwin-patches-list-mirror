Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by sourceware.org (Postfix) with ESMTPS id 6677B3858D28
 for <cygwin-patches@cygwin.com>; Fri, 25 Feb 2022 15:46:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6677B3858D28
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1645803997;
 bh=J/ga8ScclsKuMhUXgXTcUd8s+u3KE6XMHCF9653QhS8=;
 h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
 b=WCH8hdOuYSUfjhSzBgf1Pe2q7QzCHGLLtE+0xMaI6skjFqtiyr7iKtXhMbv/DNRol
 9dDlUlYTPvqA7MIeH7lVju2iqstwm+6y9FVu+SIieIQaktICkVmfzzKP5l7B8rj6e/
 6bdCIjVk0xZiQqeoZEzIViCMhbR6EvalwylTemsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5iZ-1ngX600ATN-00J19K for
 <cygwin-patches@cygwin.com>; Fri, 25 Feb 2022 16:46:37 +0100
Date: Fri, 25 Feb 2022 16:46:35 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Provide virtual /dev/fd and /dev/{stdin, stdout,
 stderr} symlinks
In-Reply-To: <YhTYazKXC+2X2TbU@calimero.vinschen.de>
Message-ID: <nycvar.QRO.7.76.6.2202251645090.11118@tvgsbejvaqbjf.bet>
References: <cover.1645450518.git.johannes.schindelin@gmx.de>
 <YhTYazKXC+2X2TbU@calimero.vinschen.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SWPKoZxVpmb38mydWxu4yBxinglHtZYuiNlIT7TlGpDmJFAoYJK
 CV1gNxPWhR5dyHjc3uCp2vPlKLxEs+w/DvfGN0dLBqCEl9zcx8HixcVkQ6xYmx1TSULILbZ
 sx1h+k8QPMHAkU4/gErL+nvrOM18qp6p0rbrSP9x0d3/aW/rn+FRK38DKJmZh4rkiGCE1q5
 NA3c1BajbYmj+qpiFfLcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RL3VuLoxfek=:rtmdQ5XgBbPws3CxDf2EMr
 9GdRTZMTTzgkg0HK/jK6BE64DQJ3hylVqCXM8DsC3TbQ307d9U4s2FHtrDDNGaL4jE9QIyJIY
 ru/EgfTIZQEYtMMzxieBfPtX+If29MrP1G0RX/9txFQHQA8Zz9bG94meNxge0SEGFbmNm4uxG
 VWGDlh9ww6OrokSGMlVOPboBIKIljqj6lyPt6cH3mDOsRXeAeOATPUUW0X2vjl+pZ+TrvuYWB
 bBBzg5Py60o447ATsq9ov341U5ljqa19b/r8+sZrHoWj3X4v9D9HJUJ0VJbLh5a83fi7rDpQl
 0w8pwGQe4IYDEgrZIvYF8lYxd1TwXjixapm0j02BRDmG3giaSYJmkoKL8C6qcmFz+AnqO+TaV
 mG1VU/Rnwnxi9hl2oJBD55FJkslE3em1SzkCWH6Yp3uAw4WHiNycFv1ef5K5BMOmi45lJfw39
 ABj1oJD+j3eF4/wuDIx0bMiidhvtqmSYsS9yCOXhgv9AZ9NSDdWBh6nX7bwnrVS7hIjAo/bEh
 T2TWpr/LTsYUWTPTpAvgd47/FiY0xRdxc6SGmQ0sr7wIU1bSlPCQDP7hbhJmPFcT87fe6CsWm
 FMi0ter8vEEkSPyLhiFSpNEn0z5M/BO1QYPB6OETrq2hFbikIq4yGps7+zz96jAR1fNk4sRYE
 Phs1dg2683Tu+WBhTX63y6eaGzN3NZzOHoGPpiW++SrWdeQS7OMFaQpn8L7t0UHHRiTlIKCyg
 Jdq0u67o/J/9TJ9jD6BF6GKiN0vu4rNN1QtwIVJqbNiXzv4ML2BXMWLSTS1WF2WdkRZ75zOWR
 dEGK4tldO4RKPao0E+kSvXdRTjnErgueAquyfd3fB4Kj00xIwYZ22Zy3PQoaTJyaNnktOFdFT
 VK2cs8xWRt64J5zrgSh4Pc+y2L4flLWsgzAmN+jgNU5wEKwqG1JwjMbxWTbPK4m94mNl9vcNT
 kYEnUmLVqUDzMdeQxN5oTBfumydEY0okCEiRn43kDxEGLFWA/xI+POx/r+X7vB7EM1x8z9rkE
 PN8d6noBGzXVw+JiLdFwWCv/fuq5q/ZrObZGliMoRE37heV/1/zlyOuIvBZhsSV1yQkoGI7lJ
 rBkOV+GgxEnXBA=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H5,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
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
X-List-Received-Date: Fri, 25 Feb 2022 15:46:40 -0000

Hi Corinna,

On Tue, 22 Feb 2022, Corinna Vinschen wrote:

> On Feb 21 14:36, Johannes Schindelin wrote:
> > These symbolic links are crucial e.g. to support process substitution =
(Bash's
> > very nice `<(SOME-COMMAND)` feature).
> >
> > For various reasons, it is a bit cumbersome (or impossible) to generat=
e these
> > symbolic links in all circumstances where Git for Windows wants to use=
 its
> > close fork of the Cygwin runtime.
> >
> > Therefore, let's just handle these symbolic links as implicit, virtual=
 ones.
> >
> > If there is appetite for it, I wonder whether we should do something s=
imilar
> > for `/dev/shm` and `/dev/mqueue`? Are these even still used in Cygwin?
>
> "still used"?  These are the dirs to store POSIX semaphors, message
> queues and shared mem objects.

Okay. I guess we do not really use them in Git for Windows ;-)

> These have to be real on-disk dirs.

Could I ask you to help me understand why? Do they have to be writable? Or
do the things that are written into them have to be persisted between
Cygwin sessions?

I ask because it would be really helpful for Git for Windows if we could
get away with _not_ having those directories.

> > Johannes Schindelin (2):
> >   Implicitly support the /dev/fd symlink and friends
> >   Regenerate devices.cc
> >
> >  winsup/cygwin/Makefile.am        |    1 +
> >  winsup/cygwin/devices.cc         | 1494 ++++++++++++++++-------------=
-
> >  winsup/cygwin/devices.h          |    3 +-
> >  winsup/cygwin/devices.in         |    4 +
> >  winsup/cygwin/dtable.cc          |    3 +
> >  winsup/cygwin/fhandler.h         |   28 +
> >  winsup/cygwin/fhandler_dev_fd.cc |   53 ++
> >  7 files changed, 879 insertions(+), 707 deletions(-)
> >  create mode 100644 winsup/cygwin/fhandler_dev_fd.cc
>
> Pushed.

Thank you!
Dscho
