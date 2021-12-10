Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id AC0EE3857C4A
 for <cygwin-patches@cygwin.com>; Fri, 10 Dec 2021 11:02:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AC0EE3857C4A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MhlXE-1mIA400Yvw-00dpjH for <cygwin-patches@cygwin.com>; Fri, 10 Dec 2021
 12:02:56 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 7AC8FA806FF; Fri, 10 Dec 2021 12:02:55 +0100 (CET)
Date: Fri, 10 Dec 2021 12:02:55 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: clipboard: Make intent of the code clearer.
Message-ID: <YbMz31+Yu1wlefXB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211208122645.1278-1-takashi.yano@nifty.ne.jp>
 <20211210195647.d9977a915a6968de33726804@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211210195647.d9977a915a6968de33726804@nifty.ne.jp>
X-Provags-ID: V03:K1:TuVXemt0stJKaVrT3SMQP14mG+fexlL1TF0Pqz34Nx4+8WYqC2L
 sqFhdVj5qU2whF2zmdzhUz08dExnameRBP+4cRofRvryr5/skgpJ8LPRo3u7IgGqe8NXypX
 tQqcR5MPtNSAms7hO6F5JaPz3ymODcQXj0/U/Rl3HDMci8g912farkMkNdorcelBrHyv+lv
 rTEa6uvszbsma2bSp85XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:edhN7yqY1j8=:wgZ/pliVJ6HSlWuRjnBW/Q
 spLSMg1jInXTTxqr6czMsofBJS6Vb7mqRaRdTUVF1SSxulQ7ZWQuHgikrdhi+lE14Hcubl67c
 P8lED1Rs6AcQZaCVEtsiO+JtQeq5GkYoCHO0MVOn/CiiZMIPbIf3guoQXhHmG9nQJxI107f/B
 hqcOkyVZH/SqC15ufP2X4d2+5uPqWiK7qo2hLSNC7q7oDxNwlhYm4Gw2/UPtPc91eFN2lo+YK
 rmQCjjZ9sTAs1+I4zTjk6W9ZGBDHEfQM5eUPSbn3GPcklgKzQwLCzmK5gdOA+16lSIUbBkclw
 4gnruDY1sapi7Jgoe85TmM/eCQzAi6shNyUw6Kc52dgUsaOOTDO5GczbsfnAwhXdMm/lZR7E7
 N27QNr1Uwnc4wsOvgSCAyewpt/MsGpW8Ug7z9nKHlXaPQO0S4PllbR7ijYjNMjdlEuTZIbUB3
 jyo5aC8IR/l36MneFqPUzCjNFE52EoLowqSfI1M/dyn2p7FJct1AaLwMXe/hvJ6XLFTX10cyS
 HK+hly2VkwkPORXP0vGN3zTIEm7EyH93An/lr/0Psj7csBTFU8hRDqNCmX0c2rkNB+jxcieS9
 K6Py0UmYXw11dzQxhTa28i18eWDYq58BdlO5noIo5SNRaD5Xr60L2LTgKjEPrXyEzwktimK39
 R/EBfCaOvsgrORm8SoaUEf7mWoNPPqH72g+1VwnSHRNx/D21yDSDseEXTwI4fuELR0TfyYqek
 zsZjFm1pHKyBCtV4
X-Spam-Status: No, score=-105.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 10 Dec 2021 11:02:59 -0000

On Dec 10 19:56, Takashi Yano wrote:
> On Wed,  8 Dec 2021 21:26:45 +0900
> Takashi Yano wrote:
> > ---
> >  winsup/cygwin/fhandler_clipboard.cc   | 4 ++--
> >  winsup/cygwin/include/sys/clipboard.h | 1 +
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
> > index 05f54ffb3..14820701c 100644
> > --- a/winsup/cygwin/fhandler_clipboard.cc
> > +++ b/winsup/cygwin/fhandler_clipboard.cc
> > @@ -76,7 +76,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
> >        clipbuf->cb_sec  = clipbuf->ts.tv_sec;
> >  #endif
> >        clipbuf->cb_size = len;
> > -      memcpy (&clipbuf[1], buf, len); // append user-supplied data
> > +      memcpy (clipbuf->cb_data, buf, len); // append user-supplied data
> >  
> >        GlobalUnlock (hmem);
> >        EmptyClipboard ();
> > @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
> >        if (pos < (off_t) clipbuf->cb_size)
> >  	{
> >  	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
> > -	  memcpy (ptr, (char *) (clipbuf + 1) + pos, ret);
> > +	  memcpy (ptr, clipbuf->cb_data + pos, ret);
> >  	  pos += ret;
> >  	}
> >      }
> > diff --git a/winsup/cygwin/include/sys/clipboard.h b/winsup/cygwin/include/sys/clipboard.h
> > index 4c00c8ea1..932fe98d9 100644
> > --- a/winsup/cygwin/include/sys/clipboard.h
> > +++ b/winsup/cygwin/include/sys/clipboard.h
> > @@ -44,6 +44,7 @@ typedef struct
> >      };
> >    };
> >    uint64_t      cb_size; // 8 bytes everywhere
> > +  char          cb_data[];
> >  } cygcb_t;
> >  
> >  #endif
> > -- 
> > 2.34.1
> 
> What should we do with this one?

Do your worst :)


Thanks,
Corinna
