Return-Path: <marco.atzeri@gmail.com>
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by sourceware.org (Postfix) with ESMTPS id 76F03385802D
 for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020 08:17:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 76F03385802D
Received: by mail-ej1-x643.google.com with SMTP id k3so1150978ejj.10
 for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020 01:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=VT1RHdU506jvypNsKdgMbO5Gd9Ik8h1SFIEDdaGAzHA=;
 b=UXe8T7OA6qAJ48ZaR2r8+DPFQUmwb9lrid5syd+RYT0HNdZck+wTCb8d87qjLwGr/B
 4zDcdHDaFG8ZipY5yKIB4feLx1mkcqWgveisSDApyaNqmv7V+ugDDApnbIdeqTvk0mPb
 DfH8cHDLjEaLO0ZTjDjpUMQbAMPQprjHnR7/5YuqgdYsxnVNWU49qXDMyTFGyWZe1xWd
 YCXQkeBWoad8C4Zn/ISiD/l7cMKsDEwv5ihJxGquG0OyAfLaeH+HCNlt3vYJdInoMPU6
 p94l3gZy1JhuNzpCxLk0ZP29iVprL2Op6H59Vvws8Y6URWQJvFm7I2YJVAT1NmCY4puD
 KlXQ==
X-Gm-Message-State: AOAM533ROzjNv0eBYbX8ROB3tm1xdIxMSXomxkE3T6l1u5Q0A8kTx+uX
 HFgjMKZdduMW6HHxlDPlDhtiS57nilTkoGQqKmi2sleNngo=
X-Google-Smtp-Source: ABdhPJydezcdCCo9WzG8AY3i4BkYug2MQ+b2B68ujM4EeK1j8fLL8H03pcjtQzdoNvaOEzA2pGPYSW3yLTUiaDPIA2s=
X-Received: by 2002:a17:906:3b02:: with SMTP id
 g2mr905882ejf.512.1603441023275; 
 Fri, 23 Oct 2020 01:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
 <20201020134304.11281-4-jon.turney@dronecode.org.uk>
 <fe4bf082-427b-9611-39a5-8d50a79ba9f1@dronecode.org.uk>
 <20201021150727.GQ5492@calimero.vinschen.de>
In-Reply-To: <20201021150727.GQ5492@calimero.vinschen.de>
From: marco atzeri <marco.atzeri@gmail.com>
Date: Fri, 23 Oct 2020 10:16:52 +0200
Message-ID: <CAB8Xom-TYSsKCgSY6BEo-jj6p3wySbiyQdpkCajmzqoN9=8bXQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] gendef generates sigfe.s and cygwin.def
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM, GIT_PATCH_0,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 23 Oct 2020 08:17:15 -0000

On Wed, Oct 21, 2020 at 5:07 PM Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
>
> On Oct 21 15:31, Jon Turney wrote:
> > On 20/10/2020 14:43, Jon Turney wrote:
> > > Express that gendef generates sigfe.s and cygwin.def in a slightly less
> > > nutty way.
> > > ---
> > >   winsup/cygwin/Makefile.in | 5 +----
> > >   1 file changed, 1 insertion(+), 4 deletions(-)
> > >
> > > diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> > > index a56a311b8..9d05b17b3 100644
> > > --- a/winsup/cygwin/Makefile.in
> > > +++ b/winsup/cygwin/Makefile.in
> > > @@ -785,16 +785,13 @@ $(VERSION_OFILES): version.cc
> > >   Makefile: ${srcdir}/Makefile.in
> > >     /bin/sh ./config.status
> > > -$(DEF_FILE): gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
> > > +$(DEF_FILE) sigfe.s: gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
> > >     $(word 1,$^) --cpu=${target_cpu} --output-def=$@  --tlsoffsets=$(word 2,$^) $(wordlist 3,99,$^)
> >
> > Using $@ is wrong if make decides to build sigfe.s first, and $^ will
> > contain an unwanted $(DEF_FILE) from the dependency below.
> >
> > So please try the attached instead.
>
> With this patch, both architectures build and *drumrole* still
> seem to run fine.
>
> I'd say, ship it!
>
>
> Thanks,
> Corinna

Jon,
in the past sigfe.s was missing from the debuginfo
https://stackoverflow.com/questions/44770147/gdb-in-cygwin-is-missing-sigfe-s

and I assume it is still missing, can you double check ?

Thanks
Marco
