Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 9AED93857C5C
 for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2020 15:07:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9AED93857C5C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MScDh-1ky5G50dJp-00T0bf for <cygwin-patches@cygwin.com>; Wed, 21 Oct 2020
 17:07:28 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 86A6DA81035; Wed, 21 Oct 2020 17:07:27 +0200 (CEST)
Date: Wed, 21 Oct 2020 17:07:27 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/6] gendef generates sigfe.s and cygwin.def
Message-ID: <20201021150727.GQ5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
 <20201020134304.11281-4-jon.turney@dronecode.org.uk>
 <fe4bf082-427b-9611-39a5-8d50a79ba9f1@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fe4bf082-427b-9611-39a5-8d50a79ba9f1@dronecode.org.uk>
X-Provags-ID: V03:K1:C1OM0DkOfm0hsl6f+EcYvBlvji+qyjQgZ2KqAlqvzz13QV5C1Ti
 zZMjZx7x/epyMswnyzdIlt+uS5CTiQ10x8VG6IwGxIrll42oT+NtWqbLPYZ/kBjXg9Kdo11
 jSriUn02YXrJYUqkT36psBTy6blqtz8+EOSuDs16aZzGU6guY+BkIYHMz2874vP0SElb3rX
 ZJQOCxGWJsEFxJOI9wE8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rbwuNAAUZB0=:8XXz9+0aWkgOSE/hoCzcBb
 OkiHkvxAGWGBLB9EjRm1mLCQVHm0iA2XX1a0h23oMeMyy+G9+CoQ87EG9MWhbDB1MDX2Em7ud
 D88diPKJiGJ7fValxeqRQ/06ytSk1P0ZLm4Cgpho03o0WZCWBrbg2AmHlo/T4Jrutzc3IfPpX
 9cqFz6DIQVapT3c6/w3g+TYo+59smlzJLKCkU2pYqEQQywo9VGwfXVXOuGx+g/Tg6o7jYT3UG
 8OYE3R13G3rFauMg3Pz8NvL6GAGl2kUDfDE1kVejUquyFXP5WW6O4cOW3DLXBXQek/BT81Ple
 BlqvEWRvCkfxPBeNM/oYk4/lx9I4QadvMrQ36zJgtnKNgp4FE7nwOu1NSHJ24M6zuU0t/jZI/
 RrPEsBLKSb6LJO+t4lPDc11d8qDi3enoKOOGYa3QQqN3hs/6L9Mf8KSoMTQdUpBxxRG3bKTdi
 CiAwRUFesA==
X-Spam-Status: No, score=-106.2 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 21 Oct 2020 15:07:40 -0000

On Oct 21 15:31, Jon Turney wrote:
> On 20/10/2020 14:43, Jon Turney wrote:
> > Express that gendef generates sigfe.s and cygwin.def in a slightly less
> > nutty way.
> > ---
> >   winsup/cygwin/Makefile.in | 5 +----
> >   1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> > index a56a311b8..9d05b17b3 100644
> > --- a/winsup/cygwin/Makefile.in
> > +++ b/winsup/cygwin/Makefile.in
> > @@ -785,16 +785,13 @@ $(VERSION_OFILES): version.cc
> >   Makefile: ${srcdir}/Makefile.in
> >   	/bin/sh ./config.status
> > -$(DEF_FILE): gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
> > +$(DEF_FILE) sigfe.s: gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
> >   	$(word 1,$^) --cpu=${target_cpu} --output-def=$@  --tlsoffsets=$(word 2,$^) $(wordlist 3,99,$^)
> 
> Using $@ is wrong if make decides to build sigfe.s first, and $^ will
> contain an unwanted $(DEF_FILE) from the dependency below.
> 
> So please try the attached instead.

With this patch, both architectures build and *drumrole* still
seem to run fine.

I'd say, ship it!


Thanks,
Corinna
