Return-Path: <cygwin-patches-return-9308-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48652 invoked by alias); 5 Apr 2019 16:48:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48606 invoked by uid 89); 5 Apr 2019 16:48:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=headache, occupied, chances, HX-Languages-Length:2050
X-HELO: mail-io1-f67.google.com
Received: from mail-io1-f67.google.com (HELO mail-io1-f67.google.com) (209.85.166.67) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 05 Apr 2019 16:48:16 +0000
Received: by mail-io1-f67.google.com with SMTP id v4so5552533ioj.5        for <cygwin-patches@cygwin.com>; Fri, 05 Apr 2019 09:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=gmail.com; s=20161025;        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;        bh=L4rJESQ+rWeSaz49g32g4P3L2yLpsJQFfevCbM1fC3g=;        b=BQJWEQsXlfi1OxxHkCjDH87S5WvWocxG7MpSGmVuerKt6l/F7MxWUbhFjkS+qWttKW         HfdWp3qHENIzW9k6yXaURuRQpgl0opCMyp8VSmeyK/Ue3DlNgh40ECsqBib66viNIPB8         56NT/2s62LOTznY7NIDAvyecO8FFcru5tg+NHmbwxEccGZGTueLAP8dDKR4LqQ7PZobH         62hKqygPhsMBusAVUnGfXuMWEMk6/4e75akkKQOMv1RYsvWbC0JSAVSJQVTglNSxXsi5         uz9odDc9KLpdLpxmzrYXjApgeJIIyuPP7L6kcQ9tdcbk036uBHRzUA5wCTHJsaj3I2T4         gVqg==
MIME-Version: 1.0
References: <8c77b589-fcae-fd0d-f5c5-c2520cfebbfa@ssi-schaefer.com> <20190326182538.GA4096@calimero.vinschen.de> <20190326182824.GB4096@calimero.vinschen.de> <c52ec077-d1e6-f61a-df9c-fe9ede1ba1ff@ssi-schaefer.com> <20190327091640.GE4096@calimero.vinschen.de> <b22069db-a300-56f7-33dd-30a1adbc0c93@ssi-schaefer.com> <20190328091507.GM4096@calimero.vinschen.de> <89dc8dca-c97b-ef79-6b90-bebb1b73c388@ssi-schaefer.com> <87o95u3n2p.fsf@Rainer.invalid>
In-Reply-To: <87o95u3n2p.fsf@Rainer.invalid>
From: "E. Madison Bray" <erik.m.bray@gmail.com>
Date: Fri, 05 Apr 2019 16:48:00 -0000
Message-ID: <CAOTD34b9nGSzitUeV244vWQzzeSrVNKUNVFEiW6p6TQKDQi=CA@mail.gmail.com>
Subject: Re: [PATCH RFC] fork: reduce chances for "address space is already occupied" errors
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-IsSubscribed: yes
X-SW-Source: 2019-q2/txt/msg00015.txt.bz2

On Thu, Mar 28, 2019 at 6:50 PM Achim Gratz wrote:
>
> Michael Haubenwallner writes:
> > It will not help for conflicts between dlls within a single package while this
> > package is built.  I'm thinking of python modules built within the python package
> > itself, where the just built modules are used within the very build process.  Not
> > sure if packages using local modules during build also do use fork then, though.
>
> It does help, that's the whole point.  But you will have to rebase all
> the in-processing DLL together, as the database will only have
> information on the installed DLL.  So if you build in stages, you'll
> need to do something like incremental autorebase does and collect all
> DLL into some file that you can then feed to
>
> rebase -sOT dlls_to_rebase
>
> That is slightly less convenient than using the database in persistent
> mode, but it is much less of a headache when you want to throw things
> away and start over since you don't need to worry about cruft in the
> database file.

That is essentially what I do for incremental builds; I keep
re-running rebase between stages with roughly those same flags and
this works.

However, I can see how this could be inconvenient for some Python
builds where you might have something within the setup.py script
(which, when building Python extension modules, is still usually used)
like (in pseudo-code):

    run_build_ext_command()
    import just_built_module
    # Use just_built_module to generate some files
    run_install_command()

all within the same process.  One could work around this by modifying
the setup.py to call `rebase` as a subprocess and that should work,
but it would suck to have to make such extra considerations just for
Cygwin, much less get some upstream project to accept that.

I don't know if what I described is at all similar to Michael's case,
and I've never run into a problem with this myself (even building
Numpy or SciPy).  But I could see it happening somehow...
