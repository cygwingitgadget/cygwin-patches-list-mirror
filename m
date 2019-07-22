Return-Path: <cygwin-patches-return-9506-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 124889 invoked by alias); 22 Jul 2019 08:07:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 124875 invoked by uid 89); 22 Jul 2019 08:07:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.2 required=5.0 tests=AWL,BAYES_50,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=ps, p.s, P.S, PS
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jul 2019 08:07:02 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mv3I0-1igKyv0fs8-00qxCh; Mon, 22 Jul 2019 10:06:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 44DF9A807D0; Mon, 22 Jul 2019 10:06:56 +0200 (CEST)
Date: Mon, 22 Jul 2019 08:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 0/4] Fix rename bug with socket files
Message-ID: <20190722080656.GA17868@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190721015238.2127-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190721015238.2127-1-kbrown@cornell.edu>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-SW-Source: 2019-q3/txt/msg00026.txt.bz2

Hi Ken,

On Jul 21 01:53, Ken Brown wrote:
> The last patch of this series fixes the bug reported here:
>=20
>   https://cygwin.com/ml/cygwin/2019-07/msg00139.html
>=20
> The first three patches do some cleanup of the is**device() methods.

Looks great, thanks for doing that.  Please push.


Corinna


P.S: Did you see https://cygwin.com/ml/cygwin/2019-07/msg00152.html, by
     any chance?  Looks like a regression from the new FIFO code.

--=20
Corinna Vinschen
Cygwin Maintainer
