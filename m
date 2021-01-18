Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 0744F3858025
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 12:22:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0744F3858025
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mzz6s-1lwAhJ2y86-00wz69 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 13:22:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2ABF0A80988; Mon, 18 Jan 2021 13:22:11 +0100 (CET)
Date: Mon, 18 Jan 2021 13:22:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 01/11] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE first
Message-ID: <20210118122211.GA59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-2-ben@wijen.net>
 <20210118104534.GR59030@calimero.vinschen.de>
 <c96cefe7-3148-5d6b-5839-08f7dd85dc30@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c96cefe7-3148-5d6b-5839-08f7dd85dc30@wijen.net>
X-Provags-ID: V03:K1:v/FnviM96ieKIIK0tSWeXdqgu/j32HKixBqhGVZ7fLVX1FIvQmU
 f3C9DfVBRoTOsJ1RmDs2i4Dm50HpQtyXB/ROwLATamtaL1H6s6j9IvGGF71HO77JeVQG3i7
 z885g42lpqS31tY47rVsqubhm4aLCVwm6hPZjrrsbWBaW3Q8ldD+CLHISLfQvgEh743Q5B0
 x7i16lvnXUDPZxTijwSNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BOdu97CePE4=:1ywnRag7vJut3j/QPjQuwe
 m+4KG1dfNb4TAN8Z1AtGDYvpwad9DfqizThBOGCAdatslTigmLSMG+59Q8GRFB6C9yLW+5jx1
 RsdNX3zXQ5soIddVvJxFI2Mh/GUDeL+AlkE68wFiHikgdG2npw55kJ55B0s4r6sKSO1tJ5PjJ
 rerOjO/kKAsvkMf/nHKZdwxcU2iZA6FpwLAkij+4MrWNGC60DaED+VzAbKuGHTTO6zYCXTnEc
 FmGopnyFbfoHam9zEig/B0JjfSYZpbH1DDEBrEDtHrOdd3ofHanmGQPBV6pm1Yn8XQ4geY2vj
 82Kgu9LVayIuQFogxt5OgxH8iDyJxVvFr6PaG6sGmR4hN+TQfG+44DmikDh/WLuDtfBesPik/
 PcOoWZypfL1nsufnS/+LrhGnKlNpqCDioYe9wSRFbnbnDLoYbu0HR06Q29hv+WO0rEsjBgKDw
 eRMMYV3zXg==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 18 Jan 2021 12:22:16 -0000

On Jan 18 13:11, Ben wrote:
> 
> 
> On 18-01-2021 11:45, Corinna Vinschen via Cygwin-patches wrote:
> > Rather than calling NtSetInformationFile here again, we should rather
> > just skip the transaction stuff on 1809 and later.  I'd suggest adding
> > another wincap flag like, say, "has_posix_ro_override", being true
> > for 1809 and later.  Then we can skip the transaction handling if
> > wincap.has_posix_ro_override () and just add the
> > FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE flag to fdie.Flags, if
> > it's available.
> 
> Hmmm, I'm not sure if I follow you: This extra NtSetInformationFile is not
> related to the transaction stuff?

Right, sorry.  I meant the

  if (pc.file_attributes () & FILE_ATTRIBUTE_READONLY)

bracketed code in fact.  What I meant is to keep it at

  open
  if (ro)
    setattributes
  setinformation
  ...

and only add the required additional flag.


> Also I have seen NtSetInformationFile fail with STATUS_INVALID_PARAMETER.

That should only occur on pre-1809 then, and adding the extra wincap
would fix that.

> So a retry without FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE is valid here.

That would be a border case which might then occur with the
FILE_DISPOSITION_POSIX_SEMANTICS flag, too.  The current code falls
through anyway, that should be sufficient, right?

> 
> I have thought about adding wincap.has_posix_unlink_semantics_with_ignore_readonly
> but it is equal to wincap.has_posix_rename_semantics so I didn't bother adding it.

It doesn't hurt to add another flag with the same values.  It's better
readable in context, which easily makes up for the extra bit :)


Corinna
