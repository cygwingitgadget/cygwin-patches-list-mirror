Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 98B0D3986418
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 18:15:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 98B0D3986418
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MelWf-1kqgDu0IoX-00aobq for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020
 20:14:59 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8A6F4A80637; Fri, 11 Sep 2020 20:14:58 +0200 (CEST)
Date: Fri, 11 Sep 2020 20:14:58 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-ID: <20200911181458.GM4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
 <20200911140601.GK4127@calimero.vinschen.de>
 <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
X-Provags-ID: V03:K1:M6tkdzK1dz8XYoXjmh7FN1unLVisuhKxzkwQEmP6ZxVf+iGpsM8
 /1GlPL6gtFNhGd/AzeVwG3Ui8zvDy3JIo0ocUFJDGpIktdfSy56UoytX5pcJQ8DAwU2+Jlh
 wsD6wYGUhxMNEe3QpVRub+vOYSQ9KjNmutMQGtpq06i7MamMT7eP1evE674dLQ20sns3kfc
 vitjKBgOTWWTxprQdeyDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q3dA3RHqjeA=:SSds41YYHRFeJsM9ddml0g
 Z9pifzgc8sqhvtCfRV44OiE1i0lE8nSG6tEVLUwo1N+8qpAdPdc4Jh7WwIMrKspc3IWFKshwB
 HVWldlJF1Uy+arvQN+E0u0/ya+7XOofSFWzYpRdNSdbvr6UYdlaokUqNLVMKIeEYRuSJFHO15
 PAdDsK+IuGTnK2HNjyGTPDBED/vLhB17w+0ytJc3R4BiGYhBz1nNVOEDiy+mQ8TmRvYtr7TUe
 PbcgCGAJr7LdvdQ1bNu1Q2FE04Su6FWFeqwLfn2b0mBEWIOz8MQPlLGAZEUgl5VrYLJS/0Qn3
 2wq4vOMdSZaWN8DwFLSv/wOyxZTR5uVz5ys911mHfgNiQhu7MkrOYTuMpZRyz8j7Z9lXHQtAw
 u9LomGMEHOs6HqEnPO37FNSx0pmannV5Tfg0VRjgsYBAUkXsCh9Ll6hKXe6myrAgEDAhfbthq
 0VEtbPg4zBqzI44NI735oB5tVuLVLvum7zCRf++c9G5wXbANzEkjSiqyeofDHk+/3k09psWzV
 6Azz8p7+SqYpiWEzGGLmIwOVlgJ+dwE4XZQvlXur5Z8eoYGN5uEsLEXqEeK9ejmXHhMtfZgC1
 lU5niuwvFjqbYSxgBMs7xgTwcCtOcz133Z/6seXrDe1hH7z5pBMv1sRvTroX8M/vNvUKjAnBQ
 mtFgoBRpFajZVhQmO5LC9pvyspLyVBSZ67zbwve9tPLLCIKUNXzyzT+NnTLb3IaSRMpRfWpGj
 n4lxfoWV4Fd0DPBjfZ8RXXZ17C2JqCJgp1Xt3ZOqTKWxOLaX7nGsCVexSMIgXSD+qh6QjmLGA
 Cyvz8VnXBBSewzBQ0RWX8ilKQY/wbcDNuWTyB907BV0DMtQ1N28PW/LIx5LA6SyJ/oGYOkEup
 IlMs4TdQTYbEJ99E886g==
X-Spam-Status: No, score=-100.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Fri, 11 Sep 2020 18:15:02 -0000

On Sep 12 01:05, Takashi Yano via Cygwin-patches wrote:
> On Fri, 11 Sep 2020 16:06:01 +0200
> Corinna Vinschen wrote:
> > On Sep 11 21:35, Takashi Yano via Cygwin-patches wrote:
> > > What do you mean by "just drop any handling"? 
> > > 
> > > Do you mean remove following if block?
> > > > > +  if (cp_from == CP_UTF7 || IS_ISO_2022 (cp_from) || IS_ISCII (cp_from))
> > > > > +    /* - MB_ERR_INVALID_CHARS does not work properly for UTF-7.
> > > > > +       - ISO-2022 is too complicated to handle correctly.
> > > > > +       - FIXME: Not sure what to do for ISCII.
> > > > >         Therefore, just convert string without checking */
> > > > >      wlen = MultiByteToWideChar (cp_from, 0, ptr_from, len_from,
> > > > >  				wbuf, NT_MAX_PATH);
> > > In this case, the conversion for ISO-2022, ISCII and UTF-7 will
> > > not be done correctly.
> > > 
> > > Or skip charset conversion if the codepage is EBCDIC, ISO-2022
> > > or ISCII? What should we do for UTF-7?
> > 
> > Nothing, just like for any other of these weird charsets.  Cygwin never
> > supported any charset which wasn't at least ASCII compatible in the
> > 0 <= x <= 127 range.  Just ignore them and the possibility that a
> > user chooses them for fun.
> > 
> > > What should happen if user or apps chage codepage to one of them?
> > 
> > Garbage output, I guess.  We shouldn't really care.
> 
> Do you mean a patch attached?

Yes.  I pushed it.  We should really not care for them.


Thanks,
Corinna
