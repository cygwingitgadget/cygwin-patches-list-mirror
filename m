Return-Path: <SRS0=siFy=HI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id E7A9D4BA79A8
	for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 00:44:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E7A9D4BA79A8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E7A9D4BA79A8
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789519488; cv=none;
	b=a0hDeiOJiyYiYL0cf+xQlBRgW8k0YKWuVNVvZCTzIeVLAd/xClRzfMKF84i0qeirbWMXiqc2QJWozbSS1wcYmLuF/XACWmozObqd9riuTwY39Ut7u/KqOiI0oHOpoxd/nPEdJ6/Wd1NK9KFsxIb3T8z0qATXd2LTi/gBcw7HZuY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789519488; c=relaxed/simple;
	bh=7n/8unVlahXOpgnRsWXiov3itjzHaZ5xNU7a8gpRJDU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=EhPhbbWmczIlMYMKUVRLSFawG1r2ZGF0Wq6MaZgfS4tw7X9NfUyaMfO2zSjJZ2St39dkE9v4qH8+nkAIJ3igM82EU5sekXLqd0xU941we+IxGt4Ef3zt4LSEbdbfN/rNUQPa4ELOeqh4bxgZPIyiSb53gWpJR97z7htXEwqm5xk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dDErA/aB
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E7A9D4BA79A8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dDErA/aB
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260916004445575.PEGW.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 16 Sep 2026 09:44:45 +0900
Date: Wed, 16 Sep 2026 09:44:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: Fix compilation of c8rtomb with gcc 16
Message-Id: <20260916094445.8cd80eedecad1f1f0ca40891@nifty.ne.jp>
In-Reply-To: <20260916094143.4a692ca26a98c385910c30d4@nifty.ne.jp>
References: <20260601125055.1341979-1-jon.turney@dronecode.org.uk>
	<20260601125055.1341979-3-jon.turney@dronecode.org.uk>
	<20260916094143.4a692ca26a98c385910c30d4@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789519485;
 bh=oPvSlbR7DL+GpTdh0a4ktQtsPGJZcmcIEcKp39AnS/c=;
 h=Date:From:To:Subject:In-Reply-To;
 b=dDErA/aBY2j9uga9OiKZyxqIDWPOpYd/4xT5inWWSGq9jjOSa456XHxqKaYBugn/oFlrJDMk
 fVkYyPxtOTzzxQqj+jWJv8d35w1pJH7So2N3CKIP6zzzFgqKy/X1Tv6nyDWjBRQNOu0JzVKfdW
 m2kolZwh8WKjht8Q00H3Gr7HFH7VKlhf4uuCOJ2TgX0OLdVr8VHHC+pNCfi3Nd6QNZmk975sMH
 DmHJ0FBc2+f6MokFoBgkcEXAeQOdN/9ZGXfhD0uZVoV2DieIU7Yft5ucQQCY2XYRJ8mn8FSMU+
 SnUrrc9wndY1/SgqdcG2O9B2JeTf9XwdzONBFOEntxbxvw/g==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 16 Sep 2026 09:41:43 +0900
Takashi Yano wrote:
> Hi Jon,
> 
> On Mon,  1 Jun 2026 13:50:54 +0100
> Jon Turney wrote:
> > ../../../../src/winsup/cygwin/strfuncs.cc: In function ‘size_t c8rtomb(char*, char8_t, mbstate_t*)’:
> > ../../../../src/winsup/cygwin/strfuncs.cc:214:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
> > ../../../../src/winsup/cygwin/strfuncs.cc:215:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
> > ../../../../src/winsup/cygwin/strfuncs.cc:216:41: error: cannot bind non-const lvalue reference of type ‘char8_t&’ to a value of type ‘unsigned char’
> > ---
> >  winsup/cygwin/strfuncs.cc | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/winsup/cygwin/strfuncs.cc b/winsup/cygwin/strfuncs.cc
> > index 0cf41cefc..85427a0d1 100644
> > --- a/winsup/cygwin/strfuncs.cc
> > +++ b/winsup/cygwin/strfuncs.cc
> > @@ -211,9 +211,9 @@ c8rtomb (char *s, char8_t c8, mbstate_t *ps)
> >      {
> >        /* We already collected something... */
> >        int idx = ps->__count & 0x3;
> > -      char8_t &c1 = ps->__value.__wchb[0];
> > -      char8_t &c2 = ps->__value.__wchb[1];
> > -      char8_t &c3 = ps->__value.__wchb[2];
> > +      unsigned char &c1 = ps->__value.__wchb[0];
> > +      unsigned char &c2 = ps->__value.__wchb[1];
> > +      unsigned char &c3 = ps->__value.__wchb[2];
> >  
> >        switch (idx)
> >  	{
> 
> _mbstate_t (*ps) is defined as follows in
                      ^^^^^^^ declared

> libc/include/sys/_types.h:
> 
> #ifndef __machine_mbstate_t_defined
> /* Conversion state information.  */
> typedef struct
> {
>   int __count;
>   union
>   {
>     wint_t __wch;
>     unsigned char __wchb[4];
>   } __value;        /* Value so far.  */
> } _mbstate_t;
> #endif
> 
> _wchb[] is `unsigned char`, therefore, c1, c2, c3 should be
> `unsigned char`.
> 
> That is, your patch LGTM.
> 
> -- 
> Takashi Yano <takashi.yano@nifty.ne.jp>


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
