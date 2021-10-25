Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 368813858400
 for <cygwin-patches@cygwin.com>; Mon, 25 Oct 2021 08:28:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 368813858400
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MyNoa-1mtIuR1TEC-00ydpQ for <cygwin-patches@cygwin.com>; Mon, 25 Oct 2021
 10:28:55 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 72C87A80D4C; Mon, 25 Oct 2021 10:28:54 +0200 (CEST)
Date: Mon, 25 Oct 2021 10:28:54 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make native clipboard layout same for 32- and
 64-bit
Message-ID: <YXZqxvvYOnZspTbr@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211007052237.7139-1-mark@maxrnd.com>
 <20211008185210.cac713f28dea727a1467cf94@nifty.ne.jp>
 <29514de9-0d19-0d22-b8e1-3bfbce11589b@cornell.edu>
 <7dd31f61-43a1-4e4d-2e1a-dc79606263d5@dronecode.org.uk>
 <037a8027-8969-df1e-ccb5-6a736578cec5@cornell.edu>
 <6de24f8c-bd21-cd4f-18ff-ece3fef85b89@maxrnd.com>
 <ee8b46bd-f8f4-85da-be25-233c3cb60c71@cornell.edu>
 <YXLUkU6Nc3qAXLyp@calimero.vinschen.de>
 <20211024085823.909b894a0ae6c604f0216582@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211024085823.909b894a0ae6c604f0216582@nifty.ne.jp>
X-Provags-ID: V03:K1:8cOi9Y+RyzU+ZtK54t8KhjKag+s6fd0gRPWq1CPsgP626jKxTL9
 cKOtRECD7uiwcIRWfPaR/6nXDX2XuVhHb5gHr8xj9os13w7kLs+GTxPA4yJ/iLQDpuu+jlW
 kw1jp579xOPIlmrKR0MNLWsCOZI84+Thy8gZet2F4oOphXDSmeKGKRCGGDlRxMo6XnJwHGl
 5H4TOQuXNoSQzwD6YGigA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yA093AoLzQA=:MOxkWxtIRw1lgQ4Ll80F8c
 LCYetinYDdvsVfFDOMsIPmocN2npeaSXiDuyFHQQy+lv1MK08QbzUOaOc6xkoXJcF0ukUYIiJ
 NrsJoJ2gq+DqFryAHrhb/Fp2fOxuIesWHOGCc5z9UaSr8a+vU+6u3X8Uw36OagOxPI60mP82V
 eYkKTYowU2yr1kYrqwehpsj5DSVm0Jjk4BKLp7sq/P4tX6OZy9g+PNQjarMWvYmFARHhIHfVl
 4tlu3A1lDe6ne0o93oURmE0VpIwIM4VVoup8WbVHUd2vcXMLf5855ZsYl1SVwGl6GELHNtw1b
 f1kP473tQ40gJaZltgiuk/5b2D+k4SA6s+Y9hmSyqBc4WJbM3stmJzoXSWaWqgkad/QIHIqPd
 /i8s68EXbvbCh/X7VSEAbg3/pqxVuKM9dZIqzw3/Jc170AKjc+1SYT735w5krwLUJQDLmrniy
 Kq3qWz5mxA1FEGm273nyyYXMTqMjFmkEFlwYA6Znkc5dAiCKL9r5HJJupmZGCW2I3w3P5USEX
 qzCKezfkQ/yLymzW6AUXTU2XUfmjxJkplKXw+qwWM6IQXN/5TOoGy3kIp8cjYQNWKbJgBQtFa
 5qfPVXF5ma1UEuFEIUpNIhS4GkhjAwiit3DGdYxb7QcNCzeDFs3OZVvZMtqKqpb2NTb0X+TIj
 yeO++Q3jf/Ls8kjyLg2t5HfiYn6SyH5O9zRGgeWAbD/WXehCZMY3O7hREoX6EYo/3sby47weA
 yNN5Vu/mLUb918fG
X-Spam-Status: No, score=-99.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 25 Oct 2021 08:29:03 -0000

On Oct 24 08:58, Takashi Yano wrote:
> Hi Corinna,
> 
> On Fri, 22 Oct 2021 17:11:13 +0200
> Corinna Vinschen wrote:
> > Just to close this up prior to the 3.3.0 release...
> > 
> > Given we never actually strived for 32<->64 bit interoperability, it's
> > hard to argue why this should be different for the clipboard stuff.
> > 
> > Running 32 and 64 bit Cygwin versions in parallel doesn't actually make
> > much sense for most people anyway, unless they explicitely develop for
> > 32 and 64 bit systems under Cygwin.  From a productivity point of view
> > there's no good reason to run more than one arch.
> > 
> > So I agree with Ken here.  It's probably not worth the trouble.
> 
> Current code below in fhandler_clipboard.cc causes access violation
> if clipboard is accessed between 32 and 64 bit cygwin.
> 
>       cygcb_t *clipbuf = (cygcb_t *) cb_data;
> 
>       if (pos < (off_t) clipbuf->len)
>         {
>           ret = ((len > (clipbuf->len - pos)) ? (clipbuf->len - pos) : len);
>           memcpy (ptr, clipbuf->data + pos , ret);
>           pos += ret;
>         }
> 
> Don't you think this should be fixed?

Well, if you put it this way...

I didn't get that it's crashing, so yeah, in that case a fix would
be nice, of course.


Corinna
