Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 7903A3858D38
 for <cygwin-patches@cygwin.com>; Tue, 21 Jul 2020 07:36:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7903A3858D38
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mv3Ds-1koVtY3ckS-00r3iM; Tue, 21 Jul 2020 09:36:00 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E5F5BA82B90; Tue, 21 Jul 2020 09:35:59 +0200 (CEST)
Date: Tue, 21 Jul 2020 09:35:59 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: mmap: Remove AT_ROUND_TO_PAGE workaround
Message-ID: <20200721073559.GM16360@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>, cygwin-patches@cygwin.com
References: <20200720185543.183292-1-corinna-cygwin@cygwin.com>
 <6eee5eb3-e37b-0255-4cc7-f66774092a03@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6eee5eb3-e37b-0255-4cc7-f66774092a03@cornell.edu>
X-Provags-ID: V03:K1:wszHLN14HmoFIM7RH0/hIHZh15UeXmwOd9q55QJlsH+t+tCOkt6
 SVPG1XY5jVfz0TTEsYGjBqJi6PudEheJ3HZPJiyGIwEOvNAajpyidhw9CwSL0+4xBKYVBlq
 bW/9aQ6NW82mCnAmN6DOT00LKHn92p6VtA7y8KoMZin7pEjOgmXmiQzrhmOFwqw4YLeCT59
 a+KiUm9s/tR4z9ZyYIuyg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vF0m657FpoY=:bqKMONsoJWYUBsWepBHMXj
 YdtmBXrwHTe7S1/YABcbggOpXO2IYFCjknbcN2hmtC0zG9reSEkaAuVaO9mbix1XVArX1kHTK
 e2bLR4qxSp09qbmO9tSqkEQiwGcM4CCL8gpaEKSyfm9K22JhoQB3SJSeWFDtWNYUxBJoH+2xu
 /DwKFaNnhtbhKh3YnrOhTkItz4wz3lU5ZclG009e0y1TWJDr2NxJpz8y7CoJp0qszGzM/dTG5
 WTQ/sci85+gLYEwH5fE7TyqkNptc3p9LWrtXra7xjzmpJJ46mPJ9dDPbQJJONvxnmFFg0R9x+
 Ln5hymbqp59ddTibWK+pvXmOocoxmuyaTs7/c2/bXOEXlPqH9gwFOkBzjdoglILtNcGXfElOw
 tsXEKdMaCseiRbHaSVgyEG4ZCfKbssTFR5vPP9+iRuaBOAnEdQMOBJUb5PoypZ7LrmQH2XJF1
 3YhfAnPeuSLOmYdHqO9r7POsXk5OQxBVMqv4UFFBXMg1xpLVek+6/NdAmTOY/FjZnzaZ4QJ28
 BUe0eW1HqP2UvE8oFgdXqatt9AI2taqhpCPGnuBCkuwn8Ypk3mSvN88kLix+72/Gix11NNv21
 IcF3HY3vhmKKoHxgtNnJwtrUV5VqHWksEPqsIyHVvwMndtMyf2UWMRoOCEmX8YG2m3aLMHBWo
 e5P17JLKAz+SZIEWUQDvpmbxEkfy0meSPMXobUUH/shC1hQi4fEC135PxUmYLYODQNjwwXPs+
 dKEpZT/Ru8CQTE1lwuyOuGtC3fFJkisUZey7nB7/OfkqM/h1SNIi3szqID4CJXZdfFniTlsIa
 XbAoFMHSWsuoQb4tuwtUwoZqRzYrckSwDREAFBi6Y/nJG/GySBo3tlfqlwT2BJ/bClIALoIYg
 BSUf9GZQErhPtF+xnR9g==
X-Spam-Status: No, score=-104.4 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 21 Jul 2020 07:36:07 -0000

Hi Ken,

On Jul 20 17:26, Ken Brown via Cygwin-patches wrote:
> Hi Corinna,
> 
> On 7/20/2020 2:55 PM, Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > [...]
> > @@ -1089,6 +1073,7 @@ go_ahead:
> >       }
> >   #ifdef __x86_64__
> > +  orig_len = roundup2 (orig_len, pagesize);

Urgh, this line was supposed to go *outside* the #ifdef bracket.  Duh!

Thanks for catching.

> >     if (!wincap.has_extended_mem_api ())
> >       addr = mmap_alloc.alloc (addr, orig_len ?: len, fixed (flags));
> >   #else
> > [...]
> 
> I think you still left in some 32 bit code that should be removed, and also
> orig_len now doesn't get rounded up on 32 bit.  Here's an additional diff
> that I think is needed beyond your patch:
> 
> diff --git a/winsup/cygwin/mmap.cc b/winsup/cygwin/mmap.cc
> index 8ac96606c..fa9266825 100644
> --- a/winsup/cygwin/mmap.cc
> +++ b/winsup/cygwin/mmap.cc
> @@ -1009,20 +1009,8 @@ mmap64 (void *addr, size_t len, int prot, int flags,
> int fd, off_t off)
>           goto go_ahead;
>         }
>        fsiz -= off;
> -      /* We're creating the pages beyond EOF as reserved, anonymous pages.
> -        Note that 64 bit environments don't support the AT_ROUND_TO_PAGE
> -        flag, which is required to get this right for the remainder of
> -        the first 64K block the file ends in.  We perform the workaround
> -        nevertheless to support expectations that the range mapped beyond
> -        EOF can be safely munmap'ed instead of being taken by another,
> -        totally unrelated mapping. */
> -      if ((off_t) len > fsiz && !autogrow (flags))
> -       orig_len = len;
> -#ifdef __i386__
> -      else if (!wincap.is_wow64 () && roundup2 (len, wincap.page_size ())
> -                                     < roundup2 (len, pagesize))
> -       orig_len = len;
> -#endif
> +      /* We're creating the pages beyond EOF as reserved, anonymous
> +        pages if MAP_AUTOGROW is not set. */
>        if ((off_t) len > fsiz)
>         {
>           if (autogrow (flags))
> @@ -1037,9 +1025,12 @@ mmap64 (void *addr, size_t len, int prot, int flags,
> int fd, off_t off)
>                 }
>             }
>           else
> -           /* Otherwise, don't map beyond EOF, since Windows would change
> -              the file to the new length, in contrast to POSIX. */
> -           len = fsiz;
> +           {
> +             /* Otherwise, don't map beyond EOF, since Windows would change
> +                the file to the new length, in contrast to POSIX. */
> +             orig_len = len;
> +             len = fsiz;
> +           }

Oh, yes, that also simplifies the logic, great!

>         }
> 
>        /* If the requested offset + len is <= file size, drop MAP_AUTOGROW.
> @@ -1072,8 +1063,8 @@ go_ahead:
>         }
>      }
> 
> -#ifdef __x86_64__
>    orig_len = roundup2 (orig_len, pagesize);
> +#ifdef __x86_64__
>    if (!wincap.has_extended_mem_api ())
>      addr = mmap_alloc.alloc (addr, orig_len ?: len, fixed (flags));
>  #else
> 
> I'm attaching an amended commit.
> 
> I could easily have missed something, and I don't have a 32 bit OS to test
> on, so just ignore my changes if I'm wrong.
> 
> But I've retested the php test case, and it's still OK with this patch.
> 
> Ken

Thanks a lot for checking and the attached full patch!


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
