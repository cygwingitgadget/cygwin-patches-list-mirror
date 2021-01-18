Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 10B933857C4E
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 14:39:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 10B933857C4E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M7KKA-1l6yoE3GjE-007lqf for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021
 15:39:34 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 35DEFA80988; Mon, 18 Jan 2021 15:39:34 +0100 (CET)
Date: Mon, 18 Jan 2021 15:39:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 01/11] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE first
Message-ID: <20210118143934.GG59030@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-2-ben@wijen.net>
 <20210118104534.GR59030@calimero.vinschen.de>
 <c96cefe7-3148-5d6b-5839-08f7dd85dc30@wijen.net>
 <20210118122211.GA59030@calimero.vinschen.de>
 <51b3e03d-9a97-d83f-1858-751a9a51394e@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51b3e03d-9a97-d83f-1858-751a9a51394e@wijen.net>
X-Provags-ID: V03:K1:7HpyAAm6ZS8lN21nE1/G1dMuOyyQ664TmtObf4wHtCO/30aoBO+
 iPtSp93YH8gEU//OB3/n/CVvRoDQf7f/4rCcXxHyuXz7QZMMmWt+MldLjT46SslyMbdZ3Ae
 XUP/LO8bUCsE2/eXkpVYST9R9otAQOn1joBN6gUW7p2X+Qict9oE6WbHhVQInLjOEuo8cef
 R4k7jGDRpdGxBTdE4/IaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:We1kiXkWJ80=:C+29LpBadqyJZqz5bm5tAT
 T6UWplhpAWf8cxGqS13NPHHa8sez3SweT8dPEuCaAkHeSeXKl1OBbJLCOsj3a1/P9bVAr6fSK
 OZbUDMz97E+pxRxZV94H5kp80kvR6he1eUSA5otaOkUQ1B7ylGGpOV8hrckYY+2hBr2NB1v4S
 TPVolEfnkRJE7BITVTlTAQuePXf2R9pdXBd5OIxK9dqcGXeSSW7fsT7wNVRKR7/PI2OkHfl1X
 9cxlhZ51XM9CuVW0KLPKN9TeZ10P2U5YmlfVJTletjmIxY3AxDb4jxrGEyvmEabMd5EuBN+Zz
 HbDkJUrLzWciKadFYfx50bHpkp6gN6GG+nqUObGzBzkCZv158MSlAdqoZar5zzN4YqvyDlBQk
 7Zt0g5aTVL3NO+oOUATywDYyzu7L29q2JD5EWNCP31NCxu6pBJ7oCl8GzIPVboDnrKfbcQP6s
 ScKaU+b5JA==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 18 Jan 2021 14:39:37 -0000

On Jan 18 15:30, Ben wrote:
> 
> 
> On 18-01-2021 13:22, Corinna Vinschen via Cygwin-patches wrote:
> > On Jan 18 13:11, Ben wrote:
> >>
> >>
> >> On 18-01-2021 11:45, Corinna Vinschen via Cygwin-patches wrote:
> >>> Rather than calling NtSetInformationFile here again, we should rather
> >>> just skip the transaction stuff on 1809 and later.  I'd suggest adding
> >>> another wincap flag like, say, "has_posix_ro_override", being true
> >>> for 1809 and later.  Then we can skip the transaction handling if
> >>> wincap.has_posix_ro_override () and just add the
> >>> FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE flag to fdie.Flags, if
> >>> it's available.
> >>
> >> Hmmm, I'm not sure if I follow you: This extra NtSetInformationFile is not
> >> related to the transaction stuff?
> > 
> > Right, sorry.  I meant the
> > 
> >   if (pc.file_attributes () & FILE_ATTRIBUTE_READONLY)
> > 
> > bracketed code in fact.  What I meant is to keep it at
> > 
> >   open
> >   if (ro)
> >     setattributes
> >   setinformation
> >   ...
> > 
> > and only add the required additional flag.
> 
> Ah, yes I understand. The extra NtSetInformation was there for
> the fallback without FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE
> 
> I have seen bordercases, but I have not seen NtSetInformation fail
> FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE and succeed without.
> Even if it would, Your suggestion does save a bunch of code...
> 
> > 
> > 
> >> Also I have seen NtSetInformationFile fail with STATUS_INVALID_PARAMETER.
> > 
> > That should only occur on pre-1809 then, and adding the extra wincap
> > would fix that.
> 
> Do note: This can also happen post-1809 with a driver that hasn't implemented it yet.

I'm sure, but that code path is called on non-remote ntfs only anyway.


Corinna
