Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 2E4C13890406
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 09:44:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2E4C13890406
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFbeI-1lERAI2vl8-00HA38 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021
 10:44:20 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DE36CA80D50; Fri, 22 Jan 2021 10:44:19 +0100 (CET)
Date: Fri, 22 Jan 2021 10:44:19 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: ptsname_r: always return an error number on
 failure
Message-ID: <20210122094419.GA810271@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210120180003.1458-1-kbrown@cornell.edu>
 <b7ae5752-cfce-0be8-92b5-81515d5a57d0@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b7ae5752-cfce-0be8-92b5-81515d5a57d0@cornell.edu>
X-Provags-ID: V03:K1:z9EiRdzQrY20N3LPLFNuuXn89NGK+PQZkg7CyIyl/uoIqRJiqqz
 wpQu3I5to6vmv/SKyJIeq99fC7FI220DeOkutBSJJc1nUFIcZ2Y8/tgPxyjmjqAsvGaDwUX
 wB/fvF8R2+UT45CAgHXb1a6cUrZuL45ri06ALYrSYd0BoVudZJ1wPQZnWNsmdzt8UdVN1Zl
 wp0TMH9EVJydPKndexiRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t44eGnlXrn4=:aXwuqERT0IlWfRNUcfhPbg
 cLXjAbj6kqGJqUS5yyRiec2HZD/Yy/OwJjW5arJcKPJcZ+moe/fVl6pRiHgcT/451ZHsN2B3k
 MIsVv/mWsSKdLO2lNCn/ZI6Ty9TmxuO+kWTpN9ej89NDJnoxAvqJy/RQiYqXXnCRJyPmsA7kn
 k6i0eKPyTPh+Yxr9J+oyYvtLxeU1+7st5XFoOaEVga0BUNBnQTU+7s+FiTtwKI0M/ilbWm3tG
 XvxWsg7b633NRRFEIEzF6hzVsE6Jo/GKJoBJwYNB1jbCadvQ/xbNMji8R78ltXWVkKjnmUetg
 3KVIONgD5LYGDol4ObCSD/C2lBAMz4dm8W0jJ1yVCR1oqfgVf45i/uQcrHD3FbcBODZcxvcK/
 p1ZUoBYf3JlYkHfU5Th2IZRsdM1j4rJryfmo2CGfCpEogAJw8iCBMe0jJ6pIA94rIYIpLAOOY
 m6Z/OrCuKslt5l4eV9PMdz2MRwCJo+E=
X-Spam-Status: No, score=-106.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 KAM_SHORT, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Fri, 22 Jan 2021 09:44:23 -0000

On Jan 21 17:48, Ken Brown via Cygwin-patches wrote:
> On 1/20/2021 1:00 PM, Ken Brown via Cygwin-patches wrote:
> > Following Linux, return ENOTTY on a bad file descriptor and also set
> > errno to ENOTTY.
> > 
> > Previously 0 was returned and errno was set to EBADF.  Returning 0
> > violates the requirement in
> > https://man7.org/linux/man-pages/man3/ptsname_r.3.html that an error
> > number should be returned on failure.  (That man page doesn't specify
> > setting errno.)
> > 
> > Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00245.html
> > ---
> >   winsup/cygwin/release/3.2.0 | 3 +++
> >   winsup/cygwin/syscalls.cc   | 5 ++++-
> >   2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/winsup/cygwin/release/3.2.0 b/winsup/cygwin/release/3.2.0
> > index 43725cec2..f748a9bc8 100644
> > --- a/winsup/cygwin/release/3.2.0
> > +++ b/winsup/cygwin/release/3.2.0
> > @@ -52,3 +52,6 @@ Bug Fixes
> >   - Fix the errno when a path contains .. and the prefix exists but is
> >     not a directory.
> >     Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00214.html
> > +
> > +- Fix the return value when ptsname_r(3) is called with a bad file descriptor
> > +  Addresses: https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00245.html
> > diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> > index 4742c6653..18d9e3f88 100644
> > --- a/winsup/cygwin/syscalls.cc
> > +++ b/winsup/cygwin/syscalls.cc
> > @@ -3364,7 +3364,10 @@ ptsname_r (int fd, char *buf, size_t buflen)
> >     cygheap_fdget cfd (fd);
> >     if (cfd < 0)
> > -    return 0;
> > +    {
> > +      set_errno (ENOTTY);
> > +      return ENOTTY;
> > +    }
> >     return cfd->ptsname_r (buf, buflen);
> >   }
> > 
> 
> I'm not really convinced we should blindly follow Linux here, when EBADF
> would seem to make more sense.  See
> 
>   https://lists.gnu.org/archive/html/bug-gnulib/2021-01/msg00264.html
> 
> Corinna, what's your preference?

EBADF actually makes more sense, as Bruno points out.

Please push, whatever you prefer.


Thanks,
Corinna
