Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 1B74E3858D28
 for <cygwin-patches@cygwin.com>; Wed,  8 Dec 2021 10:19:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1B74E3858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrhLu-1m9W0H1XPg-00nlRE for <cygwin-patches@cygwin.com>; Wed, 08 Dec 2021
 11:19:09 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 16E7FA80D32; Wed,  8 Dec 2021 11:19:05 +0100 (CET)
Date: Wed, 8 Dec 2021 11:19:05 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: clipboard: Fix a bug in read().
Message-ID: <YbCGmbAsZ4pJuttS@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
 <Ya9uU1JP8stQOB/l@calimero.vinschen.de>
 <c69ec6dd-fbbb-829c-9856-7f34cf0a792e@towo.net>
 <bc0170d9-1fcc-1659-beab-d11b01c37e5f@SystematicSw.ab.ca>
 <549e1dea-5545-50c5-fc1f-79c2c4982e8c@maxrnd.com>
 <20211208171929.68490866d4a07aac4b1ca0d7@nifty.ne.jp>
 <3e5ea337-8748-7c1c-813d-29196b6ef68a@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e5ea337-8748-7c1c-813d-29196b6ef68a@maxrnd.com>
X-Provags-ID: V03:K1:MFn2H/0DJZvBO/7G0vOwQ8m0fdGMYI4ZV94SEwFNUP7zwpUKTjO
 ouaZsTWNJ5SSfJbquM5an3nFsm9uKXtRF7J6ccpaQzYGrpSapcmf94NO3Cwji0ViG0kt6jj
 204F5wbfAazKSG+0IbsK6DaboXG7NU3qDuV5sACaYzkX4iB7L0DR72bfavDe50OqjpkhNk8
 xU0ENRiwpZ3wdzcsa/23w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dI15Eo6pxfg=:eN4KUtcj11oGZNmeFgd6IS
 1zyiESE8cmxqX0qc8SvOz4yS6JaJID02vUy0UJ/4FZCECYQ63B7/H2ha+W/Cb7Sc//4ACVmRC
 RPO/vdbMtqLcnhuwRkGyIrpd8E6wwCuCkOUwwAA9/DngVc2j9Wk6lIUcW6yU3wQDlxa2V4+z6
 TM87TftyV4KnlmV1xgDlbQRuM2yyO6yK/ErgTzn24Gx4ymaeb0F3cq9xlJ+wRT0nVhuhy5lKI
 03xb52roy1OJkkbTGnn2LIqaUDyOoIuPtYxcwjtEKfzzfx8pGvUKEF4y3eBlPpiIqDoCaxIeV
 gaNr7IZrnGVz5SO5e2EM2x63y1ECSpqrr5Kw08ssJYTgQKKv7EvcMS9fO/iFtzx09UmsScA/L
 chCRs7kZ6P8dhx1bfplMhYT0two3wUL4KFZNz6eGhe83IlJp7lIkpoSJl67LTqqI4toFb9odG
 mll854AsIV6x8SS1ljhMlnCchp1QoZPClIfe2Na9l4ZEPdDV2ZSRk6+NdZvY9gZb+KdzSFx7I
 wMRO5XWikDJz/eBffS1OLd6Du0XcztKRLBHDkox4qv3l1d3DrZaucrEFNktQcxqexY/9k56xS
 8KwAQOC4v9z7N6xLBSPbHC5h1b8H1MUhEzE1HU4etc8CJs13raEHMk6wgNS/co+KN5pROCbFo
 oMsF2Ozqh2hYiT3FSh77TDpqXKR6eWO81DQaeVFTU7IGDwr8bYP3VsbQVV6HQBvClsmMbWS7Y
 IqrEn0xhcA894Tfg
X-Spam-Status: No, score=-105.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H2,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 08 Dec 2021 10:19:13 -0000

On Dec  8 01:43, Mark Geisert wrote:
> Takashi Yano wrote:
> [...]
> > I think the following patch makes the intent clearer.
> > What do you think?
> > 
> > 
> >  From d0aee9af225384a24ac6301f987ce2e94f262500 Mon Sep 17 00:00:00 2001
> > From: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Date: Wed, 8 Dec 2021 17:06:03 +0900
> > Subject: [PATCH] Cygwin: clipboard: Make intent of the code clearer.
> > 
> > ---
> >   winsup/cygwin/fhandler_clipboard.cc   | 4 ++--
> >   winsup/cygwin/include/sys/clipboard.h | 1 +
> >   2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
> > index 05f54ffb3..65a3cad97 100644
> > --- a/winsup/cygwin/fhandler_clipboard.cc
> > +++ b/winsup/cygwin/fhandler_clipboard.cc
> > @@ -76,7 +76,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
> >         clipbuf->cb_sec  = clipbuf->ts.tv_sec;
> >   #endif
> >         clipbuf->cb_size = len;
> > -      memcpy (&clipbuf[1], buf, len); // append user-supplied data
> > +      memcpy (clipbuf->data, buf, len); // append user-supplied data
> >         GlobalUnlock (hmem);
> >         EmptyClipboard ();
> > @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
> >         if (pos < (off_t) clipbuf->cb_size)
> >   	{
> >   	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
> > -	  memcpy (ptr, (char *) (clipbuf + 1) + pos, ret);
> > +	  memcpy (ptr, clipbuf->data + pos, ret);
> >   	  pos += ret;
> >   	}
> >       }
> > diff --git a/winsup/cygwin/include/sys/clipboard.h b/winsup/cygwin/include/sys/clipboard.h
> > index 4c00c8ea1..b2544be85 100644
> > --- a/winsup/cygwin/include/sys/clipboard.h
> > +++ b/winsup/cygwin/include/sys/clipboard.h
> > @@ -44,6 +44,7 @@ typedef struct
> >       };
> >     };
> >     uint64_t      cb_size; // 8 bytes everywhere
> > +  char          data[];
> >   } cygcb_t;
> >   #endif
> 
> Sigh.  I guess it's not possible to keep rid of a data item like I'd hoped.
> At least "data[]" is cleaner than the historical "data[1]" here.  If you
> call the item cb_data I can live with it.
> Thanks all for the discussion.

  sometype *ptr;

  ptr = (sometype *) somebuffer;
  do_something (ptr + 1);

is a perfectly valid and perfectly readable thing, and used a lot if
"sometype" is either a header in a buffer followed by arbitrary data, or
if the buffer consists of multiple packed blocks of type "sometype".

Takashi's suggestion adds the information that "sometype" is a header
followed by arbitrary data, so that's a good thing..


Corinna
